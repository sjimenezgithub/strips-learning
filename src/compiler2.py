#! /usr/bin/env python
import glob, os, sys, copy, itertools
import pddl, pddl_parser
import config, fdtask_to_pddl

def get_all_types(task, itype):
   output=[itype]
   # for i in task.types:
   #    if itype in i.name:
   #       if i.basetype_name!="object":
   #          output = output + [str(i.basetype_name)]
   for t in task.types:
       if t.basetype_name == itype:
           output.append(str(t.name))
   return output


def get_max_steps_from_plans(ps):
    iout = 0
    for plan in ps:
        iout = max(iout, len(plan))
    return iout


def get_max_vars_from_plans(ps):
    iout = 0
    for plan in ps:
        for a in plan:
            iout = max(iout, len(a.split(" ")) - 1)
    return iout


def get_action_schema_from_plans(ps, task):
    known_actions = [a.name for a in task.actions]
    schemas = []
    for plan in ps:
        for a in plan:
            counter = 0
            name = a.replace("(", "").replace(")", "").split(" ")[0]
            item = [name]
            for p in a.replace("(", "").replace(")", "").split(" ")[1:]:
                for o in task.objects:
                    if p.upper() == o.name.upper():
                        item.append(str(o.type_name))
                        counter = counter + 1
                        break
            if item not in schemas:
                schemas.insert(0, item)
    return [x for x in schemas if x[0] not in known_actions], [x for x in schemas if x[0] in known_actions]


def get_predicates_schema_from_plans(task):
    preds = []
    for p in task.predicates:
        item = []
        if p.name == "=":
            continue
        item.append(p.name)
        for a in p.arguments:
            item.append(a.type_name)
        preds = preds + [item]
    return preds

def get_static_predicates(tasks, predicates):

    candidates = set([p[0] for p in predicates])

    for task in tasks:
        task_candidates = set()
        for predicate in candidates:
            init_predicates = set([p for p in task.init if p.predicate == predicate])
            goal_predicates = set([p for p in task.goal.parts if p.predicate == predicate and p.negated == False])

            if init_predicates == goal_predicates:
                task_candidates.add(predicate)

        candidates = candidates.intersection(task_candidates)

    reflexive_static_predicates = dict()
    for candidate in candidates:
        reflexive_static_predicates[candidate] = True
        for task in tasks:
            init_predicates = set([p for p in task.init if p.predicate == candidate])
            for predicate in init_predicates:
                if len(predicate.args) == 1 or len(set(predicate.args)) != 1:
                    reflexive_static_predicates[candidate] = False
                    break

    return [p for p in predicates if p[0] in candidates], reflexive_static_predicates

def get_static_precondition(predicate, action, plans, tasks):
    static_preconditions = set()
    params = [pddl.pddl_types.TypedObject("?o" + str(i), action[i]) for i in range(1, len(action))]
    params = [x for x in params if x.type_name in predicate[1:]]
    num_predicate_params = len(predicate[1:])
    possible_param_tuples = list(itertools.combinations(params, num_predicate_params))
    for t in possible_param_tuples:
        static_preconditions.add(pddl.conditions.Atom(predicate[0], [x.name for x in t]))
        static_preconditions.add(pddl.conditions.Atom(predicate[0], [x.name for x in reversed(t)]))

    if len([x for x in action[1:] if x in predicate[1:]]) >= num_predicate_params:
        all_instances = set()
        for task in tasks:
            all_instances.update([p.args for p in task.init if p.predicate == predicate[0]])

        all_variables = set(sum(all_instances, ()))

        for a in [item for sublist in plans for item in sublist]:
            a = a.replace('(','').replace(')','').split(" ")
            if a[0] == action[0]:
                variables = [x for x in a[1:] if x in all_variables]
                possible_tuples = list(itertools.combinations(variables, num_predicate_params))


                static_preconditions_candidates = set()

                for i in range(len(possible_tuples)):
                    if possible_tuples[i] in all_instances:
                        static_preconditions_candidates.add(pddl.conditions.Atom(predicate[0], [x.name for x in possible_param_tuples[i]]))
                    elif tuple(reversed(possible_tuples[i])) in all_instances:
                        static_preconditions_candidates.add(pddl.conditions.Atom(predicate[0], [x.name for x in reversed(possible_param_tuples[i])]))

                static_preconditions = static_preconditions.intersection(static_preconditions_candidates)



    return list(static_preconditions)

