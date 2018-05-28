#! /usr/bin/env python
# from __future__ import division
import  sys
import pddl, pddl_parser
import numpy as np
import itertools

def reform_literal(literal, action_args, reformulation):
    literal_name = literal.predicate
    params = [action_args[reformulation[action_args.index(arg)]-1] for arg in literal.args]

    return tuple([literal_name] + [tuple(params)])

def valid_parameter_combination(param_comb, action, action_params_dict):
    action_params = action_params_dict[action]
    for i in range(len(param_comb)):
        if action_params[i] != action_params[param_comb[i]-1]:
            return False
    return True

def valid_action_combination(comb, action_params_dict):
    matched_actions = [x[1][0] for x in comb]
    if any(matched_actions.count(x) > 1 for x in matched_actions):
        return False
    actions_fit = [(set(action_params_dict[p[0][0]]) == set(action_params_dict[p[1][0]])) and (len(action_params_dict[p[0][0]]) == len(action_params_dict[p[1][0]])) for p in comb]
    return all(actions_fit)


def evaluate_matching(matchings, eva_actions, ref_actions):
    ref_pres = set()
    eva_pres = set()
    ref_adds = set()
    eva_adds = set()
    ref_dels = set()
    eva_dels = set()

    for match in matchings:
        action_evaluated = match[0]
        matched_action = match[1]
        param_reform = match[2:]
        # Build the pre/add/del sets
        # Each element of the set is a tuple (action name, literal)
        for action in ref_actions:
            if action.name == action_evaluated:
                # Preconditions
                if isinstance(action.precondition, pddl.conditions.Atom):
                    ref_pres.add((action_evaluated, action.precondition.key))
                else:
                    ref_pres.update([(action_evaluated, x.key) for x in action.precondition.parts])
                # Effects
                for effect in action.effects:
                    if effect.literal.negated:
                        ref_dels.add((action_evaluated, effect.literal.key))
                    else:
                        ref_adds.add((action_evaluated, effect.literal.key))
                break

        for action in eva_actions:
            if action.name == matched_action:
                action_args = [arg.name for arg in action.parameters]
                # Preconditions
                if isinstance(action.precondition, pddl.conditions.Atom):
                    eva_pres.add((action_evaluated, reform_literal(action.precondition, action_args, param_reform)))
                else:
                    eva_pres.update([(action_evaluated, reform_literal(x, action_args, param_reform)) for x in action.precondition.parts])
                # Effects
                for effect in action.effects:
                    if effect.literal.negated:
                        eva_dels.add((action_evaluated, reform_literal(effect.literal, action_args, param_reform)))
                    else:
                        eva_adds.add((action_evaluated, reform_literal(effect.literal, action_args, param_reform)))
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


