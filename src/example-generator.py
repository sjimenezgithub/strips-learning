#! /usr/bin/env python
import sys, os, copy, glob, itertools
import pddl, pddl_parser
import fdtask_to_pddl, policy
import config


def get_types(task,onames):
   output=[]  
   for a in onames:
      for o in task.objects:
         if a== o.name:
            output=output + [o.type_name]
   return output


def ppossible(p,types):
   if len(p.arguments)!=len(types):
      return False
   
   for i in range(0,len(p.arguments)):
      if (p.arguments[i].type_name!=types[i]):
         return False
   return True


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


FD_PATH="/home/slimbook/software/fd/"
FD_CALL="/fast-downward.py --alias seq-sat-lama-2011 "
FD_PARAMS=""

M_PATH=config.PLANNER_PATH
M_CALL="/M"
M_PARAMS=config.PLANNER_PARAMS
PLANNER_OUT="planner.log"


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
if planner == "FD":
   cmd = "rm sas_plan*; ulimit -t 200;" + FD_PATH + FD_CALL + " " + aux_domain_filename + " " + aux_problem_filename +  " " + FD_PARAMS+ " > " + PLANNER_OUT
   action_id=1
else:
   cmd = "rm sas_plan*; ulimit -t 200;" + M_PATH + M_CALL + " "  + aux_domain_filename + " " + aux_problem_filename +  " " + M_PARAMS+ " > " + PLANNER_OUT
   action_id=0
print("\n\nExecuting... " + cmd)
os.system(cmd)

plan_files = glob.glob("sas_plan*")
plan_files.sort()
plan_filename = plan_files[-1]
print plan_filename

state=policy.State([])
for l in fd_task.init:
   if not isinstance(l,pddl.f_expression.FunctionAssignment) and l.predicate!="=":
      state.addLiteral(policy.Literal(l.predicate,[str(arg) for arg in l.args]))

      
# Running VAL
cmd = "rm " + config.VAL_OUT + ";"+config.VAL_PATH+"/validate -v " + domain_filename + " " + problem_filename + " " + plan_filename + " > " + config.VAL_OUT
print("\n\nExecuting... " + cmd)
os.system(cmd)

file = open(config.VAL_OUT, 'r')
actions = []
states = []
plan_size = 0
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
      if ((i%nsteps)==0 and i>0): 
         for l in states[i-nsteps].literals:
            fd_task.init.append(pddl.conditions.Atom(l.name,l.args))
      else:
         for l in states[(counter-1)*nsteps].literals:
            fd_task.init.append(pddl.conditions.Atom(l.name,l.args))         
      
      goals = []
      for l in states[i].literals:
         goals = goals + [pddl.conditions.Atom(l.name,l.args)]

      # Negative
      for p in fd_task.predicates:
         if p.name !="=":
            allargs=itertools.product([str(o.name) for o in fd_task.objects], repeat=len(p.arguments))
            
            for arg in [aux for aux in list(allargs) if ppossible(p,get_types(fd_task,aux))]:                  
               if states[i].findLiteral(policy.Literal(p.name,arg))==-1:
                  goals = goals + [pddl.conditions.NegatedAtom(p.name,arg)]
         
      fd_task.goal=pddl.conditions.Conjunction(goals)

      # Writing the compilation output domain and problem
      fdomain=open("test-"+str(counter).zfill(2) +".pddl","w")
      fdomain.write(fdtask_to_pddl.format_problem(fd_task,fd_problem))
      fdomain.close()                  
                  
      counter=counter+1

      
# Output the examples plans
counter = 1
for i in range(0,len(actions)):
   if (i%nsteps)==0:      
      fdomain=open("plan-"+str(counter).zfill(2) +".txt","w")
      index=0
      counter=counter+1
      
   fdomain.write(str(index)+": "+str(actions[i])+"\n")
   index = index + 1
   
   if (i%nsteps)==(nsteps-1):
      fdomain.close()
      
sys.exit(0)
