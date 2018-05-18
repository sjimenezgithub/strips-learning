#! /usr/bin/env python
import glob, os, sys, copy, itertools
import pddl, pddl_parser
import config, fdtask_to_pddl


def get_max_vars(actions):
    max_vars = 0
    for a in actions:
        max_vars = max(max_vars, a.num_external_parameters)
    return max_vars

def get_max_steps(traces):
    traces_steps = list()

    for trace in traces:
        not_empty_states = len([state for state in trace.states if state != []])
        not_empty_actions = len([action for action in trace.actions if action != []])
        traces_steps.append(max(not_empty_states, not_empty_actions))
    return sum(traces_steps), max(traces_steps)

def get_all_types(task, itype):
   output=[itype]
   for t in task.types:
       if t.basetype_name == itype:
           output.append(str(t.name))
   return output

def possible_pred_for_action(task, p, a, tup):
    if (len(p.arguments) > len(a.parameters)):
        return False

    action_types = [set([a.parameters[int(tup[i])-1].type_name]) for i in range(len(tup))]
    predicate_types = [set(get_all_types(task, x.type_name)) for x in p.arguments]

    fits = [len(action_types[i].intersection(predicate_types[i])) >= 1 for i in range(len(action_types))]
    return all(fits)


# **************************************#
# MAIN
# **************************************#
try:
    if "-s" in sys.argv:
        check_static_predicates = True
        sys.argv.remove("-s")
    else:
        check_static_predicates = False

    domain_folder_name  = sys.argv[1]
    # domain_file = sys.argv[2]
    # traces_prefix_filename = sys.argv[3]

except:
    print "Usage:"
    print sys.argv[0] + "[-s] <domain folder>"
    sys.exit(-1)


# Read the domain file
domain_filename = "{}domain".format(domain_folder_name)
domain_pddl = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
                 = pddl_parser.parsing_functions.parse_domain_pddl(domain_pddl)


# Read the input traces
traces = list()
for filename in sorted(glob.glob(domain_folder_name + "/trace" + "*")):
    trace_pddl = pddl_parser.pddl_file.parse_pddl_file("trace", filename)
    # traces = traces + [trace_pddl]
    traces.append(pddl_parser.parsing_functions.parse_trace_pddl(trace_pddl))


MAX_VARS = get_max_vars(actions)
TOTAL_STEPS, MAX_STEPS = get_max_steps(traces)

### LEARNING PROBLEM

# The objects of the original domain for the learning task
# is the union of all objects in the input traces
objects = list()
for trace in traces:
    objects.extend(trace.objects)
objects = list(set(objects))
# Empty initial state for now
init = []
# Empty goal for now
goal = []

original_task = pddl.Task(domain_name, 'learning_problem', domain_requirements, types, objects,
        predicates, functions, init, goal, actions, axioms, True)

learning_task = copy.deepcopy(original_task)
learning_task.actions = []


### LEARNING PROBLEM

# goals = []
# for i in range(0, len(traces) + 1):
#     goals = goals + [pddl.conditions.Atom("test" + str(i), [""])]
learning_task.goal = pddl.conditions.Conjunction([pddl.conditions.Atom("test"+str(TOTAL_STEPS+1), [])])

for i in range(1, MAX_STEPS + 1):
    learning_task.init.append(pddl.conditions.Atom("inext", ["i" + str(i), "i" + str(i + 1)]))

for i in range(1, MAX_STEPS + 2):
    learning_task.objects.append(pddl.pddl_types.TypedObject("i" + str(i), "step"))


### LEARNING DOMAIN

# Define "step" domain type
learning_task.types.append(pddl.pddl_types.Type("step", "None"))
# Define "modeProg" predicate
learning_task.predicates.append(pddl.predicates.Predicate("modeProg", []))
# Define "test" predicates
for i in range(1, TOTAL_STEPS+2):
    learning_task.predicates.append(pddl.predicates.Predicate("test" + str(i), []))
