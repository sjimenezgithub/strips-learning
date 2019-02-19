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

    if "-nt" in sys.argv:
        index = sys.argv.index("-nt")
        nottrace_prefix = sys.argv[index+1]
        sys.argv.remove("-nt")
        sys.argv.remove(nottrace_prefix)
    else:
        nottrace_prefix = ""

    if "-l" in sys.argv:
        index = sys.argv.index("-l")
        trace_min = int(sys.argv[index+1])
        trace_max = int(sys.argv[index+2])
        sys.argv.remove("-l")
        sys.argv.remove(sys.argv[index])
        sys.argv.remove(sys.argv[index])
    else:
        trace_min = None

    domain_folder_name  = sys.argv[1]
    action_observability = float(0)
    state_observability = float(1)

    if action_observability == 1 or state_observability == 1:
        finite_steps = True

except:
    print "Usage:"
    print sys.argv[0] + "[-s] [-f] [-v learned_domain] <domain folder> <action observability (0-100)> <state observability (0-100)> -t trace_prefix -l input_limit"
    sys.exit(-1)


# trace_filter = ["a", "b", "c", "d", "next", "head"]
# acceptor_state = "states4"
# pres_filter = []-v ../benchmarks/icaps19/au-v ../benchmarks/icaps19/automata/class1/domain.pddl -v ../benchmarks/icaps19/automata/class1/domain.pddl tomata/class1/domain.pddl
# adds_filter = ['states0', 'states1', 'states2', 'states3', 'states4']
# dels_filter = ['states0', 'states1', 'states2', 'states3', 'states4']

profile = open(domain_folder_name+'/profile', 'r')
lines = profile.readlines()

trace_filter = [s.strip().lower() for s in lines[0].strip().split(',')]
acceptor_state = lines[1].strip()
pres_filter = [s.strip().lower() for s in lines[2].strip().split(',')]
adds_filter = [s.strip().lower() for s in lines[3].strip().split(',')]
dels_filter = [s.strip().lower() for s in lines[4].strip().split(',')]

profile.close()

not_acceptor_states = ['states0', 'states1', 'states2', 'states3',]

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

for trace in traces:
    for i in range(len(trace.states)):
        trace.states[i] = [atom for atom in trace.states[i] if atom.predicate in trace_filter]

if trace_min != None:
    traces = traces[trace_min:trace_max]


# Negative examples
if nottrace_prefix != "":
    nottraces = list()
    for filename in sorted(glob.glob(domain_folder_name + "/" + nottrace_prefix + "*")):
        trace_pddl = pddl_parser.pddl_file.parse_pddl_file("trace", filename)
        nottraces.append(pddl_parser.parsing_functions.parse_trace_pddl(trace_pddl, predicates, action_observability, state_observability))

    for trace in nottraces:
        for i in range(len(trace.states)):
            trace.states[i] = [atom for atom in trace.states[i] if atom.predicate in trace_filter]

    if trace_min != None:
        nottraces = nottraces[trace_min:trace_max]

    # Fix goal state to not include the acceptor state
    for trace in nottraces:
        trace.goal = [atom for atom in trace.goal if atom.predicate not in not_acceptor_states]


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
                # if p.name in pres_filter:
                #     learning_task.predicates.append(
                #     pddl.predicates.Predicate("pre_" + "_".join([p.name] + [a.name] + vars), []))
                # if p.name in dels_filter:
                #     learning_task.predicates.append(
                #     pddl.predicates.Predicate("del_" + "_".join([p.name] + [a.name] + vars), []))
                if p.name in adds_filter:
                    learning_task.predicates.append(
                    pddl.predicates.Predicate("add_" + "_".join([p.name] + [a.name] + vars), []))

# Define action validation predicates
# Example (plan-pickup ?i - step ?x - block)
if action_observability > 0:
    for a in actions:
        learning_task.predicates.append(pddl.predicates.Predicate("plan-" + a.name,
                                                        [pddl.pddl_types.TypedObject("?i", "step")] + a.parameters))

