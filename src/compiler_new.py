#! /usr/bin/env python
import glob, os, sys, copy, itertools
import pddl, pddl_parser
import config, fdtask_to_pddl
import numpy as np


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

def get_static_predicates(state_trajectories, predicates):

    candidates = set([p.name for p in predicates])

    for trajectory in state_trajectories:
        trace_candidates = set()
        for predicate in candidates:
            static = True
            init_literals = set([l for l in trajectory[0] if l.predicate == predicate])
            for state in trajectory[1:]:
                state_literals = set([l for l in state if l.predicate == predicate])

                if init_literals != state_literals:
                    static = False
                    break

            if static:
                trace_candidates.add(predicate)

        candidates = candidates.intersection(trace_candidates)

    # reflexive_static_predicates = dict()
    # for candidate in candidates:
    #     reflexive_static_predicates[candidate] = True
    #     for trace in traces:
    #         init_literals = set([l for l in trace.init if l.predicate == candidate])
    #         for literal in init_literals:
    #             if len(literal.args) == 1 or len(set(literal.args)) != 1:
    #                 reflexive_static_predicates[candidate] = False
    #                 break

    return candidates
    # return [p for p in predicates if p.name in candidates]


# **************************************#
# MAIN
# **************************************#
try:
    if "-s" in sys.argv:
        check_static_predicates = True
        sys.argv.remove("-s")
    else:
        check_static_predicates = False

    if "-v" in sys.argv:
        index = sys.argv.index("-v")
        learned_domain = sys.argv[index+1]
        validation_mode = True
        sys.argv.remove("-v")
        sys.argv.remove(learned_domain)
    else:
        validation_mode = False

    if "-f" in sys.argv:
        finite_steps = True
        sys.argv.remove("-f")
    else:
        finite_steps = False

    if "-t" in sys.argv:
        index = sys.argv.index("-t")
        trace_prefix = sys.argv[index+1]
        sys.argv.remove("-t")
        sys.argv.remove(trace_prefix)
    else:
        trace_prefix = "trace"

    if "-l" in sys.argv:
        index = sys.argv.index("-l")
        trace_limit = int(sys.argv[index+1])
        sys.argv.remove("-l")
        sys.argv.remove(sys.argv[index])
    else:
        trace_limit = None

    domain_folder_name  = sys.argv[1]
    action_observability = float(sys.argv[2])/100
    state_observability = float(sys.argv[3])/100

    if action_observability == 1 or state_observability == 1:
        finite_steps = True

except:
    print "Usage:"
    print sys.argv[0] + "[-s] [-f] [-v learned_domain] <domain folder> <action observability (0-100)> <state observability (0-100)> -t trace_prefix -l input_limit"
    sys.exit(-1)


# Read the domain file
if not validation_mode:
    domain_filename = "{}domain".format(domain_folder_name)
else:
    domain_filename = learned_domain
domain_pddl = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
                 = pddl_parser.parsing_functions.parse_domain_pddl(domain_pddl)


# Read the input traces
traces = list()
for filename in sorted(glob.glob(domain_folder_name + "/" + trace_prefix + "*")):
    trace_pddl = pddl_parser.pddl_file.parse_pddl_file("trace", filename)
    traces.append(pddl_parser.parsing_functions.parse_trace_pddl(trace_pddl, predicates, action_observability, state_observability))

if trace_limit and not validation_mode:
    traces = traces[:trace_limit]
if trace_limit and validation_mode:
    traces = traces[trace_limit:]


MAX_VARS = get_max_vars(actions)
TOTAL_STEPS, MAX_STEPS = get_max_steps(traces)
# static_predicates, reflexive_static_predicates = get_static_predicates(traces, predicates)

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


### LEARNING DOMAIN

# Define "modeProg" predicate
learning_task.predicates.append(pddl.predicates.Predicate("modeProg", []))
# Define "test" predicates
for i in range(1, TOTAL_STEPS+2):
    learning_task.predicates.append(pddl.predicates.Predicate("test" + str(i), []))