def possible_pred_for_action(task, p, a, tup):
    if (len(p) > len(a)):
        return False

    # action_types = [set(get_all_types(task, str(a[int(tup[i])]))) for i in range(len(tup))]
    action_types = [set([a[int(tup[i])]]) for i in range(len(tup))]
    predicate_types = [set(get_all_types(task, x)) for x in p[1:]]

    fits = [len(action_types[i].intersection(predicate_types[i])) >= 1 for i in range(len(action_types))]
    # for i in range(0, len(tup)):
        # bfound = False
        # for t in get_all_types(task, str(a[int(tup[i])])):
        #     if t in get_all_types(task, str(p[i + 1])):
        #         bfound = True
        # if bfound == False:
        #     return False
    return all(fits)


def is_binary_mutex(axiom):
    return isinstance(axiom.condition, pddl.UniversalCondition) and isinstance(axiom.condition.parts[0],
                                                                           pddl.Disjunction) and len(axiom.condition.parts[0].parts) == 2 and isinstance(
        axiom.condition.parts[0].parts[0], pddl.NegatedAtom) and isinstance(axiom.condition.parts[0].parts[1],
                                                                            pddl.NegatedAtom)


def get_binary_mutexes(fd_task):
    binary_mutexes = dict()
    for axiom in fd_task.axioms:
        if is_binary_mutex(axiom):
            part1 = axiom.condition.parts[0].parts[0]
            part2 = axiom.condition.parts[0].parts[1]

            args1 = part1.args
            args2 = part2.args

            arity1 = len(args1)
            arity2 = len(args2)

            matchings = list()
            if arity1 == 0:
                matchings.extend([(-1,i) for i in range(arity2)])
            elif arity2 == 0:
                matchings.extend([(i, -1) for i in range(arity2)])
            else:
                for i in range(arity1):
                    for j in range(arity2):
                        if args1[i] == args2[j]:
                            matchings.append((i,j))


            # print(part1, part2)
            # print(matchings)
            for tup in itertools.product(range(1, MAX_VARS+1), repeat=max(arity1, arity2)):
                vars = ["var" + str(t) for t in tup]
                # print(vars)
                m1 = [vars[i] for i in range(arity1)]
                for tup2 in itertools.product(vars, repeat=arity2):
                    m2 = [t for t in tup2]
                    # print(m1, m2)

                    match_all = True
                    for matching in matchings:
                        if matching[0] == -1 or matching[1] == -1:
                            continue
                        else:
                            match_all = match_all & (m1[matching[0]] == m2[matching[1]])
                    if match_all:
                        key = tuple([part1.predicate] + m1)
                        mutex = tuple([part2.predicate] + m2)
                        if key != mutex:
                            aux = binary_mutexes.get(key, set())
                            aux.add(mutex)
                            binary_mutexes[key] = aux

                        key = tuple([part2.predicate] + m2)
                        mutex = tuple([part1.predicate] + m1)
                        if key != mutex:
                            aux = binary_mutexes.get(key, set())
                            aux.add(mutex)
                            binary_mutexes[key] = aux

                        # print(key, mutex)

    return binary_mutexes



