#! /usr/bin/env python
import glob, os, sys, copy, itertools, math, time
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
        check_static_predicates = "-s "
        sys.argv.remove("-s")
    else:
        check_static_predicates = ""


    if "-t" in sys.argv:
        index = sys.argv.index("-t")
        trace_prefix = sys.argv[index+1]
        sys.argv.remove("-t")
        sys.argv.remove(trace_prefix)
    else:
        trace_prefix = "trace"

    if "-l" in sys.argv:
        index = sys.argv.index("-l")
        trace_limit = sys.argv[index+1]
        sys.argv.remove("-l")
        sys.argv.remove(sys.argv[index])
    else:
        trace_limit = None

    domain_folder_name  = sys.argv[1]
    action_observability = sys.argv[2]
    state_observability = sys.argv[3]

except:
    print "Usage:"
    print sys.argv[0] + "[-s] <domain folder> <action observability (0-100)> <state observability (0-100)>"
    sys.exit(-1)


# outdir = "results/" + s + "-"+ d + "/"
# cmd = "mkdir " + outdir
# print("\n\nExecuting... " + cmd)
# os.system(cmd)

cmd = config.PROJECT_PATH + "src/compiler_new.py " + check_static_predicates + domain_folder_name + " " + action_observability + " " + state_observability + " -t " + trace_prefix
if trace_limit:
    cmd += " -l " + trace_limit
# print("\n\nExecuting... " + cmd)

tic = time.time()
os.system(cmd)
toc = time.time()

processing_time = toc - tic

try:
    domain_name, best_evaluation, best_matches = model_evaluator.evaluate("learned_domain.pddl", domain_folder_name+"ref_domain", True)
    print(" & ".join(
    [domain_name] + [str(round(e, 2)) for e in best_evaluation]) + "& {}".format(round(processing_time,2)) + " \\\\" + " % {}".format(best_matches))
except:
    print("No solution found")



sys.exit(0)