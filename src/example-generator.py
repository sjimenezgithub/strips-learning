#! /usr/bin/env python
import sys, os, glob
import pddl, pddl_parser
import fdtask_to_pddl, planning
import config


# Madagascar details
M_PATH=config.PLANNER_PATH
M_CALL="/"+config.PLANNER_NAME
M_PARAMS=" -W -T 150 -F 150 -P 1 -S 20 -Q -o " + config.OUTPUT_FILENAME

# FD details
FD_PATH="/home/slimbook/software/fd/"
FD_CALL="/fast-downward.py --alias seq-sat-lama-2011 "
FD_PARAMS=""

# LPG details
LPG_PATH="/home/slimbook/software/LPG-td-1.0/"
LPG_CALL="lpg-td-1.0 "  
LPG_PARAMS=" -n 1 -v off -out sas_plan"


#**************************************#
# MAIN
#**************************************#   
try:
   domain_filename  = sys.argv[1]
   problem_filename = sys.argv[2]
   planner = sys.argv[3]   
   nsteps = int(sys.argv[4])
   nhorizon = int(sys.argv[5])      
except:
   print "Usage:"
   print sys.argv[0] + " <domain> <problem> <planner> <steps> <horizon>"
   sys.exit(-1)

   
# Creating a FD task with the domain and the problem file
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

# Computing a plan until it has the desired length
plan = planning.Plan([])
while (len(plan.actions)<nhorizon):
   cmd = "./cleanup.py" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)

   
   # Running the planner
   PLANNER_OUT="planner.log"   
   if planner == "FD":
      cmd = "rm sas_plan*; ulimit -t 200;" + FD_PATH + FD_CALL + " " + domain_filename + " " + problem_filename +  " " + FD_PARAMS+ " > " + PLANNER_OUT
   if planner == "M":
      cmd = "rm sas_plan*; ulimit -t 200;" + M_PATH + M_CALL + " "  + domain_filename + " " + problem_filename +  " " + M_PARAMS+ " > " + PLANNER_OUT
   if planner == "LPG":
      cmd = "rm sas_plan*; ulimit -t 200;" + LPG_PATH + LPG_CALL + " -o "  + domain_filename + " -f " + problem_filename +  " " + LPG_PARAMS+ " > " + PLANNER_OUT

   print("\n\nExecuting... " + cmd)
   os.system(cmd)

   # Loading the plan
   plan_files = glob.glob("sas_plan*")
   plan_files.sort()
   plan_filename = plan_files[-1]
   plan = planning.Plan([])
   plan.read_plan(plan_filename)
   plan.write_plan(plan_filename)


# Generating the state trajectory induced by the plan
states = planning.VAL_computation_state_trajectory(domain_filename,problem_filename,plan_filename)


# Output the examples problems
counter = 0
aux = [o for o in fd_task.objects if o.name!="kitchen"]
fd_task.objects = aux
for i in range(0,len(states)):
   fd_task.init=[]
   if ((i%nsteps)==0 and i>0) or (i==len(states)-1 and i>0):
      # Positive
      if ((i%nsteps)==0 and i>0): 
         for l in states[i-nsteps].literals:
            fd_task.init.append(pddl.conditions.Atom(l.name,l.args))
      else:
         for l in states[(counter-1)*nsteps].literals:
            fd_task.init.append(pddl.conditions.Atom(l.name,l.args))         
      
      goals = []
      for l in states[i].literals:
         goals = goals + [pddl.conditions.Atom(l.name,l.args)]                  
      fd_task.goal=pddl.conditions.Conjunction(goals)

      # Writing the compilation output domain and problem
      counter=counter+1
      fdomain=open("test-"+str(counter).zfill(2) +".pddl","w")
      fdomain.write(fdtask_to_pddl.format_problem(fd_task,fd_problem))
      fdomain.close()                  
                  

      
# Output the examples plans
counter = 1
fdomain = open("plan-"+str(counter).zfill(2) +".txt","w")
for i in range(0,len(states)-1):   
   if ((i%nsteps)==0 and i>0):      
      fdomain.close()
      fdomain = open("plan-"+str(counter).zfill(2) +".txt","w")
      counter = counter+1
   fdomain.write(str(i%nsteps)+": "+str(plan.actions[i])+"\n")
fdomain.close()
          
      
# Output the observations
counter = 1
for i in range(0,len(states)):
   # TAIL
   if ((i%nsteps)==0 and i>0) or (i==len(states)-1 and i>0):
      fdomain.write("(:goal " + str(states[i]) + "))\n")
      fdomain.close()
   
   # HEAD
   if (i%nsteps)==0 and i!=(len(states)-1):      
      fdomain=open("ten-observation-"+str(counter).zfill(2) +"","w")
      counter=counter+1
      fdomain.write("(solution \n")
      fdomain.write("(:objects ")
      str_out = ""
      for o in sorted(set(fd_task.objects)):
         str_out = str_out + str(o).replace(":"," - ") + " "
      str_out = str_out + ")\n"
      str_out = str_out +"(:init " + str(states[i]) + ")\n\n"
      fdomain.write(str_out)
      fdomain.write("(:observations " + str(states[i])+")\n\n")
      fdomain.write(str(plan.actions[i])+"\n\n")      

   if ((i%nsteps)==0 and i>0) or (i==len(states)-1 and i>0):
      pass
   # BODY
   elif (i%nsteps)!=0:
      fdomain.write("(:observations " + str(states[i])+")\n\n")
      fdomain.write(str(plan.actions[i])+"\n\n")          

      

sys.exit(0)