# Define "current" predicate. Example (current ?i - step)
learning_task.predicates.append(pddl.predicates.Predicate("current", [pddl.pddl_types.TypedObject("?i", "step")]))
# Define "inext" predicate. Example (inext ?i1 - step ?i2 - step)
learning_task.predicates.append(pddl.predicates.Predicate("inext", [pddl.pddl_types.TypedObject("?i1", "step"),
                                                                  pddl.pddl_types.TypedObject("?i2", "step")]))

# Define action model representation predicates
# Eample (pre_clear_pickup_var1)
for a in actions:
    var_ids = []
    for i in range(a.num_external_parameters):
        var_ids = var_ids + ["" + str(i+1)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p.arguments))):
            if possible_pred_for_action(learning_task, p, a, tup):
                vars = ["var" + str(t) for t in tup]
                learning_task.predicates.append(
                    pddl.predicates.Predicate("pre_" + "_".join([p.name] + [a.name] + vars), []))
                learning_task.predicates.append(
                    pddl.predicates.Predicate("del_" + "_".join([p.name] + [a.name] + vars), []))
                learning_task.predicates.append(
                    pddl.predicates.Predicate("add_" + "_".join([p.name] + [a.name] + vars), []))

# Define action validation predicates
# Example (plan-pickup ?i - step ?x - block)
for a in actions:
    learning_task.predicates.append(pddl.predicates.Predicate("plan-" + a.name,
                                                        [pddl.pddl_types.TypedObject("?i", "step")] + a.parameters))


# Original domain actions
for a in actions:

    params = [pddl.pddl_types.TypedObject("?o" + str(i+1), a.parameters[i].type_name ) for i in range(a.num_external_parameters)]
    pre = list()
    eff = list()

    # Add "step" parameters to the original actions
    # This will allow to reproduce the input traces
    params += [pddl.pddl_types.TypedObject("?i1", "step")]
    params += [pddl.pddl_types.TypedObject("?i2", "step")]

    # Add "modeProg" precondition
    pre = pre + [pddl.conditions.NegatedAtom("modeProg", [])]

    # Add all possible preconditions as implications
    # Example (or (not (pre_on_stack_var1_var1 ))(on ?o1 ?o1))
    var_ids = []
    for i in range(a.num_external_parameters):
        var_ids = var_ids + ["" + str(i+1)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=(len(p.arguments))):
            if possible_pred_for_action(learning_task, p, a, tup):
                vars = ["var" + str(t) for t in tup]
                disjunction = pddl.conditions.Disjunction(
                    [pddl.conditions.NegatedAtom("pre_" + "_".join([p.name] + [a.name] + vars), [])] + [
                        pddl.conditions.Atom(p.name, ["?o" + str(t) for t in tup])])
                pre = pre + [disjunction]


    # Define action validation condition
    # Example (and (plan-pickup ?i1 ?o1) (current ?i1) (inext ?i1 ?i2))
    validation_condition = [pddl.conditions.Atom("plan-" + a.name, ["?i1"] + ["?o" + str(i+1) for i in range(a.num_external_parameters) ])]
    validation_condition += [pddl.conditions.Atom("current", ["?i1"])]
    validation_condition += [pddl.conditions.Atom("inext", ["?i1", "?i2"])]
    # Define conditional effect to validate an action in the input traces
    # This effect advances the program counter when an observed action is executed
    eff += [pddl.effects.Effect([], pddl.conditions.Conjunction(validation_condition), pddl.conditions.NegatedAtom("current", ["?i1"]))]
    eff = eff + [pddl.effects.Effect([], pddl.conditions.Conjunction(validation_condition), pddl.conditions.Atom("current", ["?i2"]))]

    # Add all possible effects as conditional effects
    # Example (when (and (del_ontable_put-down_var1 ))(not (ontable ?o1)))
    var_ids = []
    for i in range(a.num_external_parameters):
        var_ids = var_ids + ["" + str(i+1)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=len(p.arguments)):
            if possible_pred_for_action(learning_task, p, a, tup):
                vars = ["var" + str(t) for t in tup]
                # del effects
                condition = pddl.conditions.Conjunction(
                    [pddl.conditions.Atom("del_" + "_".join([p.name] + [a.name] + vars), [])])
                eff = eff + [
                    pddl.effects.Effect([], condition, pddl.conditions.NegatedAtom(p.name, ["?o" + str(t) for t in tup]))]
                # add effects
                condition = pddl.conditions.Conjunction(
                    [pddl.conditions.Atom("add_" + "_".join([p.name] + [a.name] + vars), [])])
                eff = eff + [
                    pddl.effects.Effect([], condition, pddl.conditions.Atom(p.name, ["?o" + str(t) for t in tup]))]


    learning_task.actions.append(pddl.actions.Action(a.name, params, len(params), pddl.conditions.Conjunction(pre), eff, 0))