learning_task.predicates.append(pddl.predicates.Predicate("action_applied", []))



# Original domain actions
for a in actions:

    original_params = [par.name for par in a.parameters]
    params = [pddl.pddl_types.TypedObject("?o" + str(i+1), a.parameters[i].type_name ) for i in range(a.num_external_parameters)]

    pre = list()

    known_preconditions = list(a.precondition.parts)
    for known_precondition in known_preconditions:
        pre += [pddl.conditions.Atom(known_precondition.predicate, ["?o" + str(original_params.index(arg) + 1) for arg in known_precondition.args])]

    eff = list()

    known_effects = list(a.effects)
    del_state_effects = [p for p in known_preconditions if p.predicate in adds_filter]
    known_effects = [e for e in known_effects if e.literal.predicate not in adds_filter or not e.literal.negated]
    for known_effect in known_effects:
        if not known_effect.literal.negated and known_effect.literal.predicate not in adds_filter:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(known_effect.literal.predicate, ["?o" + str(original_params.index(arg) + 1) for arg in known_effect.literal.args]))]
        elif known_effect.literal.negated and known_effect.literal.predicate not in dels_filter:
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(known_effect.literal.predicate, ["?o" + str(original_params.index(arg) + 1) for arg in known_effect.literal.args]))]

    # action_applied predicate
    eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("action_applied", []))]


    # Add "step" parameters to the original actions
    params += [pddl.pddl_types.TypedObject("?i1", "step")]
    params += [pddl.pddl_types.TypedObject("?i2", "step")]

    # Add "modeProg" precondition
    pre += [pddl.conditions.NegatedAtom("modeProg", [])]


    # Define action validation condition
    # Example (and (current ?i1) (inext ?i1 ?i2))
    validation_condition = [pddl.conditions.Atom("current", ["?i1"])]
    validation_condition += [pddl.conditions.Atom("inext", ["?i1", "?i2"])]
    pre += validation_condition

    eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("current", ["?i1"]))]
    eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["?i2"]))]


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
                if p.name in dels_filter:
                    condition = pddl.conditions.Conjunction(
                    [pddl.conditions.Atom("del_" + "_".join([p.name] + [a.name] + vars), [])])
                    eff = eff + [
                    pddl.effects.Effect([], condition, pddl.conditions.NegatedAtom(p.name, ["?o" + str(t) for t in tup]))]
                # add effects
                # if p.name in adds_filter and p.name not in [kp.predicate for kp in known_preconditions]:
                if p.name in adds_filter:
                    condition = pddl.conditions.Conjunction(
                    [pddl.conditions.Atom("add_" + "_".join([p.name] + [a.name] + vars), [])])
                    eff = eff + [
                    pddl.effects.Effect([], condition, pddl.conditions.Atom(p.name, ["?o" + str(t) for t in tup]))]

    for del_state_effect in del_state_effects:
        condition = pddl.conditions.Disjunction(
            [pddl.conditions.Atom("add_" + "_".join([s] + [a.name]), []) for s in adds_filter if
             s != del_state_effect.predicate])
        # condition = pddl.conditions.Disjunction([pddl.conditions.Atom("add_" + "_".join([s] + [a.name] ), []) for s in adds_filter if s != del_state_effect.predicate] + [pddl.conditions.NegatedAtom("add_" + "_".join([del_state_effect.predicate] + [a.name] ), [])])
        eff = eff + [
            pddl.effects.Effect([], condition, pddl.conditions.NegatedAtom(del_state_effect.predicate, []))]

    learning_task.actions.append(pddl.actions.Action(a.name, params, len(params), pddl.conditions.Conjunction(pre), eff, 0))