if action_observability > 0:
    # Define "step" domain type
    learning_task.types.append(pddl.pddl_types.Type("step", "None"))
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
if action_observability > 0:
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
    if action_observability > 0:
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
    if action_observability > 0:
        # validation_condition = [pddl.conditions.Atom("plan-" + a.name, ["?i1"] + ["?o" + str(i+1) for i in range(a.num_external_parameters) ])]
        validation_condition = [pddl.conditions.Atom("current", ["?i1"])]
        validation_condition += [pddl.conditions.Atom("inext", ["?i1", "?i2"])]

    if action_observability == 1:
        validation_condition += [pddl.conditions.Atom("plan-" + a.name, ["?i1"] + ["?o" + str(i+1) for i in range(a.num_external_parameters) ])]
        pre += validation_condition
        eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("current", ["?i1"]))]
        eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["?i2"]))]

    elif action_observability > 0:
        # Define conditional effect to validate an action in the input traces
        # This effect advances the program counter when an observed action is executed
        pre += validation_condition
        eff += [pddl.effects.Effect([], pddl.conditions.Conjunction([pddl.conditions.Atom("plan-" + a.name, ["?i1"] + ["?o" + str(i+1) for i in range(a.num_external_parameters) ])]), pddl.conditions.NegatedAtom("current", ["?i1"]))]
        eff = eff + [pddl.effects.Effect([], pddl.conditions.Conjunction([pddl.conditions.Atom("plan-" + a.name, ["?i1"] + ["?o" + str(i+1) for i in range(a.num_external_parameters) ])]), pddl.conditions.Atom("current", ["?i2"]))]

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

                if not validation_mode:
                    learning_task.actions.append(
                        pddl.actions.Action("program_pre_" + "_".join([p.name]+[a.name]+vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))
                else:
                    learning_task.actions.append(
                        pddl.actions.Action("insert_pre_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                if not validation_mode:
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
                else:
                    # Action for inserting negative effects
                    pre = []
                    pre += [pddl.conditions.Atom("modeProg", [])]
                    pre += [pddl.conditions.NegatedAtom("del_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre += [pddl.conditions.NegatedAtom("add_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre += [pddl.conditions.Atom("pre_" + "_".join([p.name] + [a.name] + vars), [])]


                    eff = []
                    eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                        "del_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("insert_del_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                    # Action for inserting positive effects
                    pre = []
                    pre += [pddl.conditions.Atom("modeProg", [])]
                    pre += [pddl.conditions.NegatedAtom("del_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre += [pddl.conditions.NegatedAtom("add_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre += [pddl.conditions.NegatedAtom("pre_" + "_".join([p.name] + [a.name] + vars), [])]

                    eff = []
                    eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                        "add_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("insert_add_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                if validation_mode:
                    # Delete precondition
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [pddl.conditions.Atom("pre_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre = pre + [
                        pddl.conditions.NegatedAtom("del_" + "_".join([p.name] + [a.name] + vars), [])]
                    pre = pre + [
                        pddl.conditions.NegatedAtom("add_" + "_".join([p.name] + [a.name] + vars), [])]
                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "pre_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("delete_pre_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                    # Delete add effect
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [
                        pddl.conditions.Atom("add_" + "_".join([p.name] + [a.name] + vars), [])]

                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "add_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("delete_add_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

                    # Delete del effect
                    pre = []
                    pre = pre + [pddl.conditions.Atom("modeProg", [])]
                    pre = pre + [
                        pddl.conditions.Atom("del_" + "_".join([p.name] + [a.name] + vars), [])]

                    eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "del_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("delete_del_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))

last_state_validations = list()
MAX_ISTEPS = 1
# ACTIONS FOR THE VALIDATION OF THE INPUT TRACES

del_plan_effects = [] # store plan predicates here to delete in the next validate action

# First validate action
# Disables modeProg
pre = [pddl.conditions.Atom("modeProg", [])]
eff = [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("modeProg", []))]

if action_observability > 0:
    # Setups program counter to 1
    eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("current", ["i1"]))]
# Setups the initial state of the first trace
eff += [pddl.effects.Effect([], pddl.conditions.Truth(), atom) for atom in traces[0].init]

num_traces = len(traces)
states_seen = 0 # Used for "test" predicates
total_actions_seen = 0
for j in range(len(traces)):
    trace = traces[j]
    trace_length = len(trace.states)
    actions_seen = 0
    for step in range(trace_length):
        if trace.actions[step] != []:
            actions_seen += 1
            total_actions_seen += 1
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("plan-" + trace.actions[step][0],
                                                             ["i" + str(actions_seen)] + trace.actions[step][1:]))]
            del_plan_effects += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                 pddl.conditions.NegatedAtom("plan-" + trace.actions[step][0],
                                                      ["i" + str(actions_seen)] + trace.actions[step][1:]))]


        if trace.states[step] != []:
            states_seen += 1
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("test"+str(states_seen), []))]
            if states_seen != 1:
                pre += [pddl.conditions.Atom("test" + str(states_seen - 1), [])]
                eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("test" + str(states_seen-1), []))]

            learning_task.actions.append(
                pddl.actions.Action("validate_" + str(states_seen), [], 0, pddl.conditions.Conjunction(pre), eff, 0))

            pre = [pddl.conditions.NegatedAtom("modeProg", [])]
            if action_observability > 0:
                pre += [pddl.conditions.Atom("current", ["i" + str(actions_seen + 1)])]
            pre += trace.states[step]
            eff = del_plan_effects
            if actions_seen != 0:
                eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["i1"]))]
                eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                            pddl.conditions.NegatedAtom("current", ["i" + str(actions_seen + 1)]))]
            # eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
            #                             pddl.conditions.NegatedAtom("test" + str(states_seen), []))]

            # If it is the last/goal state of the trace but not the last trace
            if step == trace_length -1 and j < len(traces)-1:
                last_state_validations.append(states_seen+1)
                next_state = set()
                current_state = set()
                for atom in traces[j + 1].init:
                    if not atom.negated:
                        next_state.add(atom)
                for atom in traces[j].goal:
                    if not atom.negated:
                        current_state.add(atom)

                lost_atoms = current_state.difference(next_state)
                new_atoms = next_state.difference(current_state)

                for atom in lost_atoms:
                    eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                                pddl.conditions.NegatedAtom(atom.predicate, atom.args))]

                for atom in new_atoms:
                    eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                                pddl.conditions.Atom(atom.predicate, atom.args))]




            del_plan_effects = []
            MAX_ISTEPS = max(MAX_ISTEPS, actions_seen + 1)
            actions_seen = 0



    # Goal validation
    # pre = [pddl.conditions.NegatedAtom("modeProg", [])]
    # pre += [pddl.conditions.Atom("current", ["i" + str(action_cnt)])]
    # pre += trace.goal
    # eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["i1"]))]
    # if action_cnt != 1:
    #     eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
    #                                 pddl.conditions.NegatedAtom("current", ["i" + str(action_cnt)]))]
    # Setup state for the next trace

