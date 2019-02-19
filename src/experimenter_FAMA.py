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
        index = sys.argv.index("-s")
        check_static_predicates = "-s "
        sys.argv.pop(index)
    else:
        check_static_predicates = ""


    if "-i" in sys.argv:
        index = sys.argv.index("-i")
        use_invariants = "-i "
        sys.argv.pop(index)
    else:
        use_invariants = ""


    if "-g" in sys.argv:
        index = sys.argv.index("-g")
        positive_goal = "-g "
        sys.argv.pop(index)
    else:
        positive_goal = ""


    if "-f" in sys.argv:
        index = sys.argv.index("-f")
        finite_steps = "-f "
        sys.argv.pop(index)
    else:
        finite_steps = ""


    if "-t" in sys.argv:
        index = sys.argv.index("-t")
        trace_prefix = sys.argv[index+1]
        sys.argv.pop(index)
        sys.argv.pop(index)
    else:
        trace_prefix = "trace"

    if "-l" in sys.argv:
        index = sys.argv.index("-l")
        trace_min = int(sys.argv[index+1])
        trace_max = int(sys.argv[index+2])
        sys.argv.pop(index)
        sys.argv.pop(index)
        sys.argv.pop(index)
    else:
        trace_min = None

    if "-avg" in sys.argv:
        index = sys.argv.index("-avg")
        avg = int(sys.argv[index+1])
        sys.argv.pop(index)
        sys.argv.pop(index)
    else:
        avg = None

    domain_folder_name  = sys.argv[1]
    action_observability = sys.argv[2]
    state_observability = sys.argv[3]
    goal_observability = sys.argv[4]

except:
    print "Usage:"
    print sys.argv[0] + "[-s] <domain folder> <action observability (0-100)> <state observability (0-100)> <goal observability (0-100)>"
    sys.exit(-1)


# outdir = "results/" + s + "-"+ d + "/"
# cmd = "mkdir " + outdir
# print("\n\nExecuting... " + cmd)
# os.system(cmd)
base_cmd = config.PROJECT_PATH + "src/FAMA.py " + use_invariants + positive_goal + finite_steps + check_static_predicates + domain_folder_name + " " + action_observability + " " + state_observability + " " + goal_observability + " -t " + trace_prefix
if avg == None:

    if trace_min != None:
        cmd = base_cmd + " -l {} {}".format(trace_min, trace_max)
    else:
        cmd = base_cmd
    # print("\n\nExecuting... " + cmd)

    tic = time.time()
    os.system(cmd)
    toc = time.time()

    processing_time = toc - tic

    try:
        domain_name, best_evaluation, best_matches = model_evaluator.evaluate("learned_domain.pddl", domain_folder_name+"ref_domain", True)
        print(" & ".join(
        [domain_name] + [str(round(e, 2)) for e in best_evaluation]) + " & {}".format(round(processing_time,2)) + " \\\\" + " % {}".format(best_matches))
    except:
        print("No solution found")

else:
    global_results = np.array([0. for _ in range(9)])
    timeouts = 0
    for i in range(avg):
        cmd = base_cmd + " -l {} {}".format(i, i+1)
        # print("\n\nExecuting... " + cmd)

        tic = time.time()
        os.system(cmd)
        toc = time.time()

        processing_time = toc - tic

        try:
            domain_name, best_evaluation, best_matches = model_evaluator.evaluate("learned_domain.pddl",
                                                                                  domain_folder_name + "ref_domain",
                                                                                  True)
            results = np.array([e for e in best_evaluation] + [processing_time])
            global_results += results
            # print(" & ".join([domain_name] + [str(round(e, 2)) for e in best_evaluation] + [str(round(processing_time,2))]))


        except:
            timeouts += 1
            results = np.array([0. for _ in range(9)] + [processing_time])

    global_results /= avg
    print(" & ".join([domain_name] + [str(round(e, 2)) for e in global_results]) + " // " + str(timeouts))



sys.exit(0)