# **************************************#
# MAIN
# **************************************#
try:
    if "-s" in sys.argv:
        check_static_predicates = True
        sys.argv.remove("-s")
    else:
        check_static_predicates = False

    if "-i" in sys.argv:
        program_with_invariants = True
        sys.argv.remove("-i")
    else:
        program_with_invariants = False

    if "-r" in sys.argv:
        reversible_domain = True
        sys.argv.remove("-r")
    else:
        reversible_domain = False

    domain_folder_name  = sys.argv[1]
    domain_file = sys.argv[2]
    problems_prefix_filename = sys.argv[3]
    plans_prefix_filename = sys.argv[4]
    input_level = int(sys.argv[5])

except:
    print "Usage:"
    print sys.argv[0] + "[-s] [-i] [-r] <domain> <domain filename> <problems prefix>  <plans prefix> <input level (0 plans, 1 steps, 2 len(plan), 3 minimum)>"
    sys.exit(-1)


# Reading the example plans
plans = []
i = 0
for filename in sorted(glob.glob(domain_folder_name + "/" + plans_prefix_filename + "*")):
    plans.append([])
    lcounter = 0
    file = open(filename, 'r')
    for line in file:
        if input_level != config.INPUT_STEPS or (input_level == config.INPUT_STEPS and lcounter % 3 != 0):
            plans[i].append(line.replace("\n", "").split(": ")[1])
        lcounter = lcounter + 1
    file.close()
    i = i + 1


# Creating a FD task with the domain and the first problem file
domain_filename = "{}{}.pddl".format(domain_folder_name, domain_file)
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problems = []
fd_tasks = []
counter = 0
for problem_filename in sorted(glob.glob(domain_folder_name + "/" + problems_prefix_filename + "*")):
    fd_problems = fd_problems + [pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)]
    fd_tasks = fd_tasks + [pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problems[counter])]
    counter = counter + 1
fd_task = copy.deepcopy(fd_tasks[0])
known_action_models = [action for action in fd_task.actions]

MAX_STEPS = get_max_steps_from_plans(plans)
MAX_VARS = get_max_vars_from_plans(plans)
new_actions, known_actions = get_action_schema_from_plans(plans, fd_task)
actions = new_actions + known_actions
predicates = get_predicates_schema_from_plans(fd_task)
static_predicates, reflexive_static_predicates = get_static_predicates(fd_tasks, predicates)
binary_mutexes = get_binary_mutexes(fd_task)

# Compilation Problem
init_aux = copy.deepcopy(fd_task.init)
fd_task.init = []
fd_task.init.append(pddl.conditions.Atom("modeProg", []))
allpres = []
for a in new_actions:  # All possible preconditions are initially programmed
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
                if check_static_predicates and p in static_predicates:
                    if input_level <= config.INPUT_STEPS:
                        continue
                    elif not reflexive_static_predicates.get(p[0]) and len(set(tup)) == 1:
                        continue
                vars = ["var" + str(t) for t in tup]
                # fd_task.init.append(
                #     pddl.conditions.Atom("pre_" + "_".join([p[0]] + [a[0]] + vars), []))
                allpres = allpres + [str("pre_" + "_".join([p[0]] + [a[0]] + vars))]

if input_level <= config.INPUT_LENPLAN:
    for i in range(1, MAX_STEPS + 1):
        fd_task.init.append(pddl.conditions.Atom("inext", ["i" + str(i), "i" + str(i + 1)]))

goals = []
for i in range(0, len(plans) + 1):
    goals = goals + [pddl.conditions.Atom("test" + str(i), [""])]
fd_task.goal = pddl.conditions.Conjunction(goals)

# Compilation Domain
if input_level <= config.INPUT_LENPLAN:
    fd_task.types.append(pddl.pddl_types.Type("step", "None"))

if input_level <= config.INPUT_LENPLAN:
    for i in range(1, MAX_STEPS + 2):
        fd_task.objects.append(pddl.pddl_types.TypedObject("i" + str(i), "step"))

fd_task.predicates.append(pddl.predicates.Predicate("modeProg", []))
for i in range(0, len(plans) + 1):
    fd_task.predicates.append(pddl.predicates.Predicate("test" + str(i), []))