# pre += [pddl.conditions.Atom("current", ["i" + str(actions_seen+1)])]
# eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
#                                         pddl.conditions.Atom("test" + str(states_seen), []))]
# eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
#                                         pddl.conditions.NegatedAtom("test" + str(states_seen-1), []))]
states_seen += 1
pre += [pddl.conditions.Atom("test" + str(states_seen-1), [])]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("test" + str(states_seen-1), []))]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("test"+str(states_seen), []))]
learning_task.actions.append(pddl.actions.Action("validate_" + str(states_seen), [], 0, pddl.conditions.Conjunction(pre), eff, 0))

last_state_validations.append(states_seen)

# print("final states validated at: {}".format(", ".join([str(i) for i in last_state_validations])))

### LEARNING PROBLEM

learning_task.goal = pddl.conditions.Conjunction([pddl.conditions.Atom("test"+str(states_seen), [])])

if action_observability > 0:
    # Add inext fluents
    for i in range(2, MAX_ISTEPS+1):
        learning_task.init.append(pddl.conditions.Atom("inext", ["i" + str(i-1), "i" + str(i)]))
    # Add step onjects
    for i in range(1, MAX_ISTEPS + 1):
        learning_task.objects.append(pddl.pddl_types.TypedObject("i" + str(i), "step"))

# Add modeProg fluent
learning_task.init.append(pddl.conditions.Atom("modeProg", []))

