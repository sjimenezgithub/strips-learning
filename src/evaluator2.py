#! /usr/bin/env python
# from __future__ import division
import  sys
import pddl, pddl_parser
import numpy as np
import itertools

def evaluate_matching(matchings, fd_eva_task, fd_ref_task):
    ref_pres = set()
    eva_pres = set()
    ref_adds = set()
    eva_adds = set()
    ref_dels = set()
    eva_dels = set()

    for match in matchings:
        action_evaluated = match[0]
        matched_action = match[1]
        # Build the pre/add/del sets
        # Each element of the set is a tuple (action name, literal)
        for action in fd_ref_task.actions:
            if action.name == action_evaluated:
                # Preconditions
                if isinstance(action.precondition, pddl.conditions.Atom):
                    ref_pres.add((action_evaluated, action.precondition))
                else:
                    ref_pres.update([(action_evaluated, x) for x in action.precondition.parts])
                # Effects
                for effect in action.effects:
                    if effect.literal.negated:
                        ref_dels.add((action_evaluated, effect.literal))
                    else:
                        ref_adds.add((action_evaluated, effect.literal))
                break

        for action in fd_eva_task.actions:
            if action.name == matched_action:
                # Preconditions
                if isinstance(action.precondition, pddl.conditions.Atom):
                    eva_pres.add((action_evaluated, action.precondition))
                else:
                    eva_pres.update([(action_evaluated, x) for x in action.precondition.parts])
                # Effects
                for effect in action.effects:
                    if effect.literal.negated:
                        eva_dels.add((action_evaluated, effect.literal))
                    else:
                        eva_adds.add((action_evaluated, effect.literal))
                break

    # Compute precision and recall
    precision_pres = np.float64(len(ref_pres.intersection(eva_pres))) / len(eva_pres)
    recall_pres = np.float64(len(ref_pres.intersection(eva_pres))) / len(ref_pres)
    precision_adds = np.float64(len(ref_adds.intersection(eva_adds))) / len(eva_adds)
    recall_adds = np.float64(len(ref_adds.intersection(eva_adds))) / len(ref_adds)
    precision_dels = np.float64(len(ref_dels.intersection(eva_dels))) / len(eva_dels)
    recall_dels = np.float64(len(ref_dels.intersection(eva_dels))) / len(ref_dels)
    avg_precision = (precision_pres + precision_adds + precision_dels) / 3
    avg_recall = (recall_pres + recall_adds + recall_dels) / 3

    return (precision_pres, recall_pres, precision_adds, recall_adds, precision_dels, recall_dels, avg_precision, avg_recall)



# **************************************#
# MAIN
# **************************************#
try:
   cmdargs = sys.argv[1:]

   if cmdargs[0] == "-r":
       reformulation = True
       cmdargs = cmdargs[1:]
   else:
       reformulation = False

   if cmdargs[0] == "-p":
       partial_domain_filename = cmdargs[1]
       cmdargs = cmdargs[2:]
   else:
       partial_domain_filename = None

   reference_domain_filename  = cmdargs[0]
   evaluation_domain_filename  = cmdargs[1]
   aux_problem_filename  = cmdargs[2]
except:
   print "Usage:"
   print sys.argv[0] + " [-r] [-p <partial domain>] <reference domain> <evaluation domain>  <aux problem>"
   sys.exit(-1)


# reference_domain_filename = "../benchmarks/reference/blocks/domain.pddl"
# evaluation_domain_filename = "learned_domain.pddl"
# aux_problem_filename = "../benchmarks/handpicked/blocks/test-1.pddl"

# Creating a FD task with the ref domain and the aux problem file
fd_ref_domain = pddl_parser.pddl_file.parse_pddl_file("domain", reference_domain_filename)
fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", aux_problem_filename)
fd_ref_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_ref_domain, fd_problem)

# Creating a FD task with the domain to evaluate and the aux problem file
fd_eva_domain = pddl_parser.pddl_file.parse_pddl_file("domain", evaluation_domain_filename)
fd_eva_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_eva_domain, fd_problem)

known_actions = list()

if partial_domain_filename:
    # Creating a FD task with the partial domain and the aux problem file
    fd_par_domain = pddl_parser.pddl_file.parse_pddl_file("domain", partial_domain_filename)
    fd_par_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_par_domain, fd_problem)
    known_actions = [a.name for a in fd_par_task.actions]



arities = set()
actions_arity_list = list()
for action in fd_ref_task.actions:
    arity = len(action.parameters)
    action_name = action.name
    if action_name not in known_actions:
        actions_arity_list.append((action_name, arity))
        arities.add(arity)

if not reformulation:
    matches = list()
    for action_name, arity in actions_arity_list:
        matches.append((action_name, action_name))
    matching_list = [matches]
else:


    actions_by_arity = list()
    for ar in arities:
        actions = list()
        for action,arity in actions_arity_list:
            if arity == ar:
                actions.append(action)
        actions_by_arity.append((ar, actions))


    combinations_by_arity = list()
    for arity, actions in actions_by_arity:
        # combinations = list(itertools.combinations_with_replacement(actions, 2))
        combinations = [zip(x, actions) for x in itertools.permutations(actions, len(actions))]
        combinations_by_arity.append((arity, combinations))
        # print(combinations)



    action_combinations = combinations_by_arity[0][1]
    for i in range(1, len(combinations_by_arity)):
        action_combinations = [zip(x, combinations_by_arity[i][1]) for x in itertools.permutations(action_combinations, len(combinations_by_arity[i][1]))]

    action_combinations = [item for sublist in action_combinations for item in sublist]

    matching_list = list()
    for combination in action_combinations:
        matches = [x for x in combination[0]]
        for i in range(1,len(combination)):
            matches.extend(combination[i])
        matching_list.append(matches)

best_score = 0
best_evaluation = None
for matches in matching_list:
    evaluation = evaluate_matching(matches, fd_eva_task, fd_ref_task)
    f1_score = 2 * (evaluation[6] * evaluation[7]) / (evaluation[6] + evaluation[7])
    print(f1_score, matches)
    if f1_score > best_score:
        best_score = f1_score
        best_evaluation = evaluation
    # print(f1_score, matches)




print("Pres: precision={}, recall={}".format(best_evaluation[0], best_evaluation[1]))
print("Adds: precision={}, recall={}".format(best_evaluation[2], best_evaluation[3]))
print("Dels: precision={}, recall={}".format(best_evaluation[4], best_evaluation[5]))
print("Total: precision={}, recall={}".format(best_evaluation[6], best_evaluation[7]))

sys.exit(0)