filtered_predicates = [p for p in predicates if p.name in adds_filter]
# Actions for programming the action model
for a in actions:
    var_ids = []
    for i in range(a.num_external_parameters):
        var_ids = var_ids + ["" + str(i+1)]
    for p in filtered_predicates:
        for tup in itertools.product(var_ids, repeat=len(p.arguments)):
            if possible_pred_for_action(learning_task, p, a, tup):
                vars = ["var" + str(t) for t in tup]
                params = []

                # Action for inserting a positive effect
                pre = []
                pre += [pddl.conditions.Atom("modeProg", [])]
                pre += [pddl.conditions.NegatedAtom("add_" + "_".join([fp.name] + [a.name] + vars), []) for fp in filtered_predicates]

                eff = [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom(
                    "add_" + "_".join([p.name] + [a.name] + vars), []))]

                learning_task.actions.append(
                    pddl.actions.Action("insert_add_" + "_".join([p.name]+[a.name]+vars), params,
                                        len(params), pddl.conditions.Conjunction(pre), eff, 0))
                if validation_mode:
                    # Action for inserting positive effects
                    pre = []
                    pre += [pddl.conditions.Atom("modeProg", [])]
                    pre += [pddl.conditions.Atom("add_" + "_".join([p.name] + [a.name] + vars), [])]

                    eff = []
                    eff = eff + [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom(
                        "add_" + "_".join([p.name] + [a.name] + vars), []))]

                    learning_task.actions.append(
                        pddl.actions.Action("delete_add_" + "_".join([p.name] + [a.name] + vars), params,
                                            len(params), pddl.conditions.Conjunction(pre), eff, 0))


last_state_validations = list()
MAX_ISTEPS = 2
# ACTIONS FOR THE VALIDATION OF THE INPUT TRACES

del_plan_effects = [] # store plan predicates here to delete in the next validate action

# First validate action
# Disables modeProg
pre = [pddl.conditions.Atom("modeProg", [])]
eff = [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("modeProg", []))]

# Setups program counter to 1
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                    pddl.conditions.Atom("current", ["i1"]))]
# Setups the initial state of the first trace
eff += [pddl.effects.Effect([], pddl.conditions.Truth(), atom) for atom in traces[0].init]

num_traces = len(traces)
states_seen = 0 # Used for "test" predicates
total_actions_seen = 0
for j in range(len(traces) + len(nottraces)):

    if j < num_traces:
        trace = traces[j]
    else:
        trace = nottraces[j-num_traces]

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

            # action_applied
            pre += [pddl.conditions.Atom("action_applied", [])]
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.NegatedAtom("action_applied", []))]

            pre += [pddl.conditions.Atom("current", ["i2"])]
            pre += trace.states[step]
            eff = del_plan_effects
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(), pddl.conditions.Atom("current", ["i1"]))]
            eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("current", ["i2"]))]
            # eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
            #                             pddl.conditions.NegatedAtom("test" + str(states_seen), []))]

            # If it is the last/goal state of the trace but not the last trace
            if step == trace_length -1 and j < len(traces) + len(nottraces) - 1:

                if j >= num_traces:
                    # not acceptor_state
                    pre += [pddl.conditions.NegatedAtom(acceptor_state, [])]
                else:
                    # acceptor state
                    pre += [pddl.conditions.Atom(acceptor_state, [])]


                if j >= num_traces - 1:
                    next_trace = nottraces[j-num_traces+1]
                else:
                    next_trace = traces[j + 1]


                last_state_validations.append(states_seen+1)
                next_state = set()
                current_state = set()
                if j >= num_traces - 1:
                    next_trace = nottraces[j-num_traces+1]
                else:
                    next_trace = traces[j + 1]
                for atom in next_trace.init:
                    if not atom.negated:
                        next_state.add(atom)
                for atom in trace.goal:
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

                reset_state = [p for p in filtered_predicates if p.name not in [atom.predicate for atom in new_atoms]]
                for p in reset_state:
                    eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                                pddl.conditions.NegatedAtom(p.name, []))]







            del_plan_effects = []
            actions_seen = 0


states_seen += 1
# acceptor state
if len(nottraces) == 0:
    pre += [pddl.conditions.Atom(acceptor_state, [])]
else:
    pre += [pddl.conditions.NegatedAtom(acceptor_state, [])]
