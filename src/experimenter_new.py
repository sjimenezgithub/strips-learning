#! /usr/bin/env python
import glob, os, sys, copy, itertools, math
import pddl, pddl_parser
import fdtask_to_pddl
import numpy as np
import model_evaluator
import config

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
    action_observability = sys.argv[2]
    state_observability = sys.argv[3]

except:
    print "Usage:"
    print sys.argv[0] + "[-s] <domain folder> <action observability (0-1)> <state observability (0-1)>"
    sys.exit(-1)


# outdir = "results/" + s + "-"+ d + "/"
# cmd = "mkdir " + outdir
# print("\n\nExecuting... " + cmd)
# os.system(cmd)

cmd = config.PROJECT_PATH + "src/compiler_new.py " + domain_folder_name + " " + action_observability + " " + state_observability
# print("\n\nExecuting... " + cmd)
os.system(cmd)

domain_name, best_evaluation, best_matches = model_evaluator.evaluate("learned_domain.pddl", domain_folder_name+"ref_domain", True)
print(" & ".join(
    [domain_name] + [str(round(e, 2)) for e in best_evaluation]) + " \\\\" + " % {}".format(
    best_matches))



sys.exit(0)