# size(M)
model_size = 0
# Add known preconditions and effects
for action in actions:
    action_params = [p.name for p in action.parameters]
    known_pres = list()
    if type(action.precondition) is pddl.Conjunction and len(action.precondition.parts) > 0:
        known_pres = action.precondition.parts
    elif type(action.precondition) is pddl.Atom:
        known_pres = [action.precondition]
    for pre in known_pres:
        if type(pre) is pddl.conditions.Truth:
            continue
        model_representation_fluent = "pre_" + "_".join([pre.predicate] + [action.name] + ["var"+str(action_params.index(pre.args[i])+1) for i in range(len(pre.args))])
        learning_task.init.append(pddl.conditions.Atom(model_representation_fluent, []))

        model_size += 1

    for eff in action.effects:
        if not eff.literal.negated:
            model_representation_fluent = "add_" + "_".join(
                [eff.literal.predicate] + [action.name] + ["var" + str(action_params.index(eff.literal.args[i]) + 1) for i in
                                                   range(len(eff.literal.args))])
        else:
            model_representation_fluent = "del_" + "_".join(
                [eff.literal.predicate] + [action.name] + ["var" + str(action_params.index(eff.literal.args[i]) + 1) for i in
                                                   range(len(eff.literal.args))])
        learning_task.init.append(pddl.conditions.Atom(model_representation_fluent, []))
        model_size += 1




### Write the learning task domain and problem to pddl
fdomain = open("learning_domain.pddl", "w")
fdomain.write(fdtask_to_pddl.format_domain(learning_task, domain_pddl))
fdomain.close()

fdomain = open("learning_problem.pddl", "w")
fdomain.write(fdtask_to_pddl.format_problem(learning_task, domain_pddl))
fdomain.close()


### Solvie the learning task
# starting_horizon = str(2*TOTAL_STEPS + 3)
validation_steps = max(states_seen-1, total_actions_seen)*2 + 1
if action_observability == 1 and state_observability == 0:
    validation_steps = states_seen + total_actions_seen
starting_horizon = str(validation_steps + 2)
if state_observability==1 or action_observability==1:
    ending_horizon = " -T " + starting_horizon
else:
    ending_horizon = ""

if validation_mode:
    plan_type = "-P 0"
    ending_horizon = ""
else:
    plan_type = ""

cmd = "rm " + config.OUTPUT_FILENAME + " planner_out.log;" + config.PLANNER_PATH + "/" + config.PLANNER_NAME + " learning_domain.pddl learning_problem.pddl -F " + starting_horizon + " " +ending_horizon + " " + plan_type + " " + config.PLANNER_PARAMS + " > planner_out.log"
# print("\n\nExecuting... " + cmd)
os.system(cmd)