# Actions for programming the action model
for a in actions:
    var_ids = []
    for i in range(a.num_external_parameters):
        var_ids = var_ids + ["" + str(i+1)]
    for p in predicates:
        for tup in itertools.product(var_ids, repeat=len(p.arguments)):
            if possible_pred_for_action(learning_task, p, a, tup):
                vars = ["var" + str(t) for t in tup]
                params = []

                # Action for programmming de preconditions
                pre = []
                pre = pre + [pddl.conditions.Atom("modeProg", [])]
                pre = pre + [pddl.conditions.NegatedAtom("pre_" + "_".join([p.name] + [a.name] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("del_" + "_".join([p.name] + [a.name] + vars), [])]
                pre = pre + [
                    pddl.conditions.NegatedAtom("add_" + "_".join([p.name] + [a.name] + vars), [])]
                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "pre_" + "_".join([p.name] + [a.name] + vars), []))]

                learning_task.actions.append(
                    pddl.actions.Action("program_pre_" + "_".join([p.name]+[a.name]+vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))

                # Action for programming the effects
                pre = []
                pre += [pddl.conditions.Atom("modeProg", [])]
                pre += [pddl.conditions.NegatedAtom("del_" + "_".join([p.name] + [a.name] + vars), [])]
                pre = pre + [pddl.conditions.NegatedAtom("add_" + "_".join([p.name] + [a.name] + vars), [])]

                eff = []
                eff = eff + [pddl.effects.Effect([], pddl.conditions.Atom(
                    "pre_" + "_".join([p.name] + [a.name] + vars), []), pddl.conditions.Atom(
                    "del_" + "_".join([p.name] + [a.name] + vars), []))]
                eff = eff + [pddl.effects.Effect([], pddl.conditions.NegatedAtom(
                    "pre_" + "_".join([p.name] + [a.name] + vars), []), pddl.conditions.Atom(
                    "add_" + "_".join([p.name] + [a.name] + vars), []))]
                learning_task.actions.append(
                    pddl.actions.Action("program_eff_" + "_".join([p.name]+[a.name]+vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))



# Actions for validating the states in the input traces

del_plan_effects = [] # store plan predicates here to delete in the next validate action

pre = [pddl.conditions.Atom("modeProg", [])]
eff = [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("modeProg", []))]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("current", ["i1"]))]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(), atom) for atom in traces[0].init]