if input_level <= config.INPUT_LENPLAN:
    fd_task.predicates.append(pddl.predicates.Predicate("current", [pddl.pddl_types.TypedObject("?i", "step")]))
    fd_task.predicates.append(pddl.predicates.Predicate("inext", [pddl.pddl_types.TypedObject("?i1", "step"),
                                                                 pddl.pddl_types.TypedObject("?i2", "step")]))


# for axiom in fd_task.axioms:
#     fd_task.predicates.append(pddl.predicates.Predicate(axiom.name, []))

for a in new_actions:
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
                if p in static_predicates and check_static_predicates:
                    if input_level <= config.INPUT_STEPS:
                        continue
                    elif not reflexive_static_predicates.get(p[0]) and len(set(tup)) == 1:
                        continue

                vars = ["var" + str(t) for t in tup]
                fd_task.predicates.append(
                    pddl.predicates.Predicate("pre_" + "_".join([p[0]] + [a[0]] + vars), []))
                fd_task.predicates.append(
                    pddl.predicates.Predicate("del_" + "_".join([p[0]] + [a[0]] + vars), []))
                fd_task.predicates.append(
                    pddl.predicates.Predicate("add_" + "_".join([p[0]] + [a[0]] + vars), []))

if input_level <= config.INPUT_STEPS:
    for a in actions:
        fd_task.predicates.append(pddl.predicates.Predicate("plan-" + a[0],
                                                            [pddl.pddl_types.TypedObject("?i", "step")] + [
                                                                pddl.pddl_types.TypedObject("?o" + str(i), a[i]) for i
                                                                in range(1, len(a))]))

learned_static_preconditions = dict()

# Original domain actions
# old_actions = copy.deepcopy(actions)
for a in actions:

    pre = list()
    eff = list()
    is_known_action = False

    # Add derived predicates
    # pre.extend([invariant.condition for invariant in fd_task.axioms])

    if a in known_actions:
        is_known_action = True
        for action in fd_task.actions:
            if action.name == a[0]:
                if isinstance(action.precondition, pddl.conditions.Atom):
                    pre.append(action.precondition)
                else:
                    pre.extend([x for x in action.precondition.parts])

                eff = action.effects

                fd_task.actions.remove(action)

                break


    params = [pddl.pddl_types.TypedObject("?o" + str(i), a[i]) for i in range(1, len(a))]
    if input_level <= config.INPUT_LENPLAN and input_level < config.INPUT_MINIMUM:
        params = params + [pddl.pddl_types.TypedObject("?i1", "step")]
        params = params + [pddl.pddl_types.TypedObject("?i2", "step")]


    if check_static_predicates and input_level <= config.INPUT_STEPS:
        for static_predicate in static_predicates:
            static_preconditions = get_static_precondition(static_predicate, a, plans, fd_tasks)

            learned_static_preconditions[a[0]] = list()
            for static_precondition in static_preconditions:
                pre.append(static_precondition)
                learned_static_preconditions[a[0]].append(static_precondition)



    pre = pre + [pddl.conditions.NegatedAtom("modeProg", [])]
    if input_level <= config.INPUT_PLANS and input_level < config.INPUT_MINIMUM:
        pre = pre + [pddl.conditions.Atom("plan-" + a[0], ["?i1"] + ["?o" + str(i) for i in range(1, len(a))])]

    if input_level <= config.INPUT_LENPLAN and input_level < config.INPUT_MINIMUM:
        pre = pre + [pddl.conditions.Atom("current", ["?i1"])]
        pre = pre + [pddl.conditions.Atom("inext", ["?i1", "?i2"])]

    if not is_known_action:
        var_ids = []
        for i in range(1, len(a)):
            var_ids = var_ids + ["" + str(i)]
        for p in predicates:
            for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
                if possible_pred_for_action(fd_task, p, a, tup):
                    if p in static_predicates and check_static_predicates:
                        if input_level <= config.INPUT_STEPS:
                            continue
                        elif not reflexive_static_predicates.get(p[0]) and len(set(tup)) == 1:
                            continue
                    vars = ["var" + str(t) for t in tup]
                    disjunction = pddl.conditions.Disjunction(
                        [pddl.conditions.NegatedAtom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])] + [
                            pddl.conditions.Atom(p[0], ["?o" + str(t) for t in tup])])
                    pre = pre + [disjunction]



    if input_level < config.INPUT_STEPS:
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("current", ["?i1"]))]
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["?i2"]))]
    elif input_level < config.INPUT_MINIMUM:
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("current", ["?i1"]))]
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["?i2"]))]

    if not is_known_action:
        var_ids = []
        for i in range(1, len(a)):
            var_ids = var_ids + ["" + str(i)]
        for p in predicates:
            for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
                if possible_pred_for_action(fd_task, p, a, tup):
                    if check_static_predicates and p in static_predicates:
                        continue
                    vars = ["var" + str(t) for t in tup]
                    condition = pddl.conditions.Conjunction(
                        [pddl.conditions.Atom("del_" + "_".join([p[0]] + [a[0]] + vars), [])])
                    eff = eff + [
                        pddl.effects.Effect([], condition, pddl.conditions.NegatedAtom(p[0], ["?o" + str(t) for t in tup]))]

        var_ids = []
        for i in range(1, len(a)):
            var_ids = var_ids + ["" + str(i)]
        for p in predicates:
            for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
                if possible_pred_for_action(fd_task, p, a, tup):
                    if check_static_predicates and p in static_predicates:
                        continue
                    vars = ["var" + str(t) for t in tup]
                    condition = pddl.conditions.Conjunction(
                        [pddl.conditions.Atom("add_" + "_".join([p[0]] + [a[0]] + vars), [])])
                    eff = eff + [
                        pddl.effects.Effect([], condition, pddl.conditions.Atom(p[0], ["?o" + str(t) for t in tup]))]

    fd_task.actions.append(pddl.actions.Action(a[0], params, len(params), pddl.conditions.Conjunction(pre), eff, 0))