### Read the solution plan to the learning task
if not validation_mode:
    pres = [[] for _ in xrange(len(actions))]
    dels = [[] for _ in xrange(len(actions))]
    adds = [[] for _ in xrange(len(actions))]
    file = open(config.OUTPUT_FILENAME, 'r')
    # Parse programming actions
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
        keys = "(validate_1)"
        if keys in line:
            break

    if check_static_predicates:
        subplans = [[] for _ in last_state_validations]
        arities = dict()
        for action in actions:
            arities[action.name] = action.num_external_parameters
        # Parse validation actions
        validating_trace = 0
        for line in file:
            if "validate_" in line:
                validate_num = int(line.split(":")[1].strip("()\n").split("_")[1])
                if validate_num in last_state_validations:
                    validating_trace += 1
                    if validate_num == last_state_validations[-1]:
                        break
            else:
                aux = line.split(":")[1].strip().strip("()\n").split(" ")
                action = aux[:arities[aux[0]]+1]
                subplans[validating_trace].append(action)
        file.close()

        adds_dict = dict()
        dels_dict = dict()
        for i in range(len(actions)):
            adds_dict[actions[i].name] = adds[i]
            dels_dict[actions[i].name] = dels[i]

        inferred_state_trejectories = list()
        for i in range(len(traces)):
            inferred_state_trajectory = list()
            init = [atom for atom in traces[i].init if not atom.negated]
            inferred_state_trajectory.append(set(init))
            for a in subplans[i]:
                negative_effects = copy.deepcopy(dels_dict[a[0]])
                positive_effects = copy.deepcopy(adds_dict[a[0]])
                for j in range(1,len(a)):
                    negative_effects = [[a[j] if x == "var"+str(j) else x for x in effect] for effect in negative_effects]
                    positive_effects = [[a[j] if x == "var" + str(j) else x for x in effect] for effect in positive_effects]

                new_state = inferred_state_trajectory[-1]
                new_state = new_state.difference(set([pddl.conditions.Atom(effect[0], effect[1:]) for effect in negative_effects]))
                new_state = new_state.union(set([pddl.conditions.Atom(effect[0], effect[1:]) for effect in positive_effects]))
                inferred_state_trajectory.append(new_state)
            inferred_state_trejectories.append(inferred_state_trajectory)

        static_predicates = get_static_predicates(inferred_state_trejectories, predicates)

        pre_states = dict()
        for i in range(len(subplans)):
            subplan = subplans[i]
            trajectory = inferred_state_trejectories[i]
            for j in range(len(subplan)):
                action = subplan[j]
                state = trajectory[j]

                pre_state = list()
                for literal in state:
                    if set(literal.args).issubset(set(action[1:])):
                        args_indices = list()
                        for arg in literal.args:
                            indices = ["var"+str(i) for i in range(1,len(action)) if action[i] == arg ]
                            args_indices.append(indices)
                        for tup in itertools.product(*args_indices):
                            pre_state.append(tuple([literal.predicate] + list(tup)))
                        # parameterized_args = ["var"+str(action.index(arg)) for arg in literal.args]


                pre_states_list = pre_states.get(action[0], [])
                pre_states_list.append(pre_state)
                pre_states[action[0]] = pre_states_list

        only_static = False
        for k,v in pre_states.items():
            new_preconditions = set(v[0])
            for pre_state in v[1:]:
                new_preconditions = new_preconditions.intersection(set(pre_state))

            if only_static:
                new_preconditions = [list(pre) for pre in new_preconditions if pre[0] in static_predicates]
            else:
                new_preconditions = [list(pre) for pre in new_preconditions]

            # Remove symmetric static preconditions, keeping the one with sorted arguments (var1, var2,...)
            new_preconditions = sorted(new_preconditions)
            for precondition in new_preconditions:
                if precondition[0] in static_predicates and \
                    [precondition[0]]+list(reversed(precondition[1:])) in new_preconditions and \
                    precondition[1:] != list(sorted(precondition[1:])):
                    new_preconditions.remove(precondition)
            indexa = [a.name for a in actions].index(k)
            learned_pres = pres[indexa]
            new_preconditions = [pre for pre in new_preconditions if pre not in learned_pres]
            pres[indexa] += new_preconditions

    counter = 0
    new_fd_task = copy.deepcopy(original_task)
    new_fd_task.actions = []
    for action in actions:
        ps = [pddl.pddl_types.TypedObject("?o"+str(i+1), action.parameters[i].type_name) for i in range(action.num_external_parameters)]
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
        new_fd_task.actions.append(pddl.actions.Action(action.name, ps, len(ps), pddl.conditions.Conjunction(pre), eff, 0))
        counter = counter + 1

    # new_fd_task.actions.extend(known_action_models)

    # Writing the compilation output domain and problem
    fdomain = open("learned_domain.pddl", "w")
    fdomain.write(fdtask_to_pddl.format_domain(new_fd_task, domain_pddl))
    fdomain.close()
    sys.exit(0)

### Read the solution plan to the evaluation task
inserts = 0
deletes = 0

if validation_mode:
    file = open(config.OUTPUT_FILENAME, 'r')
    # Parse edition actions
    for line in file:
        if "insert_" in line:
            inserts += 1
            # aux = line.replace("\n", "").replace(")", "").split("insert_")[1].split("_")
            # action = aux[2]
            # predicate = aux[1] + aux[3:]
            #
            # pred = [aux[0].split("_")[0]]
            # if [aux[0].split("_")[2:]][0] != ['']:
            #     pred = pred + [aux[0].split("_")[2:]][0]
            # # pres[indexa].append(pred)
        elif "delete_" in line:
            deletes += 1
        else:
            break
    file.close()

    semPrecision = np.float64(model_size - deletes) / model_size
    semRecall = np.float64(model_size - deletes) / (model_size - deletes + inserts)

    print("{} & {} & {} \\\\".format(domain_name, semPrecision, semRecall))