num_traces = len(traces)
i = 1
for j in range(len(traces)):
    trace = traces[j]
    trace_length = len(trace.states)
    # pre = [pddl.conditions.NegatedAtom("modeProg", [])]
    # eff = []
    action_cnt = 1
    for step in range(trace_length):
        if trace.actions[step] != []:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("plan-" + trace.actions[step][0],
                                                             ["i" + str(action_cnt)] + trace.actions[step][1:]))]
            del_plan_effects += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                 pddl.conditions.NegatedAtom("plan-" + trace.actions[step][0],
                                                      ["i" + str(action_cnt)] + trace.actions[step][1:]))]
            action_cnt += 1

        if trace.states[step] != []:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("test"+str(i), []))]
            if step > 0:
                pre += [pddl.conditions.Atom("current", ["i" + str(action_cnt)])]
                eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                            pddl.conditions.NegatedAtom("test" + str(i - 1), []))]
            learning_task.actions.append(pddl.actions.Action("validate_" + str(i), [], 0, pddl.conditions.Conjunction(pre), eff, 0))
            action_cnt = 1
            i += 1
            pre = [pddl.conditions.NegatedAtom("modeProg", [])]
            pre += trace.states[step]
            eff = del_plan_effects
            del_plan_effects = []



    # Goal validation
    pre = [pddl.conditions.NegatedAtom("modeProg", [])]
    pre += [pddl.conditions.Atom("current", ["i" + str(action_cnt)])]
    pre += trace.goal
    eff = [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("current", ["i1"]))]
    eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("current", ["i" + str(action_cnt)]))]
    # Setup state for the next trace
    if j < len(traces)-1:
        next_state = set()
        for atom in traces[j+1].init:
            next_state.add(atom)
        current_state = set(trace.goal)

        lost_atoms = current_state.difference(next_state)
        new_atoms = next_state.difference(current_state)

        for atom in lost_atoms:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(atom.predicate, atom.args))]

        for atom in new_atoms:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(atom.predicate, atom.args))]


eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("test" + str(i), []))]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("test" + str(i-1), []))]
learning_task.actions.append(pddl.actions.Action("validate_" + str(i), [], 0, pddl.conditions.Conjunction(pre), eff, 0))


### Write the learning task domain and problem to pddl
fdomain = open("learning_domain.pddl", "w")
fdomain.write(fdtask_to_pddl.format_domain(learning_task, domain_pddl))
fdomain.close()

fdomain = open("learning_problem.pddl", "w")
fdomain.write(fdtask_to_pddl.format_problem(learning_task, domain_pddl))
fdomain.close()


### Solvie the learning task
starting_horizon = str(2*TOTAL_STEPS + 2)

cmd = "rm " + config.OUTPUT_FILENAME + " planner_out.log;" + config.PLANNER_PATH + "/" + config.PLANNER_NAME + " learning_domain.pddl learning_problem.pddl -F " + starting_horizon + " " + config.PLANNER_PARAMS + " > planner_out.log"
print("\n\nExecuting... " + cmd)
os.system(cmd)


### Read the solution plan to the learning task
# pres = [[[p.split("_")[1]] + p.split("_")[3:] for p in allpres if "_"+new_actions[i][0] in p] for i in xrange(len(new_actions))]
pres = [[] for _ in xrange(len(actions))]
# pres = [ for p in pres]
dels = [[] for _ in xrange(len(actions))]
adds = [[] for _ in xrange(len(actions))]
file = open(config.OUTPUT_FILENAME, 'r')
for line in file:
    keys = "(program_pre_"
    if keys in line:
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a.name for a in actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]
        # allpres.remove(str("pre_" + pred[0] + "_" + action[0] + "_" + "_".join(map(str, pred[1:]))))
        pres[indexa].append(pred)

    keys = "(program_eff_"
    if keys in line:
        # act = p.split("_")[2]
        # pred = [p.split("_")[1]] + p.split("_")[3:]
        # indexa = [a[0] for a in new_actions].index(act)
        aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
        action = aux[0].split("_")[1:] + aux[1:]
        indexa = [a.name for a in actions].index(action[0])
        pred = [aux[0].split("_")[0]]
        if [aux[0].split("_")[2:]][0] != ['']:
            pred = pred + [aux[0].split("_")[2:]][0]
        if not pred in pres[indexa]:
            adds[indexa].append(pred)
        else:
            dels[indexa].append(pred)
file.close()

counter = 0
new_fd_task = copy.deepcopy(original_task)
new_fd_task.actions = []
for action in actions:
    params = ["?o" + str(i + 1) for i in range(0, len(action[1:]))]
    ps = [pddl.pddl_types.TypedObject(params[i], action[i + 1]) for i in range(0, len(params))]
    pre = []

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

# new_fd_task.actions.extend(known_action_models)

# Writing the compilation output domain and problem
fdomain = open("learned_domain.pddl", "w")
fdomain.write(fdtask_to_pddl.format_domain(new_fd_task, domain_pddl))
fdomain.close()
sys.exit(0)

