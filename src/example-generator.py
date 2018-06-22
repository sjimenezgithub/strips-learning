#! /usr/bin/env python
import sys, os, copy, glob, itertools
import pddl, pddl_parser
import fdtask_to_pddl, planning
import config

# Madagascar details
M_PATH=config.PLANNER_PATH
M_CALL="/"+config.PLANNER_NAME
M_PARAMS=config.PLANNER_PARAMS

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

   if "-h" in sys.argv:
      sys.argv.remove("-h")      
      nhorizon = int(sys.argv[5])
   else:
      nhorizon = 0                
   
except:
   print "Usage:"
   print sys.argv[0] + " <domain> <problem> <planner> <steps> <-h horizon>"
   sys.exit(-1)

# Creating a FD task with the domain and the problem file
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

# Modifying domain and problem when planning for horizon
if nhorizon > 0:
   fd_task.types.append(pddl.pddl_types.Type("step", "None"))
   fd_task.predicates.append(pddl.predicates.Predicate("current", [pddl.pddl_types.TypedObject("?i", "step")]))
   fd_task.predicates.append(pddl.predicates.Predicate("inext", [pddl.pddl_types.TypedObject("?i1", "step"), pddl.pddl_types.TypedObject("?i2", "step")]))

   for a in fd_task.actions:
      params = []
      params += [pddl.pddl_types.TypedObject("?i1", "step")]
      params += [pddl.pddl_types.TypedObject("?i2", "step")]
   
      pre = []
      pre += [pddl.conditions.Atom("current", ["?i1"])]
      pre += [pddl.conditions.Atom("inext", ["?i1", "?i2"])]

      if isinstance(a.precondition, pddl.conditions.Atom):
         pre.append(a.precondition)
      else:
         pre.extend([x for x in a.precondition.parts])
   
      a.effects += [pddl.effects.Effect(params, pddl.conditions.Conjunction(pre), pddl.conditions.NegatedAtom("current", ["?i1"]))]
      a.effects += [pddl.effects.Effect(params, pddl.conditions.Conjunction(pre), pddl.conditions.Atom("current", ["?i2"]))]
      
   for i in range(1, nhorizon + 1):
      fd_task.objects.append(pddl.pddl_types.TypedObject("i" + str(i), "step"))

   for i in range(2, nhorizon+1):
      fd_task.init.append(pddl.conditions.Atom("inext", ["i" + str(i-1), "i" + str(i)]))
      
   fd_task.init.append(pddl.conditions.Atom("current", ["i1"]))   
   fd_task.goal = pddl.conditions.Conjunction([pddl.conditions.Atom("current", ["i"+str(nhorizon)])])


aux_domain_filename = "aux_domain.pddl"     
fdomain = open(aux_domain_filename, "w")
fdomain.write(fdtask_to_pddl.format_domain(fd_task, fd_domain))
fdomain.close()
   
aux_problem_filename = "aux_problem.pddl"
fproblem = open(aux_problem_filename, "w")
fproblem.write(fdtask_to_pddl.format_problem(fd_task, fd_domain))
fproblem.close()


# Running the planner
PLANNER_OUT="aux_planner.log"   
if planner == "FD":
   cmd = "rm sas_plan*; ulimit -t 200;" + FD_PATH + FD_CALL + " " + aux_domain_filename + " " + aux_problem_filename +  " " + FD_PARAMS+ " > " + PLANNER_OUT
if planner == "M":
   cmd = "rm sas_plan*; ulimit -t 200;" + M_PATH + M_CALL + " "  + aux_domain_filename + " " + aux_problem_filename +  " " + M_PARAMS+ " > " + PLANNER_OUT
if planner == "LPG":
   cmd = "rm sas_plan*; ulimit -t 200;" + LPG_PATH + LPG_CALL + " -o "  + aux_domain_filename + " -f " + aux_problem_filename +  " " + LPG_PARAMS+ " > " + PLANNER_OUT
print("\n\nExecuting... " + cmd)
os.system(cmd)


# Loading the plan
plan_files = glob.glob("sas_plan*")
plan_files.sort()
plan_filename = plan_files[-1]
plan = planning.Plan([])
plan.read_plan(plan_filename)
plan.write_plan(plan_filename)


# Generating the state trajectory
states = planning.VAL_computation_state_trajectory(aux_domain_filename,aux_problem_filename,plan_filename)


# Output the examples problems
counter = 1
aux = [o for o in fd_task.objects if o.type_name!="step" and o.name!="kitchen"]
fd_task.objects = aux
for i in range(0,len(states)):
   fd_task.init=[]
   if ((i%nsteps)==0 and i>0) or (i==len(states)-1 and i>0):
      # Positive
      if ((i%nsteps)==0 and i>0): 
         for l in states[i-nsteps].literals:
            if l.name != "inext" and l.name != "current":             
               fd_task.init.append(pddl.conditions.Atom(l.name,l.args))
      else:
         for l in states[(counter-1)*nsteps].literals:
            if l.name != "inext" and l.name != "current":             
               fd_task.init.append(pddl.conditions.Atom(l.name,l.args))         
      
      goals = []
      for l in states[i].literals:
         if l.name != "inext" and l.name != "current": 
            goals = goals + [pddl.conditions.Atom(l.name,l.args)]                  
      fd_task.goal=pddl.conditions.Conjunction(goals)

      # Writing the compilation output domain and problem
      fdomain=open("test-"+str(counter).zfill(2) +".pddl","w")
      fdomain.write(fdtask_to_pddl.format_problem(fd_task,fd_problem))
      fdomain.close()                  
                  
      counter=counter+1

      
# Output the examples plans
counter = 1
for i in range(0,len(plan.actions)):
   if (i%nsteps)==0:      
      fdomain=open("plan-"+str(counter).zfill(2) +".txt","w")
      index=0
      counter=counter+1
      
   fdomain.write(str(index)+": "+str(plan.actions[i])+"\n")
   index = index + 1
   
   if (i%nsteps)==(nsteps-1):
      fdomain.close()

      
# Output the observations
counter = 1
for i in range(0,len(plan.actions)):
   if (i%nsteps)==0:
      # HEAD
      fdomain=open("observation-"+str(counter).zfill(2) +".txt","w")
      index=0
      counter=counter+1
      fdomain.write("(solution \n")
      fdomain.write("(:objects ")
      str_out = ""
      for o in sorted(set(fd_task.objects)):
         str_out = str_out + str(o).replace(":"," - ") + " "
      str_out = str_out + ")\n"
      states[0].filter_literals_byName(["inext","current"])
      str_out = str_out +"(:init " + str(states[0]) + ")\n\n"      
      fdomain.write(str_out)


   # BODY
   states[i].filter_literals_byName(["inext","current"])
   fdomain.write("(:observations " + str(states[i])+")\n\n")
   fdomain.write(str(plan.actions[i])+"\n\n")
   index = index + 1

   
   if (i%nsteps)==(nsteps-1):
      # TAIL
      str_out = ""
      states[-1].filter_literals_byName(["inext","current"])
      str_out = str_out +"(:goal " + str(states[-1]) + "))\n"
      fdomain.write(str_out)      
      fdomain.close()
      
      
sys.exit(0)
