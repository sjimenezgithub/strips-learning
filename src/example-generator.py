#! /usr/bin/env python
import sys, os, copy, glob, itertools
import pddl, pddl_parser
import fdtask_to_pddl, policy

#**************************************#
# MAIN
#**************************************#   
try:
   domain_filename  = sys.argv[1]
   problem_filename = sys.argv[2]
   nsteps = int(sys.argv[3])
except:
   print "Usage:"
   print sys.argv[0] + " <domain> <problem> <steps>"
   sys.exit(-1)


VAL_PATH="/home/sjimenez/data/software/VAL/"
VAL_OUT="val.log"

FD_PATH="/home/sjimenez/data/software/fd/"
PLANNER_OUT="planner.log"

# Running FD
cmd = "rm sas_plan*;" + FD_PATH + "/fast-downward.py --alias seq-sat-lama-2011 " + domain_filename + " " + problem_filename + " > " + PLANNER_OUT
print("\n\nExecuting... " + cmd)
os.system(cmd)

plan_files = glob.glob("sas_plan*")
plan_files.sort()
plan_filename = plan_files[-1]
print plan_filename

# Creating a FD task with the domain and the problem file
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

state=policy.State([])
for l in fd_task.init:
   if l.predicate!="=":
      state.addLiteral(policy.Literal(l.predicate,[str(arg) for arg in l.args]))

# Running VAL
cmd = "rm " + VAL_OUT + ";"+VAL_PATH+"/validate -v " + domain_filename + " " + problem_filename + " " + plan_filename + " > " + VAL_OUT
#print("\n\nExecuting... " + cmd)
os.system(cmd)

file = open(VAL_OUT, 'r')
actions = []
states = []
plan_size = 0
action_id=1
baction = False
bstate = False
p=policy.Policy([])
for line in file:
   # Reading an action
   if baction==True:
      name = line.replace("\n","").replace("(","").replace(")","").split(" ")[0]      
      args = line.replace("\n","").replace("(","").replace(")","").split(" ")[1:]
      baction = False
      name=name.split("_detdup_")[0]
      actions = actions + [policy.Literal(name,args)]

   if "Plan size: " in line:
      plan_size=int(line.split("Plan size: ")[1])      

   if action_id <= plan_size and str(action_id)+":" in line:
      baction = True
      action_id = action_id +1

   # Adding a new policy rule
   if "Checking next happening (time " in line:
      step = int(line.replace(")\n","").split("Checking next happening (time ")[1])
      p.addRule(policy.Rule(copy.deepcopy(state),actions[step-1]))
      states=states+[copy.deepcopy(state)]      

   if "Deleting " in line:
      name = line.replace("Deleting ","").replace("(","").replace(")\n","").split(" ")[0]
      args = line.replace("Deleting ","").replace("(","").replace(")\n","").split(" ")[1:]
      state.delLiteral(policy.Literal(name,args))

   if "Adding " in line:
      name = line.replace("Adding ","").replace("(","").replace(")\n","").split(" ")[0]
      args = line.replace("Adding ","").replace("(","").replace(")\n","").split(" ")[1:]
      state.addLiteral(policy.Literal(name,args))      
file.close()
states=states+[copy.deepcopy(state)]      


# Output the examples problems
counter = 1
for i in range(0,len(states)):
   fd_task.init=[]
   if ((i%nsteps)==0 and i>0) or (i==len(states)-1 and i>0):
      # Positive 
      for l in states[i-nsteps].literals:
         fd_task.init.append(pddl.conditions.Atom(l.name,l.args))
      
      # Negative
      for p in fd_task.predicates:
         allargs=itertools.product([str(o.name) for o in fd_task.objects], repeat=len(p.arguments))	
         for arg in list(allargs):
            if p.name !="=":
               if states[i-nsteps].findLiteral(policy.Literal(p.name,arg))==-1:
                  fd_task.init.append(pddl.conditions.NegatedAtom(p.name,arg))

      goals = []
      for l in states[i].literals:
         goals = goals + [pddl.conditions.Atom(l.name,l.args)]
      fd_task.goal=pddl.conditions.Conjunction(goals)

      # Writing the compilation output domain and problem
      fdomain=open("test-"+str(counter)+".pddl","w")
      fdomain.write(fdtask_to_pddl.format_problem(fd_task,fd_problem))
      fdomain.close()                  
                  
      counter=counter+1
   
# Output the examples plans
counter = 1
for i in range(0,len(actions)):
   if (i%nsteps)==0:      
      fdomain=open("plan-"+str(counter)+".pddl","w")
      index=0
      counter=counter+1
      
   fdomain.write(str(index)+": "+str(actions[i])+"\n")
   index = index + 1
   
   if (i%nsteps)==(nsteps-1):
      fdomain.close()
      
sys.exit(0)
