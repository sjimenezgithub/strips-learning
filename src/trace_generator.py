#! /usr/bin/env python
import sys, os, copy, glob, itertools, random
import pddl, pddl_parser
import fdtask_to_pddl, planning
import config

# Madagascar details
M_PATH = config.PLANNER_PATH
M_CALL = "/" + config.PLANNER_NAME
M_PARAMS = " -W " + config.PLANNER_PARAMS

# FD details
FD_PATH = "/home/slimbook/software/fd/"
FD_CALL = "/fast-downward.py --alias seq-sat-lama-2011 "
FD_PARAMS = ""

# LPG details
LPG_PATH = config.PROJECT_PATH + "util/lpg/"
LPG_CALL = "lpg-td-1.0 "
LPG_PARAMS = " -n 1 -v off -out sas_plan"

# **************************************#
# MAIN
# **************************************#
try:
    domain_filename = sys.argv[1]
    problem_filename = sys.argv[2]
    planner = sys.argv[3]

except:
    print "Usage:"
    print sys.argv[0] + " <domain> <problem> <planner> "
    sys.exit(-1)

# Creating a FD task with the domain and the problem file
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

# Running the planner
PLANNER_OUT = "aux_planner.log"
if planner == "FD":
    cmd = "rm sas_plan*; ulimit -t 200;" + FD_PATH + FD_CALL + " " + domain_filename + " " + problem_filename + " " + FD_PARAMS + " > " + PLANNER_OUT
if planner == "M":
    cmd = "rm sas_plan*; ulimit -t 200;" + M_PATH + M_CALL + " " + domain_filename + " " + problem_filename + " " + M_PARAMS + " > " + PLANNER_OUT
if planner == "LPG":
    cmd = "rm sas_plan*; ulimit -t 20;" + LPG_PATH + LPG_CALL + " -o " + domain_filename + " -f " + problem_filename + " " + LPG_PARAMS + " > " + PLANNER_OUT
print("\n\nExecuting... " + cmd)
os.system(cmd)

try:
    # Loading the plan
    plan_files = glob.glob("sas_plan*")
    plan_files.sort()
    plan_filename = plan_files[-1]
    plan = planning.Plan([])
    plan.read_plan(plan_filename)
    plan.write_plan(plan_filename)
except:
    print("No plan generated")
    sys.exit(-1)

# Generating the state trajectory
states = planning.VAL_computation_state_trajectory(domain_filename, problem_filename, plan_filename)

# Output the trace
counter = 1
for i in range(0, len(plan.actions)):
    if (i == 0):
        # HEAD
        fdomain = open("observation-" + str(counter).zfill(2) + ".txt", "w")
        index = 0
        counter = counter + 1
        fdomain.write("(solution \n")
        fdomain.write("(:objects ")
        str_out = ""
        for o in sorted(set(fd_task.objects)):
            str_out = str_out + str(o).replace(":", " - ") + " "
        str_out = str_out + ")\n"
        str_out = str_out + "(:init " + str(states[0]) + ")\n\n"
        fdomain.write(str_out)

    # BODY
    fdomain.write("(:observations " + str(states[i]) + ")\n\n")
    fdomain.write(str(plan.actions[i]) + "\n\n")
    index = index + 1

    if (i == len(plan.actions) - 1):
        # TAIL
        str_out = ""
        states[-1].filter_literals_byName(["inext", "current"] + [str("applied-" + a.name) for a in fd_task.actions])
        str_out = str_out + "(:goal " + str(states[-1]) + "))\n"
        fdomain.write(str_out)
        fdomain.close()

sys.exit(0)