pre += [pddl.conditions.Atom("test" + str(states_seen-1), [])]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.NegatedAtom("test" + str(states_seen-1), []))]
eff += [pddl.effects.Effect([], pddl.conditions.Truth(),
                                        pddl.conditions.Atom("test"+str(states_seen), []))]
learning_task.actions.append(pddl.actions.Action("validate_" + str(states_seen), [], 0, pddl.conditions.Conjunction(pre), eff, 0))

last_state_validations.append(states_seen)



### LEARNING PROBLEM

learning_task.goal = pddl.conditions.Conjunction([pddl.conditions.Atom("test"+str(states_seen), [])])

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

    filtered_known_pres = [pre for pre in known_pres if pre.predicate in pres_filter]
    for pre in filtered_known_pres:
        if type(pre) is pddl.conditions.Truth:
            continue
        model_representation_fluent = "pre_" + "_".join([pre.predicate] + [action.name] + ["var"+str(action_params.index(pre.args[i])+1) for i in range(len(pre.args))])
        learning_task.init.append(pddl.conditions.Atom(model_representation_fluent, []))

        model_size += 1

    filtered_known_adds = [eff for eff in action.effects if not eff.literal.negated and eff.literal.predicate in adds_filter]
    for eff in filtered_known_adds:
        model_representation_fluent = "add_" + "_".join(
            [eff.literal.predicate] + [action.name] + ["var" + str(action_params.index(eff.literal.args[i]) + 1) for i in
                                               range(len(eff.literal.args))])
        learning_task.init.append(pddl.conditions.Atom(model_representation_fluent, []))
        model_size += 1

    filtered_known_dels = [eff for eff in action.effects if eff.literal.negated and eff.literal.predicate in dels_filter]
    for eff in filtered_known_dels:
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

plan_type = ""
if validation_mode:
    plan_type = "-P 0"
    ending_horizon = ""


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
        keys = "(insert_add_"
        if keys in line:
            aux = line.replace("\n", "").replace(")", "").split(keys)[1].split(" ")
            action = aux[0].split("_")[1:] + aux[1:]
            indexa = [a.name for a in actions].index(action[0])
            pred = [aux[0].split("_")[0]]
            if [aux[0].split("_")[2:]][0] != ['']:
                pred = pred + [aux[0].split("_")[2:]][0]
                adds[indexa].append(pred)
        keys = "(validate_1)"
        if keys in line:
            break

    # Add known preconditions and effects
    for indexa in range(len(actions)):
        action = actions[indexa]
        action_params = [p.name for p in action.parameters]
        known_pres = list()
        if type(action.precondition) is pddl.Conjunction and len(action.precondition.parts) > 0:
            known_pres = action.precondition.parts
        elif type(action.precondition) is pddl.Atom:
            known_pres = [action.precondition]
        for pre in known_pres:
            if type(pre) is pddl.conditions.Truth:
                continue
            precondition = [pre.predicate] + ["var" + str(action_params.index(pre.args[i]) + 1) for i in
                                                   range(len(pre.args))]
            pres[indexa].append(precondition)

        for eff in action.effects:
            if not eff.literal.negated:
                effect = [eff.literal.predicate] + ["var" + str(action_params.index(eff.literal.args[i]) + 1)
                                                               for i in
                                                               range(len(eff.literal.args))]
                adds[indexa].append(effect)
            else:
                effect = [eff.literal.predicate] + ["var" + str(action_params.index(eff.literal.args[i]) + 1)
                                                               for i in
                                                               range(len(eff.literal.args))]
                dels[indexa].append(effect)

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
        elif "delete_" in line:
            deletes += 1
        else:
            break
    file.close()

    semPrecision = np.float64(model_size - deletes) / model_size
    semRecall = np.float64(model_size - deletes) / (model_size - deletes + inserts)

    # print("{} & {} & {} \\\\".format(domain_name, semPrecision, semRecall))
    # print("{}. Distance: {}".format(domain_name, str(inserts + deletes)))
    print(str(inserts + deletes))


