#! /usr/bin/env python
import glob, os, sys, copy, itertools, math
import pddl, pddl_parser
import config, fdtask_to_pddl

def get_all_types(task, itype):
   output=[itype]
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
    return schemas


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


def possible_pred_for_action(task, p, a, tup):
    if (len(p) > len(a)):
        return False

    action_types = [set([a[int(tup[i])]]) for i in range(len(tup))]
    predicate_types = [set(get_all_types(task, x)) for x in p[1:]]
    fits = [len(action_types[i].intersection(predicate_types[i])) >= 1 for i in range(len(action_types))]
    return all(fits)


def get_fluents_from_model(task):
    fluents = list()
    for a in task.actions:
        params = [x.name for x in a.parameters]
        for pre in a.precondition.parts:
            vars = list()
            for arg in pre.args:
                pos = params.index(arg)
                vars.append("var"+str(pos+1))
            fluents += [str("pre_" + "_".join([pre.predicate] + [a.name] + vars))]

        for eff in a.effects:
            vars = list()
            for arg in eff.literal.args:
                pos = params.index(arg)
                vars.append("var" + str(pos + 1))
            if eff.literal.negated:
                fluents += [str("del_" + "_".join([eff.literal.predicate] + [a.name] + vars))]
            else:
                fluents += [str("add_" + "_".join([eff.literal.predicate] + [a.name] + vars))]

    return fluents




# **************************************#
# MAIN
# **************************************#
try:
    test_folder_name  = sys.argv[2]
    domain_file = sys.argv[1]
    problems_prefix_filename = sys.argv[3]
    plans_prefix_filename = sys.argv[4]
    input_level = int(sys.argv[5])

except:
    print "Usage:"
    print sys.argv[0] + "<domain> <test folder> <problems prefix> <plans prefix> <input level (0 plans, 1 steps, 2 len(plan), 3 minimum)>"
    sys.exit(-1)


# Reading the example plans
plans = []
i = 0
for filename in sorted(glob.glob(test_folder_name + "/" + plans_prefix_filename + "*")):
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
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_file)
fd_problems = []
fd_tasks = []
counter = 0
for problem_filename in sorted(glob.glob(test_folder_name + "/" + problems_prefix_filename + "*")):
    fd_problems = fd_problems + [pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)]
    fd_tasks = fd_tasks + [pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problems[counter])]
    counter = counter + 1
fd_task = copy.deepcopy(fd_tasks[0])


MAX_STEPS = get_max_steps_from_plans(plans)
MAX_VARS = get_max_vars_from_plans(plans)
actions = get_action_schema_from_plans(plans, fd_task)
predicates = get_predicates_schema_from_plans(fd_task)
learned_model_fluents = get_fluents_from_model(fd_task)


# Compilation Problem
init_aux = copy.deepcopy(fd_task.init)
fd_task.init = []
fd_task.init.append(pddl.conditions.Atom("modeProg", []))

for fluent in learned_model_fluents:
    fd_task.init.append(pddl.conditions.Atom(fluent, []))

allpres = []
for a in actions:  # All possible preconditions are initially programmed
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
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


for a in actions:
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
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


fd_task.actions = []
# Original domain actions
# old_actions = copy.deepcopy(actions)
for a in actions:

    pre = list()
    eff = list()

    params = [pddl.pddl_types.TypedObject("?o" + str(i), a[i]) for i in range(1, len(a))]
    if input_level <= config.INPUT_LENPLAN and input_level < config.INPUT_MINIMUM:
        params = params + [pddl.pddl_types.TypedObject("?i1", "step")]
        params = params + [pddl.pddl_types.TypedObject("?i2", "step")]


    pre = pre + [pddl.conditions.NegatedAtom("modeProg", [])]
    if input_level <= config.INPUT_PLANS and input_level < config.INPUT_MINIMUM:
        pre = pre + [pddl.conditions.Atom("plan-" + a[0], ["?i1"] + ["?o" + str(i) for i in range(1, len(a))])]

    if input_level <= config.INPUT_LENPLAN and input_level < config.INPUT_MINIMUM:
        pre = pre + [pddl.conditions.Atom("current", ["?i1"])]
        pre = pre + [pddl.conditions.Atom("inext", ["?i1", "?i2"])]


    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
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

    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):
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
                vars = ["var" + str(t) for t in tup]
                condition = pddl.conditions.Conjunction(
                    [pddl.conditions.Atom("add_" + "_".join([p[0]] + [a[0]] + vars), [])])
                eff = eff + [
                    pddl.effects.Effect([], condition, pddl.conditions.Atom(p[0], ["?o" + str(t) for t in tup]))]

    fd_task.actions.append(pddl.actions.Action(a[0], params, len(params), pddl.conditions.Conjunction(pre), eff, 0))

# Actions for programming the action schema
for a in actions:
    var_ids = []
    for i in range(1, len(a)):
        var_ids = var_ids + ["" + str(i)]
    a_vars = ["var" + str(v) for v in var_ids]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p) - 1)):
            if possible_pred_for_action(fd_task, p, a, tup):

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

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "pre_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_pre_" + "_".join([p[0]]+[a[0]]+vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))


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



                # Program add effect
                pre = []
                pre = pre + [pddl.conditions.Atom("modeProg", [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("del_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("add_" + "_".join([p[0]] + [a[0]] + vars), [])]
                pre = pre + [pddl.conditions.NegatedAtom("pre_" + "_".join([p[0]] + [a[0]] + vars), [])]

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "add_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_add_" + "_".join([p[0]] + [a[0]] + vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))


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

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "del_" + "_".join([p[0]] + [a[0]] + vars), []))]

                fd_task.actions.append(
                    pddl.actions.Action("program_del_" + "_".join([p[0]] + [a[0]] + vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))

                # Unprogram del effect
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
modifications = set()
file = open(config.OUTPUT_FILENAME, 'r')
for line in file:
    key = "(program_"
    if key in line:
        aux = "(unprogram_"+line[13:]
        if aux in modifications:
            modifications.remove(aux)
        else:
            modifications.add(line)

    key = "(unprogram_"
    if key in line:
        aux = "(program_" + line[15:]
        if aux in modifications:
            modifications.remove(aux)
        else:
            modifications.add(line)


file.close()

num_modifications = len(modifications)
worst_case = len(allpres)*3
mean = worst_case/2
# p = 1/(1+math.exp(-float(mean-num_modifications)/float(mean/6)))
p = float(worst_case-num_modifications)/worst_case
print("Modifications: {}".format(num_modifications))
print("Worst case modifications: {}".format(worst_case))
print("P(M|O) = {}".format(round(p, 2)))
# print("P(M|O) = {}".format())
sys.exit(0)
