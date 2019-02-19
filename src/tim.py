#! /usr/bin/env python

import pddl_parser
import sys
import itertools

def build_property_map(task):
    properties = dict()
    counter = 0
    for predicate in task.predicates:
        #if predicate.name != "=":
        for i in range(1, len(predicate.arguments)+1):
            key = "{}_{}".format(predicate.name, i)
            properties[key] = counter
            counter += 1

    return properties

def PRS_to_string(PRS, inv_properties):
    precs = list()
    del_precs = list()
    adds = list()

    for i in range(len(PRS[0])):
        if PRS[0][i] > 0:
            precs.extend([inv_properties[i]*PRS[0][i]])

    for i in range(len(PRS[1])):
        if PRS[1][i] > 0:
            del_precs.extend([inv_properties[i] * PRS[1][i]])

    for i in range(len(PRS[2])):
        if PRS[2][i] > 0:
            adds.extend([inv_properties[i] * PRS[2][i]])

    str = "\tprecs: \t{}\n".format(", ".join(precs))
    str += "\tdel_precs: \t{}\n".format(", ".join(del_precs))
    str += "\tadds: \t{}".format(", ".join(adds))

    return  str



def transition_rule_to_string(T, inv_properties):
    E = list()
    S = list()
    F = list()

    for i in range(len(T[0])):
        if T[0][i] > 0:
            E.extend([inv_properties[i] * T[0][i]])

    if len(E) == 0:
        E.append("null")

    for i in range(len(T[1])):
        if T[1][i] > 0:
            S.extend([inv_properties[i] * T[1][i]])

    if len(S) == 0:
        S.append("null")

    for i in range(len(T[2])):
        if T[2][i] > 0:
            F.extend([inv_properties[i] * T[2][i]])

    if len(F) == 0:
        F.append("null")

    str = "{} => {} -> {}".format(", ".join(E), ", ".join(S), ", ".join(F))

    return str


def property_set_to_string(property_set, inv_properties):
    return "{{{}}}".format(", ".join([inv_properties[i] for i in range(len(property_set)) if property_set[i] == 1]))

def property_space_to_string(space, inv_properties):
    str = "{}\t%%%\t{}\t%%%\t{}\t%%%\t{}".format(property_set_to_string(space['property_set'], inv_properties),
                                  " | ".join([transition_rule_to_string(t, inv_properties) for t in space['transition_rules']]),
                                  ", ".join(space['objects']),
                                  " | ".join([property_set_to_string(state, inv_properties) for state in space['states']] ))
    return str


def extend_attribute_space(space, property_spaces):
    new_objects = set()
    space['marked'] = True
    for t in space['transition_rules']:
        if not any(t[1]):
            enablers = [i for i in range(len(t[0])) if t[0][i] > 0]
            for p in enablers:
                for s in property_spaces:
                    if s['property_set'][p] > 0:
                        if s['attribute_space'] and not s['marked']:
                            new_objects.update(extend_attribute_space(s, property_spaces))
                        else:
                            new_objects.update(s['objects'])
                        break
    space['objects'].update(new_objects)
    return new_objects

def find_types_for_property(property, patterns):
    types = list()
    for j in range(len(patterns.keys())):
        if property in patterns[patterns.keys()[j]]['properties']:
            types.append("T{}".format(j))
    return types

def is_superset_state(s, other):
    return ([k & l for k,l in zip(s, other)] == other) and any([k - l for k,l in zip(s, other)])

def build_predicate_arity_map(fd_task):
    predicate_arity_map = dict()
    for pred in fd_task.predicates:
        pred_arity = len(pred.arguments)
        predicate_arity_map[pred.name] = pred_arity
    return predicate_arity_map