# Actions for programming the action schema
for a in new_actions:
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    a_vars = ["var" + str(v) for v in var_ids]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
                if p in static_predicates and check_static_predicates:
                    if input_level <= config.INPUT_STEPS:
                        continue
                    elif not reflexive_static_predicates.get(p[0]) and len(set(tup)) == 1:
                        continue
                # Program precondition
                vars = ["var" + str(t) for t in tup]
                params = []
                pre = []
                pre = pre + [pddl.conditions.Atom("modeProg", [])]
                pre = pre + [pddl.conditions.NegatedAtom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]
                if program_with_invariants:
                    key = tuple([p[0]] + vars)
                    for mutex in binary_mutexes.get(key, set()):
                        if set(mutex[1:]).issubset(set(a_vars)):
                            pre = pre + [
                                pddl.conditions.NegatedAtom("pre_" + "_".join([mutex[0]] + [a[0]] + [e for e in mutex[1:]]),
                                                    [])]
                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "pre_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_pre_" + "_".join([p[0]]+[a[0]]+vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))

                if reversible_domain:
                    # Unprogram precondition
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [pddl.conditions.Atom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])]
                    pre = pre + [
                        pddl.conditions.NegatedAtom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]
                    pre = pre + [
                        pddl.conditions.NegatedAtom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]
                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "pre_" + "_".join([p[0]] + [a[0]] + vars), []))]

                    fd_task.actions.append(
                        pddl.actions.Action("unprogram_pre_" + "_".join([p[0]] + [a[0]] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                if p in static_predicates and check_static_predicates:
                    continue

                # Program add effect
                pre = []
                pre = pre + [pddl.conditions.Atom("modeProg", [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [pddl.conditions.NegatedAtom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])]
                if program_with_invariants:
                    key = tuple([p[0]] + vars)
                    for mutex in binary_mutexes.get(key, set()):
                        if set(mutex[1:]).issubset(set(a_vars)):
                            pre = pre + [
                                pddl.conditions.NegatedAtom("add_" + "_".join([mutex[0]] + [a[0]] + [e for e in mutex[1:]]),
                                                    [])]

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "add_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_add_" + "_".join([p[0]] + [a[0]] + vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))

                if reversible_domain:
                    # Unprogram add effect
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [
                        pddl.conditions.Atom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]

                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "add_" + "_".join([p[0]] + [a[0]] + vars), []))]

                    fd_task.actions.append(
                        pddl.actions.Action("unprogram_add_" + "_".join([p[0]] + [a[0]] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))


                # Program del effect

                pre = []
                pre = pre + [pddl.conditions.Atom("modeProg", [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [pddl.conditions.Atom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])]

                if program_with_invariants:
                    key = tuple([p[0]] + vars)
                    for mutex in binary_mutexes.get(key, set()):
                        if set(mutex[1:]).issubset(set(a_vars)):
                            pre = pre + [
                                pddl.conditions.NegatedAtom("del_" + "_".join([mutex[0]] + [a[0]] + [e for e in mutex[1:]]),
                                                        [])]

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "del_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_del_" + "_".join([p[0]] + [a[0]] + vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))

                # Unprogram del effect
                if reversible_domain:
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [
                        pddl.conditions.Atom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]

                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "del_" + "_".join([p[0]] + [a[0]] + vars), []))]

                    fd_task.actions.append(
                        pddl.actions.Action("unprogram_del_" + "_".join([p[0]] + [a[0]] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))


# Actions for validating the tests
pre = []
pre = pre + [pddl.conditions.Atom("modeProg", [])]
#pre.extend([invariant.condition for invariant in fd_task.axioms])
eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("test0", []))]
for f in init_aux:
    if f.predicate != "=":
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), f)]