def evaluate(evaluation_domain_filename, reference_domain_filename, reformulation, partial_domain_filename = None):

    # Creating a FD task with the ref domain and the aux problem file
    ref_domain_pddl = pddl_parser.pddl_file.parse_pddl_file("domain", reference_domain_filename)
    domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
                     = pddl_parser.parsing_functions.parse_domain_pddl(ref_domain_pddl)
    ref_actions = actions

    # Creating a FD task with the domain to evaluate and the aux problem file
    eva_domain_pddl = pddl_parser.pddl_file.parse_pddl_file("domain", evaluation_domain_filename)
    domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
                     = pddl_parser.parsing_functions.parse_domain_pddl(eva_domain_pddl)
    eva_actions = actions

    known_actions = list()

    if partial_domain_filename:
        # Creating a FD task with the partial domain and the aux problem file
        partial_domain_pddl = pddl_parser.pddl_file.parse_pddl_file("domain", partial_domain_filename)
        domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
            = pddl_parser.parsing_functions.parse_domain_pddl(partial_domain_pddl)
        known_actions = [a.name for a in actions]


    arities = set()
    actions_arity_list = list()
    action_params_dict = dict()
    for action in ref_actions:
        arity = len(action.parameters)
        action_name = action.name
        action_params = [p.type_name for p in action.parameters]
        action_params_dict[action_name] = action_params
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
        actions_name_by_arity = list()
        for ar in arities:
            actions = list()
            actions_names = list()
            for action,arity in actions_arity_list:
                if arity == ar:
                    params = [i for i in range(1, arity + 1)]
                    for param_comb in itertools.permutations(params, ar):
                        if valid_parameter_combination(param_comb, action, action_params_dict):
                            actions.append(tuple([action] + [x for x in param_comb]))
                    actions_names.append(action)
            actions_by_arity.append((ar, actions))
            actions_name_by_arity.append((ar, actions_names))


        combinations_by_arity = list()
        for i in range(len(actions_by_arity)):
            arity = actions_by_arity[i][0]
            actions = actions_by_arity[i][1]

            proper_actions = [tuple([x]+[i for i in range(1,arity+1)]) for x in actions_name_by_arity[i][1]]

            combinations = [zip(proper_actions, x) for x in itertools.permutations(actions, len(proper_actions))]
            # combinations = [zip(x, actions) for x in itertools.product(proper_actions, actions)]
            if len(proper_actions) > 1:
                for comb in combinations:
                    if not valid_action_combination(comb, action_params_dict):
                        combinations.remove(comb)
            combinations_by_arity.append((arity, combinations))
            # print(combinations)


        combinations_by_arity = [[[tuple([p[0][0]] + [e for e in p[1]]) for p in comb] for comb in combinations_by_arity[i][1]] for i in range(len(combinations_by_arity))]
        # for e in combinations_by_arity:
        #     print(e)

        # combinations_by_arity2 = list()
        # for ar, combs in combinations_by_arity:
        #     params = [i for i in range(1,ar+1)]
        #     aux = list()
        #     for param_comb in itertools.permutations(params, ar):
        #         for comb in combs:
        #             print(tuple([comb[0][0]]+ [comb[0][1]] + [x for x in param_comb]))

        action_combinations = combinations_by_arity[0]
        for i in range(1, len(combinations_by_arity)):
            # action_combinations = [zip(x, combinations_by_arity[i][1]) for x in itertools.permutations(action_combinations, len(combinations_by_arity[i][1]))]
            aux = list()
            for c in itertools.product(action_combinations, combinations_by_arity[i]):
                aux2 = [x for x in c[0]]
                aux2.extend(c[1])
                aux.append(aux2)
            action_combinations = aux

        matching_list = action_combinations

    best_score = -1
    best_evaluation = None
    best_matches = None
    for matches in matching_list:
        evaluation = evaluate_matching(matches, eva_actions, ref_actions)
        if evaluation[6] + evaluation[7] > 0:
            f1_score = 2 * (evaluation[6] * evaluation[7]) / (evaluation[6] + evaluation[7])
        else:
            f1_score = 0.0
        if f1_score > best_score:
            best_score = f1_score
            best_evaluation = evaluation
            best_matches = matches
        # print(f1_score, matches)

    return domain_name, best_evaluation, best_matches



# **************************************#
# MAIN
# **************************************#

if __name__ == "__main__":
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
    except:
       print "Usage:"
       print sys.argv[0] + " [-r] [-p <partial domain>] <reference domain> <evaluation domain>"
       sys.exit(-1)

    domain_name, best_evaluation, best_matches = evaluate(evaluation_domain_filename, reference_domain_filename, reformulation)

    # print(best_matches)

    # print("Pres: precision={}, recall={}".format(best_evaluation[0], best_evaluation[1]))
    # print("Adds: precision={}, recall={}".format(best_evaluation[2], best_evaluation[3]))
    # print("Dels: precision={}, recall={}".format(best_evaluation[4], best_evaluation[5]))
    # print("Total: precision={}, recall={}".format(best_evaluation[6], best_evaluation[7]))
    print(" & ".join([domain_name] + [str(round(e, 2)) for e in best_evaluation]) + " \\\\" + " % {}".format(best_matches))

    sys.exit(0)