def construct_identity_invariant(p, predicate_arity_map, property_type_map, patterns, num_invariants):
    predicate_name = p[:-2]
    position = int(p[-1])

    predicate_arity = predicate_arity_map[predicate_name]
    positions = [i for i in range(1, predicate_arity+1)]
    positions.remove(position)
    if predicate_arity > 1:

        num_invariants += 1

        str = "FORALL ?x:{}. ".format(" U ".join(find_types_for_property(p, patterns)))
        str2 = "(:derived (invariant-{})\n\t(forall".format(num_invariants)

        extra_variables = 2 * (predicate_arity - 1)
        for i in range(extra_variables):
            str += "".join(["FORALL ?y{}:{}.".format(i + 1, " U ".join(
                find_types_for_property("{}_{}".format(predicate_name, positions[j]), patterns))) for j in
                            range(len(positions))])
        # str2 += " ".join("?y{}".format(i+1) for i in range(extra_variables)) + " - object)\n\t\t(not (and "

        main_type = property_type_map[p]

        params = ["" for x in range(predicate_arity)]
        params[position - 1] = "?x"

        arguments = list()
        arguments.append("?x - {}".format(main_type))
        parts = list()
        for i in range(2):
            for j in range(len(positions)):
                params[positions[j]-1] = "?y{}".format((i+1)*(j+1))
                arguments.append("?y{} - {}".format((i + 1) * (j + 1), property_type_map["{}_{}".format(predicate_name, positions[j])]))
            str += "".join([" ({} {})".format(predicate_name, " ".join(params))])
            # str2 += "".join([" ({} {})".format(predicate_name, " ".join(params))])
            parts.append("".join([" ({} {})".format(predicate_name, " ".join(params))]))
            if i < 1:
                str += " AND "
        str += " -> y1 = y2"

        str2 += "({})\n".format(" ".join(arguments))
        str2 += "\t\t(not (and {}".format(" ".join(parts))
        str2 += " (not (= ?y1 ?y2)) ))))"



        # print(str)
        print(str2)
    return num_invariants


def construct_state_membership_invariant(space, fd_task, patterns, inv_properties):
    associated_types = set()
    for o in space['objects']:
        for i in range(len(patterns.keys())):
            if o in patterns[patterns.keys()[i]]['objects']:
                associated_types.add("T{}".format(i))

    if len(space['states']) < 2:
        return
    parts = list()
    for state in space['states']:
        properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
        parts.append("("+" AND ".join(properties)+")")

    print("FORALL x:{}. {}".format(" U ".join(associated_types), " OR ".join(parts)))

def construct_uniqueness_invariant(space, fd_task, patterns, inv_properties):
    associated_types = set()
    for o in space['objects']:
        for i in range(len(patterns.keys())):
            if o in patterns[patterns.keys()[i]]['objects']:
                associated_types.add("T{}".format(i))

    if len(space['states']) == 1:
        state = space['states'][0]
        properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
        print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(properties))))
    else:
        parts = list()
        for state in space['states']:
            properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
            parts.append("("+" AND ".join(properties)+")")

    print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(parts))))


def construct_binary_mutexes(space, predicate_arity_map, patterns, inv_properties):
    associated_types = set()
    for o in space['objects']:
        for i in range(len(patterns.keys())):
            if o in patterns[patterns.keys()[i]]['objects']:
                associated_types.add("T{}".format(i))

    exclusive_states = list()
    for s1 in space['states']:
        is_subset = False
        for s2 in space['states']:
            is_subset = is_subset | is_superset_state(s2, s1)
        if not is_subset:
            exclusive_states.append(s1)

    if len(exclusive_states) == 1:
        state = exclusive_states[0]
        properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
        # print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(properties))))
    else:
        binary_mutexes = itertools.combinations(exclusive_states, 2)
        for mutex in binary_mutexes:
            parts = list()
            mutex_parts = list()
            str = ""
            extra_variables = 0
            for state in mutex:
                properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
                parts.append("(" + " AND ".join(properties) + ")")
                state_parts = list()

                for property in properties:
                    predicate = property[:-2]
                    pos = int(property[-1])
                    predicate_arity = predicate_arity_map[predicate]
                    params = [None for _ in range(predicate_arity)]
                    for i in range(1, predicate_arity + 1):
                        if i == pos:
                            params[i-1] = "?x"
                        else:
                            extra_variables += 1
                            params[i-1] = "?y{}".format(extra_variables)
                    state_parts.append("({} {})".format(predicate, " ".join(params)))
                mutex_parts.append("(and {})".format(" ".join(state_parts)))
            str += "(:derived (invariant-#)\n\t(forall (?x {})\n".format(" ".join(["?y{}".format(j+1) for j in range(extra_variables)]))
            str += "\t\t(not (and {}))))".format(" ".join(mutex_parts))

            print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(parts))))
            print(str)


def build_property_type_map(fd_task):
    property_type_map = dict()

    for pred in fd_task.predicates:
        count = 0
        for arg in pred.arguments:
            count += 1
            property = "{}_{}".format(pred.name, count)
            property_type_map[property] = arg.type_name

    return property_type_map