if input_level <= config.INPUT_LENPLAN:
    eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["i1"]))]

if input_level <= config.INPUT_STEPS:
    for i in range(0, len(plans[0])):
        action = plans[0][i]
        name = action[1:-1].split(" ")[0]
        params = action[1:-1].split(" ")[1:]
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(),
                                         pddl.conditions.Atom("plan-" + name, ["i" + str(i + 1)] + params))]

eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("modeProg", []))]
fd_task.actions.append(pddl.actions.Action("validate_0", [], 0, pddl.conditions.Conjunction(pre), eff, 0))

for i in range(0, len(plans)):
    pre = []
    pre = pre + [pddl.conditions.NegatedAtom("modeProg", [])]
    # pre.extend([invariant.condition for invariant in fd_task.axioms])
    for j in range(0, len(plans) + 1):
        if j < i + 1:
            pre = pre + [pddl.conditions.Atom("test" + str(j), [])]
        else:
            pre = pre + [pddl.conditions.NegatedAtom("test" + str(j), [])]

    if input_level <= config.INPUT_LENPLAN:
        pre = pre + [pddl.conditions.Atom("current", ["i" + str(len(plans[i]) + 1)])]
    for g in fd_tasks[i].goal.parts:
        pre = pre + [g]

    eff = []
    eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("test" + str(i + 1), []))]
    if input_level <= config.INPUT_LENPLAN:
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(),
                                         pddl.conditions.NegatedAtom("current", ["i" + str(len(plans[i]) + 1)]))]
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["i1"]))]

    if input_level <= config.INPUT_STEPS:
        for j in range(0, len(plans[i])):
            name = "plan-" + plans[i][j].replace("(", "").replace(")", "").split(" ")[0]
            pars = ["i" + str(j + 1)] + plans[i][j].replace("(", "").replace(")", "").split(" ")[1:]
            eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(name, pars))]
        if i < len(plans) - 1:
            for j in range(0, len(plans[i + 1])):
                name = "plan-" + plans[i + 1][j].replace("(", "").replace(")", "").split(" ")[0]
                pars = ["i" + str(j + 1)] + plans[i + 1][j].replace("(", "").replace(")", "").split(" ")[1:]
                eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(name, pars))]

    fd_task.actions.append(
        pddl.actions.Action("validate_" + str(i + 1), [], 0, pddl.conditions.Conjunction(pre), eff, 0))


