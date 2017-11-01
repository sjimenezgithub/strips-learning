#! /usr/bin/env python
# from __future__ import division
import  sys
import pddl, pddl_parser
import numpy as np


# **************************************#
# MAIN
# **************************************#
try:
   cmdargs = sys.argv[1:]

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
   print sys.argv[0] + " [-p <partial domain>] <reference domain> <evaluation domain>  <aux problem>"
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
    # Creating a FD task with the domain to evaluate and the aux problem file
    fd_par_domain = pddl_parser.pddl_file.parse_pddl_file("domain", partial_domain_filename)
    fd_par_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_par_domain, fd_problem)
    known_actions = [a.name for a in fd_par_task.actions]


ref_pres = set()
eva_pres = set()
ref_adds = set()
eva_adds = set()
ref_dels = set()
eva_dels = set()




# Build the pre/add/del sets
# Each element of the set is a tuple (action name, literal)
for action in fd_ref_task.actions:
    if action.name not in known_actions:
        # Preconditions
        if isinstance(action.precondition, pddl.conditions.Atom):
            ref_pres.add((action.name,action.precondition))
        else:
            ref_pres.update([(action.name, x) for x in action.precondition.parts])
        # Effects
        for effect in action.effects:
            if effect.literal.negated:
                ref_dels.add((action.name, effect.literal))
            else:
                ref_adds.add((action.name, effect.literal))


for action in fd_eva_task.actions:
    if action.name not in known_actions:
        # Preconditions
        if isinstance(action.precondition, pddl.conditions.Atom):
            eva_pres.add((action.name,action.precondition))
        else:
            eva_pres.update([(action.name, x) for x in action.precondition.parts])
        # Effects
        for effect in action.effects:
            if effect.literal.negated:
                eva_dels.add((action.name, effect.literal))
            else:
                eva_adds.add((action.name, effect.literal))


# Compute precision and recall
precision_pres = np.float64(len(ref_pres.intersection(eva_pres)))/len(eva_pres)
recall_pres = np.float64(len(ref_pres.intersection(eva_pres)))/len(ref_pres)
precision_adds = np.float64(len(ref_adds.intersection(eva_adds)))/len(eva_adds)
recall_adds = np.float64(len(ref_adds.intersection(eva_adds)))/len(ref_adds)
precision_dels = np.float64(len(ref_dels.intersection(eva_dels)))/len(eva_dels)
recall_dels = np.float64(len(ref_dels.intersection(eva_dels)))/len(ref_dels)


print("Pres: precision={}, recall={}".format(precision_pres, recall_pres))
print("Adds: precision={}, recall={}".format(precision_adds, recall_adds))
print("Dels: precision={}, recall={}".format(precision_dels, recall_dels))
print("Total: precision={}, recall={}".format((precision_pres + precision_adds + precision_dels) / 3, (recall_pres + recall_adds + recall_dels) / 3))

sys.exit(0)