def get_common_subtype(type1, type2, fd_task):
    if type1 == type2:
        return type1
    else:
        for d_type in fd_task.types:
            if d_type.name == type1:
                d_type1 = d_type
            elif d_type.name == type2:
                d_type2 = d_type

        if d_type1.name in d_type2.supertype_names:
            return d_type2.name
        else:
            return d_type1.name


def construct_binary_predicate_mutexes(space, predicate_arity_map, property_type_map, inv_properties, num_invariants, fd_task):

    valid_states = list()
    space_properties = set()
    for s in space['states']:
        state_properties = [inv_properties[i] for i in range(len(s)) if s[i] == 1]
        valid_state = set(state_properties)
        space_properties.update(state_properties)
        if valid_state not in valid_states:
            valid_states.append(valid_state)

    mutexes = set()
    for comb in itertools.combinations(space_properties, 2):
        if not any([set(comb).issubset(s) for s in valid_states]):
            mutexes.add(comb)

    for mutex in mutexes:
        prop1 = mutex[0]
        prop2 = mutex[1]

        main_type_1 = property_type_map[prop1]
        main_type_2 = property_type_map[prop2]
        main_type = get_common_subtype(main_type_1, main_type_2, fd_task)

        extra_variables = 0
        arguments = list()

        parts1 = [None for _ in range(predicate_arity_map[prop1[:-2]]+1)]
        parts1[0] = prop1[:-2]
        for i in range(1, predicate_arity_map[prop1[:-2]] + 1):
            if i == int(prop1[-1]):
                arguments.append("{} - {}".format("?x", main_type))
                parts1[i] = "?x"
            else:
                extra_variables += 1
                parts1[i] = "?y{}".format(extra_variables)
                prop = prop1[:-1] + str(i)
                arguments.append("{} - {}".format("?y{}".format(extra_variables), property_type_map[prop]))

        parts2 = [None for _ in range(predicate_arity_map[prop2[:-2]]+1)]
        parts2[0] = prop2[:-2]
        for i in range(1, predicate_arity_map[prop2[:-2]] + 1):
            if i == int(prop2[-1]):
                parts2[i] = "?x"
            else:
                extra_variables += 1
                parts2[i] = "?y{}".format(extra_variables)
                prop = prop2[:-1] + str(i)
                arguments.append("{} - {}".format("?y{}".format(extra_variables), property_type_map[prop]))

        num_invariants += 1
        invariant = "(:derived (invariant-{})\n\t(forall ({})\n".format(num_invariants, " ".join(arguments))
        invariant += "\t\t(not (and {}))))".format(" ".join(["({})".format(" ".join(parts1))] + ["({})".format(" ".join(parts2))]))
        print(invariant)
    return num_invariants


    #     for mutex in binary_mutexes:
    #         parts = list()
    #         mutex_parts = list()
    #         str = ""
    #         extra_variables = 0
    #         for state in mutex:
    #             properties = [inv_properties[i] for i in range(len(state)) if state[i] == 1]
    #             parts.append("(" + " AND ".join(properties) + ")")
    #             state_parts = list()
    #
    #             for property in properties:
    #                 predicate = property[:-2]
    #                 pos = int(property[-1])
    #                 predicate_arity = predicate_arity_map[predicate]
    #                 params = [None for _ in range(predicate_arity)]
    #                 for i in range(1, predicate_arity + 1):
    #                     if i == pos:
    #                         params[i-1] = "?x"
    #                     else:
    #                         extra_variables += 1
    #                         params[i-1] = "?y{}".format(extra_variables)
    #                 state_parts.append("({} {})".format(predicate, " ".join(params)))
    #             mutex_parts.append("(and {})".format(" ".join(state_parts)))
    #         str += "(:derived (invariant-#)\n\t(forall (?x {})\n".format(" ".join(["?y{}".format(j+1) for j in range(extra_variables)]))
    #         str += "\t\t(not (and {}))))".format(" ".join(mutex_parts))
    #
    #         print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(parts))))
    #         print(str)


def run_limited_instantiation(domain, problem, N=2):
    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain)
    fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem)
    fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

    print("=== Limited Instantiation with N={} (Rintanen 2017)".format(N))

    for d_type in fd_task.types:
        type_name = d_type.name

        prms_a_list = list()
        for action in fd_task.actions:
            prms_a = 0
            for parameter in action.parameters:
                if parameter.type_name == type_name:
                    prms_a += 1
            prms_a_list.append(prms_a)

        prms_p_list = list()
        for predicate in fd_task.predicates:
            if predicate.name == '=':
                continue
            prms_p = 0
            for argument in predicate.arguments:
                if argument.type_name == type_name:
                    prms_p += 1
            prms_p_list.append(prms_p)

        max_prms_a = max(prms_a_list)
        max_prms_p = max(prms_p_list)

        L = max(max_prms_a, max_prms_p) + (N-1)*max_prms_p

        print("For type <{}>: {} objects".format(type_name, L))





    pass