# Writing the compilation output domain and problem
fdomain = open("aux_domain.pddl", "w")
fdomain.write(fdtask_to_pddl.format_domain(fd_task, fd_domain))
fdomain.close()

fdomain = open("aux_problem.pddl", "w")
fdomain.write(fdtask_to_pddl.format_problem(fd_task, fd_domain))
fdomain.close()

# Solving the compilation
cmd = "rm " + config.OUTPUT_FILENAME + " planner_out.log;" + config.PLANNER_PATH + "/" + config.PLANNER_NAME + " aux_domain.pddl aux_problem.pddl -F " + str(len(plans) + sum([len(p) for p in plans])) + " " + config.PLANNER_PARAMS + " > planner_out.log"
print("\n\nExecuting... " + cmd)
os.system(cmd)

# Reading the plan output by the compilation
pres = [[] for _ in xrange(len(new_actions))]
# pres = [[] for _ in xrange(len(new_actions))]
# pres = [ for p in pres]
dels = [[] for _ in xrange(len(new_actions))]
adds = [[] for _ in xrange(len(new_actions))]
file = open(config.OUTPUT_FILENAME, 'r')
for line in file:
    keys = "(program_pre_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]
        # allpres.remove(str("pre_" + pred[0] + "_" + action[0] + "_" + "_".join(map(str, pred[1:]))))
        pres[indexa].append(pred)

    keys = "(program_add_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]

        adds[indexa].append(pred)

    keys = "(program_del_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]

        dels[indexa].append(pred)

    keys = "(unprogram_pre_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]
        # allpres.remove(str("pre_" + pred[0] + "_" + action[0] + "_" + "_".join(map(str, pred[1:]))))
        pres[indexa].remove(pred)

    keys = "(unprogram_add_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]

        adds[indexa].remove(pred)

    keys = "(unprogram_del_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a[0] for a in new_actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]

        dels[indexa].remove(pred)
file.close()

counter = 0
new_fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problems[0])
new_fd_task.actions = []
for action in new_actions:
    params = ["?o" + str(i + 1) for i in range(0, len(action[1:]))]
    ps = [pddl.pddl_types.TypedObject(params[i], action[i + 1]) for i in range(0, len(params))]
    pre = []
    if check_static_predicates:
        pre += learned_static_preconditions.get(action[0], [])

    for p in pres[counter]:
        args = ["?o" + i.replace("var", "") for i in p[1:]]
        ball = True
        for arg in args:
            if not arg in [x.name for x in ps]:
                ball = False
        if ball:
            pre = pre + [pddl.conditions.Atom(p[0], args)]
    eff = []
    for p in dels[counter]:
        args = ["?o" + i.replace("var", "") for i in p[1:]]
        ball = True
        for arg in args:
            if not arg in [x.name for x in ps]:
                ball = False
        if ball:
            eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(p[0], args))]
    for p in adds[counter]:
        args = ["?o" + i.replace("var", "") for i in p[1:]]
        ball = True
        for arg in args:
            if not arg in [x.name for x in ps]:
                ball = False
        if ball:
            eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(p[0], args))]
    new_fd_task.actions.append(pddl.actions.Action(action[0], ps, len(ps), pddl.conditions.Conjunction(pre), eff, 0))
    counter = counter + 1

new_fd_task.actions.extend(known_action_models)

# Writing the compilation output domain and problem
fdomain = open("learned_domain.pddl", "w")
fdomain.write(fdtask_to_pddl.format_domain(new_fd_task, fd_domain))
fdomain.close()
sys.exit(0)
