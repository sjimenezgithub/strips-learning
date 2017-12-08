import pddl_parser
import sys

def build_property_map(task):
    properties = dict()
    counter = 0
    for predicate in task.predicates:
        if predicate.name != "=":
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

def construct_identity_invariant(p, fd_task, patterns):
    predicate_name = p[:-2]
    position = int(p[-1])
    for pred in fd_task.predicates:
        if pred.name == predicate_name:
            predicate_arity = len(pred.arguments)
            prop_to_type = dict()
            for i in range(1, predicate_arity+1):
                prop = "{}_{}".format(predicate_name, i)
                aux = list()
                for j in range(len(patterns.keys())):
                    if prop in patterns[patterns.keys()[j]]['properties']:
                        aux.append("T{}".format(j))
                prop_to_type[prop] = aux
            break
    str = "FORALL x:{}. ".format(" U ".join(prop_to_type.pop(p)))
    if predicate_arity > 1:
        str += "".join(["FORALL y{}:{}.".format(i+1, " U ".join(prop_to_type[prop_to_type.keys()[0]])) for i in range(2)])
        params = ["" for x in range(predicate_arity)]
        params[position - 1] = "x"
        if position == 1:
            other_pos = 2
        else:
            other_pos = 1
        for i in range(2):
            params[other_pos-1] = "y{}".format(i+1)
            str += "".join([" ({} {})".format(predicate_name, " ".join(params))])
            if i < 1:
                str += " AND "
        str += " -> y1 = y2"
    else:
        str += "".join(["({} {})".format(predicate_name, "x")])
    print(str)

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
        parts.append(" AND ".join(properties))

    print("FORALL x:{}. {}".format(" U ".join(associated_types), " OR ".join(parts)))

def construct_uniqueness_invariant(space, fd_task, patterns, inv_properties):
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
        parts.append(" AND ".join(properties))

    print("FORALL x:{}. {}".format(" U ".join(associated_types), "NOT ({})".format(" AND ".join(parts))))


def run_TIM(domain, problem):

    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain)
    fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem)
    fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

    properties = build_property_map(fd_task)
    inv_properties = {v: k for k, v in properties.iteritems()}
    num_properties = len(properties)

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

            for pre in action.precondition.parts:
                if type in pre.args:
                    index = pre.args.index(type) + 1
                    property = "{}_{}".format(pre.predicate, index)
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
    # REVISAR
    Ts = list()
    for P in Ps:
        E = [k-l for k,l in zip(P[0],P[1])]
        T = (E, P[1], P[2])
        Ts.append(T)

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
    # print("Porperty spaces:")
    # for property_set in property_sets:
    #     print("\t"+property_set_to_string(property_set, inv_properties))
    # print("\n")

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
            if atom.predicate != "=" and obj.name in atom.args:
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
                        if new_s not in p['states'] and new_s not in newgen:
                            newgen.append(new_s)
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

    print("=== Invariants ===")
    ### Construct invariants (Section 2.7)
    for space in property_spaces:
        if not space['attribute_space']:
            property_set = [inv_properties[i] for i in range(len(space['property_set'])) if space['property_set'][i] == 1]
            # for p in property_set:
            #     construct_identity_invariant(p, fd_task, patterns)
            construct_state_membership_invariant(space, fd_task, patterns, inv_properties)
            construct_uniqueness_invariant(space, fd_task, patterns, inv_properties)

    pass

if __name__ == "__main__":
    try:
        run_TIM(sys.argv[1], sys.argv[2])
    except:
        print "Usage:"
        print sys.argv[0] + " <domain> <problem>"
        sys.exit(-1)