def run_TIM(domain, problem):

    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain)
    fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem)
    fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

    properties = build_property_map(fd_task)
    inv_properties = {v: k for k, v in properties.iteritems()}
    num_properties = len(properties)

    predicate_arity_map = build_predicate_arity_map(fd_task)

    ### Construct base PRSs (Section 2.3)
    provisional_Ps = list()
    for action in fd_task.actions:
        type_list = [p.name for p in action.parameters]
        prs_count = 0

        for type in type_list:
            prs_count = prs_count +1

            precs = [0 for i in range(num_properties)]
            del_precs = [0 for i in range(num_properties)]
            adds = [0 for i in range(num_properties)]

            if action.precondition.parts:
                for pre in action.precondition.parts:
                    if type in pre.args:
                        index = pre.args.index(type) + 1
                        property = "{}_{}".format(pre.predicate, index)
                        precs[properties[property]] += 1
            else:
                if type in action.precondition.args:
                    index = action.precondition.args.index(type) + 1
                    property = "{}_{}".format(action.precondition.predicate, index)
                    precs[properties[property]] += 1

            for eff in action.effects:
                literal = eff.literal
                if type in literal.args:
                    index = literal.args.index(type) + 1
                    property = "{}_{}".format(literal.predicate, index)
                    if not literal.negated:
                        adds[properties[property]] += 1
                    else:
                        del_precs[properties[property]] += 1

            P = (precs, del_precs, adds)

            provisional_Ps.append(P)

    ### Second PRS phase
    Ps = list()
    for P in provisional_Ps:
        exchanged_properties = [k & l for k,l in zip(P[1], P[2])]
        if any(exchanged_properties):
            exchanged_properties_indexes = [i for i in range(len(exchanged_properties)) if exchanged_properties[i] == 1]

            # PRS for the exchanged properties
            for i in exchanged_properties_indexes:
                mask = [0 for x in range(num_properties)]
                mask[i] = 1

                new_P = (P[0], mask, mask)

                Ps.append(new_P)

                P[1][i] -= 1
                P[2][i] -= 1

            Ps.append(P)

        else:
            Ps.append(P)

    print("=== PRS List ===")
    for i in range(1, len(Ps)+1):
        print("PRS {}:\n{}".format(i,PRS_to_string(Ps[i-1], inv_properties)))


    ### Construct transition rules (Section 2.3)
    Ts = list()
    for P in Ps:
        if not any(P[1]):
            # Increasing attribute transition rule
            for i in range(len(P[2])):
                if P[2][i] > 0:
                    E = [k-l for k,l in zip(P[0],P[1])]
                    S = [0 for _ in P[0]]
                    F = [0 for _ in P[0]]
                    F[i] = 1
                    T = (E, S, F)
                    Ts.append(T)
        elif not any(P[2]):
            # Decreasing attribute transition rule
            for i in range(len(P[1])):
                if P[1][i] > 0:
                    E = [k - l for k, l in zip(P[0], P[1])]
                    S = [0 for _ in P[0]]
                    F = [0 for _ in P[0]]
                    S[i] = 1
                    T = (E, S, F)
                    Ts.append(T)
        elif not any(P[0]):
            # Last special case
            for i in range(len(P[2])):
                if P[2][i] > 0:
                    E = [0 for _ in P[0]]
                    S = [0 for _ in P[0]]
                    F = [0 for _ in P[0]]
                    F[i] = 1
                    T = (E, S, F)
                    Ts.append(T)
        else:
            E = [k-l for k,l in zip(P[0],P[1])]
            T = (E, P[1], P[2])
            Ts.append(T)


    # Ts = list()
    # for P in Ps:
    #     E = [k-l for k,l in zip(P[0],P[1])]
    #     T = (E, P[1], P[2])
    #     Ts.append(T)

    print("=== Transition rules ===")
    for i in range(1, len(Ts)+1):
        print("TR {}:\n\t{}".format(i, transition_rule_to_string(Ts[i-1], inv_properties)))


    ### Seed property and attribute spaces (Section 2.3)
    # Build united sets of properties
    property_sets = set()
    for T in Ts:
        aux = [k | l for k, l in zip(T[1], T[2])]
        for T2 in Ts:
            aux2 = [k | l for k, l in zip(T2[1], T2[2])]
            if any([k & l for k, l in zip(aux, aux2)]):
                aux = [k | l for k, l in zip(aux, aux2)]
        if any(aux):
            property_sets.add(tuple(aux))

    property_sets = list(property_sets)


    # Initialize property and attribute spaces
    property_spaces = list()
    for i in range(len(property_sets)):
        property_spaces.append({"property_set":property_sets[i], "transition_rules": [], "states": [], "objects": set(), "attribute_space": False})


    ### Assign transition rules (Section 2.4)
    for property_space in property_spaces:
        associated_rules = list()
        for T in Ts:
            if any([k & l for k,l in zip(property_space["property_set"], T[1])]) or any([k & l for k,l in zip(property_space["property_set"], T[2])]):
                associated_rules.append(T)
                if not any(T[1]) or not any(T[2]):
                    property_space['attribute_space'] = True
                    property_space['marked'] = False
        property_space["transition_rules"] = associated_rules



    # Analyse initial state (Section 2.4)
    for obj in fd_task.objects:
        obj_properties = [0 for x in range(num_properties)]
        for atom in fd_task.init:
            # if atom.predicate != "=" and obj.name in atom.args:
            if obj.name in atom.args:
                index = atom.args.index(obj.name) + 1
                property = "{}_{}".format(atom.predicate, index)
                obj_properties[properties[property]] = 1

        for property_space in property_spaces:
            b = [k & l for k,l in zip(property_space['property_set'], obj_properties)]
            if any(b):
                property_space['objects'].add(obj.name)
                if not property_space['attribute_space'] and b not in property_space['states']:
                    property_space['states'].append(b)

    ### Extend property spaces (Section 2.4)
    for p in property_spaces:
        if not p['attribute_space']:
            newgen = list()
            for s in p['states']:
                for t in p['transition_rules']:
                    aux = [k & l for k,l in zip(s, t[1])]
                    if aux == t[1]:
                        new_s = [k^l for k,l in zip(s,aux)]
                        new_s = [k | l for k,l in zip(new_s, t[2])]
                        #REVISAR SUPERSETS
                        for s2 in newgen:
                            if is_superset_state(new_s, s2):
                                p['attribute_space'] = True
                        if new_s not in p['states'] and new_s not in newgen:
                            newgen.append(new_s)
            if not p['attribute_space']:
                p['states'].extend(newgen)


    ### Extend attribute spaces (Section 2.4)
    changes = True
    while changes:
        changes = False
        for space in property_spaces:
            if space['attribute_space'] and not space['marked']:
                added_objects = extend_attribute_space(space, property_spaces)
                if len(added_objects) > 0:
                    changes = True

    print("=== Property spaces ===")
    for i in range(1, len(property_spaces)+1) :
        print("PS {}:\n\t{}".format(i, property_space_to_string(property_spaces[i-1], inv_properties)))


    ### Identify types (Section 2.6)
    patterns = dict()
    for o in fd_task.objects:
        object_name = o.name
        pattern = [0 for x in range(len(property_spaces))]
        object_properties = set()
        for i in range(len(pattern)):
            if object_name in property_spaces[i]['objects']:
                pattern[i] = 1
                object_properties.update([inv_properties[j] for j in range(len(property_spaces[i]['property_set'])) if property_spaces[i]['property_set'][j] == 1 ])
        pattern = tuple(pattern)
        aux = patterns.get(pattern, {'objects': list(), 'properties': set()})
        aux['objects'].append(object_name)
        aux['properties'].update(object_properties)
        patterns[pattern] = aux

    print("=== Types ===")
    for i in range(len(patterns)):
        print("Type {}: {}".format(i, ", ".join(patterns[patterns.keys()[i]]['objects'])))


    property_type_map = build_property_type_map(fd_task)

    num_invariants = 0
    print("=== Invariants ===")
    ### Construct invariants (Section 2.7)
    for space in property_spaces:
        if not space['attribute_space']:
            property_set = [inv_properties[i] for i in range(len(space['property_set'])) if space['property_set'][i] == 1]
            for p in property_set:
                num_invariants = construct_identity_invariant(p, predicate_arity_map, property_type_map, patterns, num_invariants)
            # construct_state_membership_invariant(space, fd_task, patterns, inv_properties)
            # construct_uniqueness_invariant(space, fd_task, patterns, inv_properties)
            # construct_binary_mutexes(space, predicate_arity_map, patterns, inv_properties)
            num_invariants = construct_binary_predicate_mutexes(space, predicate_arity_map, property_type_map, inv_properties, num_invariants, fd_task)


    # ### Sub-space analysis (Section 2.7.1)
    # property_subspaces = list()
    # for space in property_spaces:
    #     space_types = dict()
    #     for space_object in space['objects']:
    #         for k in patterns.keys():
    #             if space_object in patterns[k]['objects']:
    #                 aux = space_types.get(k,set())
    #                 aux.add(space_object)
    #                 space_types[k] = aux
    #     if len(space_types.keys()) > 1:
    #         for k in space_types.keys():
    #             new_subspace = {"property_set":space['property_set'], "transition_rules": [], "states": [], "objects": space_types[k], "attribute_space": False}
    #             for t in space['transition_rules']:
    #                 rule_enablers = set([inv_properties[i] for i in range(len(t[0])) if t[0][i] > 0])
    #                 if rule_enablers.intersection(patterns[k]['properties']) == rule_enablers or len(rule_enablers) == 0:
    #                     new_subspace["transition_rules"].append(t)
    #                     if not any(t[1]) or not any(t[2]):
    #                         property_space['attribute_space'] = True
    #                         property_space['marked'] = False
    #             property_subspaces.append(new_subspace)
    #
    #
    # # Analyse initial state for subspaces
    # for obj in fd_task.objects:
    #     obj_properties = [0 for x in range(num_properties)]
    #     for atom in fd_task.init:
    #         # if atom.predicate != "=" and obj.name in atom.args:
    #         if obj.name in atom.args:
    #             index = atom.args.index(obj.name) + 1
    #             property = "{}_{}".format(atom.predicate, index)
    #             obj_properties[properties[property]] = 1
    #
    #     for property_space in property_subspaces:
    #         b = [k & l for k, l in zip(property_space['property_set'], obj_properties)]
    #         if any(b):
    #             property_space['objects'].add(obj.name)
    #             if not property_space['attribute_space'] and b not in property_space['states']:
    #                 property_space['states'].append(b)
    #
    # ### Extend property subspaces (Section 2.4)
    # for p in property_subspaces:
    #     if not p['attribute_space']:
    #         newgen = list()
    #         for s in p['states']:
    #             for t in p['transition_rules']:
    #                 aux = [k & l for k, l in zip(s, t[1])]
    #                 if aux == t[1]:
    #                     new_s = [k ^ l for k, l in zip(s, aux)]
    #                     new_s = [k | l for k, l in zip(new_s, t[2])]
    #                     # REVISAR SUPERSETS
    #                     for s2 in newgen:
    #                         if is_superset_state(new_s, s2):
    #                             p['attribute_space'] = True
    #                     if new_s not in p['states'] and new_s not in newgen:
    #                         newgen.append(new_s)
    #         if not p['attribute_space']:
    #             p['states'].extend(newgen)
    #
    # print("=== Property sub-spaces ===")
    # for i in range(1, len(property_subspaces) + 1):
    #     print("PS {}:\n\t{}".format(i, property_space_to_string(property_subspaces[i - 1], inv_properties)))
    #
    #
    # print("=== Sub-space Invariants ===")
    # ### Construct invariants (Section 2.7)
    # for space in property_subspaces:
    #     if not space['attribute_space']:
    #         property_set = [inv_properties[i] for i in range(len(space['property_set'])) if
    #                         space['property_set'][i] == 1]
    #         for p in property_set:
    #             num_invariants = construct_identity_invariant(p, predicate_arity_map, property_type_map, patterns,
    #                                                           num_invariants)
    #         construct_state_membership_invariant(space, fd_task, patterns, inv_properties)
    #         construct_uniqueness_invariant(space, fd_task, patterns, inv_properties)
    #         # construct_binary_mutexes(space, predicate_arity_map, patterns, inv_properties)


if __name__ == "__main__":
    try:
        domain = sys.argv[1]
        problem = sys.argv[2]
    except:
        print "Usage:"
        print sys.argv[0] + " <domain> <problem>"
        sys.exit(-1)
    run_limited_instantiation(domain, problem)
    run_TIM(domain, problem)

