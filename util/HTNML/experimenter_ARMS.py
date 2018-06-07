#! /usr/bin/env python
import glob, os, sys, copy, itertools, math
import src.pddl, src.pddl_parser
import src.fdtask_to_pddl
import numpy as np
import src.model_evaluator
import src.config

# **************************************#
# MAIN
# **************************************#

try:
    domain_folder_name  = sys.argv[1]
    state_observability = sys.argv[2]
except:
    print "Usage:"
    print sys.argv[0] + " <domain folder> <state observability (0-1)>"
    sys.exit(-1)

domain_path = os.path.expanduser(src.config.PROJECT_PATH + "util/HTML/" + domain_folder_name)

profile = "{}\n" \
          "1\n" \
          "{}\n" \
          "0.1\n" \
          "{}/Maxsat.in\n" \
          "{}/Maxsat1.in\n" \
          "{}/Result.out\n".format(domain_path, state_observability, domain_path, domain_path, domain_path)

profile_path = os.path.expanduser(src.config.PROJECT_PATH + "util/HTNML/Profile")
with open(profile_path, "w") as f:
    f.write(profile)



cmd = src.config.PROJECT_PATH + "util/HTNML/HTNML"
# print("\n\nExecuting... " + cmd)
os.system(cmd)

try:
    domain_name, best_evaluation, best_matches = src.model_evaluator.evaluate("learned_domain.pddl", domain_folder_name + "ref_domain", True)
    print(" & ".join(
    [domain_name] + [str(round(e, 2)) for e in best_evaluation]) + " \\\\" + " % {}".format(
    best_matches))
except:
    print("No solution found")



sys.exit(0)