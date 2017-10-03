#! /usr/bin/env python
import glob, os, sys, copy, itertools
import pddl, pddl_parser
import config,fdtask_to_pddl


def get_max_steps_from_plans(ps):
   iout=0
   for plan in ps:
      iout=max(iout,len(plan))
   return iout

def get_max_vars_from_plans(ps):
   iout=0
   for plan in ps:
      for a in plan:
         iout=max(iout,len(a.split(" "))-1)
   return iout

def get_action_schema_from_plans(ps,task):
   schemas=[]
   for plan in ps:
      for a in plan:
         counter = 0         
         name = a.replace("(","").replace(")","").split(" ")[0]
         item = [name]
         for p in a.replace("(","").replace(")","").split(" ")[1:]:            
            for o in task.objects:
               if p.upper() == o.name.upper():
                  item.append(str(o.type_name))
                  counter = counter + 1
                  break
         if item not in schemas:
            schemas.insert(0,item)
   return schemas

def get_predicates_schema_from_plans(task):
   preds=[]
   for p in task.predicates:
      item=[]
      if p.name =="=":
         continue
      item.append(p.name)
      for a in p.arguments:
         item.append(a.type_name)
      preds = preds + [item]
   return preds

def possible_pred_for_action(p,a,tup):
   if (len(p)> len(a)):
      return False
   for typename in p[1:]:
      if not str(typename) in a:
         return False
   for i in range(0,len(tup)):
      if not str(a[int(tup[i])]) in str(p[i+1]):
         return False      
   return True



#**************************************#
# MAIN
#**************************************#   
try:
   domain_folder_name  = sys.argv[1]
   problems_prefix_filename = sys.argv[2]
   plans_prefix_filename = sys.argv[3]
   input_level = int(sys.argv[4])
   
except:
   print "Usage:"
   print sys.argv[0] + " <domain> <problems prefix> <plans prefix> <input level (0 plans, 1 steps, 2 len(plan), 3 minimum)>"
   sys.exit(-1)

   
# Reading the example plans
plans=[]
i = 0
for filename in sorted(glob.glob(domain_folder_name+"/"+plans_prefix_filename+"*")):
   plans.append([])
   lcounter = 0
   file = open(filename, 'r')   
   for line in file:
      if input_level!=config.INPUT_STEPS or (input_level==config.INPUT_STEPS and lcounter %3 != 0):
         plans[i].append(line.replace("\n","").split(": ")[1])
      lcounter = lcounter + 1
   file.close()
   i = i + 1

   
# Creating a FD task with the domain and the first problem file
domain_filename = domain_folder_name+"/domain.pddl"
fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
fd_problems = []
fd_tasks = []
counter = 0
for problem_filename in sorted(glob.glob(domain_folder_name+"/"+problems_prefix_filename+"*")):
   fd_problems = fd_problems + [pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)]
   fd_tasks = fd_tasks + [pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problems[counter])]
   counter = counter + 1
fd_task = copy.deepcopy(fd_tasks[0]) 

MAX_STEPS = get_max_steps_from_plans(plans)
MAX_VARS = get_max_vars_from_plans(plans)
actions = get_action_schema_from_plans(plans,fd_task)
predicates = get_predicates_schema_from_plans(fd_task)


# Compilation Problem
init_aux=copy.deepcopy(fd_task.init)
fd_task.init=[]
fd_task.init.append(pddl.conditions.Atom("programming1",[]))
allpres=[]
for a in actions: # All possible preconditions are initially programmed
   var_ids=[]
   for i in range(1,len(a)):
      var_ids=var_ids+[""+str(i)]   
   for p in predicates:
      for tup in itertools.product(var_ids, repeat=(len(p)-1)):
         if possible_pred_for_action(p,a,tup):       
            vars = ["var"+str(t) for t in tup]         
            fd_task.init.append(pddl.conditions.Atom("pre_"+p[0]+"_"+a[0],vars))
            allpres = allpres + [str("pre_"+p[0]+"_"+a[0]+"_"+"_".join(map(str,vars)))]

if input_level <= config.INPUT_LENPLAN:               
   for i in range(1,MAX_STEPS+1):
      fd_task.init.append(pddl.conditions.Atom("next",["i"+str(i),"i"+str(i+1)]))
            

goals = []
for i in range(0,len(plans)+1):
   goals = goals + [pddl.conditions.Atom("test"+str(i),[""])]
fd_task.goal=pddl.conditions.Conjunction(goals)
               
# Compilation Domain
fd_task.types.append(pddl.pddl_types.Type("var","None"))
if input_level <= config.INPUT_LENPLAN:               
   fd_task.types.append(pddl.pddl_types.Type("step","None"))

for i in range(1,MAX_VARS+1):
   fd_task.objects.append(pddl.pddl_types.TypedObject("var"+str(i),"var"))
   
if input_level <= config.INPUT_LENPLAN:                  
   for i in range(1,MAX_STEPS+2):
      fd_task.objects.append(pddl.pddl_types.TypedObject("i"+str(i),"step"))   
   
fd_task.predicates.append(pddl.predicates.Predicate("programming1",[]))
fd_task.predicates.append(pddl.predicates.Predicate("programming2",[]))
fd_task.predicates.append(pddl.predicates.Predicate("executing",[]))
for i in range(0,len(plans)+1):
   fd_task.predicates.append(pddl.predicates.Predicate("test"+str(i),[]))
if input_level <= config.INPUT_LENPLAN:                  
   fd_task.predicates.append(pddl.predicates.Predicate("current",[pddl.pddl_types.TypedObject("?i","step")]))
   fd_task.predicates.append(pddl.predicates.Predicate("next",[pddl.pddl_types.TypedObject("?i1","step"),pddl.pddl_types.TypedObject("?i2","step")]))

for a in actions:   
   for p in predicates:   
      if (len(p)<= len(a)):
         fd_task.predicates.append(pddl.predicates.Predicate("pre_"+p[0]+"_"+a[0],[pddl.pddl_types.TypedObject("?x"+str(i),"var") for i in range(1,len(p))]))
         fd_task.predicates.append(pddl.predicates.Predicate("del_"+p[0]+"_"+a[0],[pddl.pddl_types.TypedObject("?x"+str(i),"var") for i in range(1,len(p))]))      
         fd_task.predicates.append(pddl.predicates.Predicate("add_"+p[0]+"_"+a[0],[pddl.pddl_types.TypedObject("?x"+str(i),"var") for i in range(1,len(p))]))   

if input_level <= config.INPUT_STEPS:   
   for a in actions:
      fd_task.predicates.append(pddl.predicates.Predicate("plan-"+a[0],[pddl.pddl_types.TypedObject("?i","step")]+[pddl.pddl_types.TypedObject("?o"+str(i),a[i]) for i in range(1,len(a))]))
   
# Original domain actions 
old_actions = copy.deepcopy(actions)
for a in old_actions:
   old_action = copy.deepcopy(a)
   params=[pddl.pddl_types.TypedObject("?o"+str(i),a[i]) for i in range(1,len(a))]
   if input_level <=config.INPUT_LENPLAN and input_level <config.INPUT_MINIMUM:
      params=params+[pddl.pddl_types.TypedObject("?i1","step")]
      params=params+[pddl.pddl_types.TypedObject("?i2","step")]

   pre = [pddl.conditions.Atom("executing",[])]
   if input_level <= config.INPUT_PLANS and input_level <config.INPUT_MINIMUM:
      pre = pre + [pddl.conditions.Atom("plan-"+a[0],["?i1"]+["?o"+str(i) for i in range(1,len(a))])]
      
   if input_level <= config.INPUT_LENPLAN and input_level <config.INPUT_MINIMUM:
      pre = pre + [pddl.conditions.Atom("current",["?i1"])]
      pre = pre + [pddl.conditions.Atom("next",["?i1", "?i2"])]   
   
   for p in predicates:
      str_args="".join(map(str,[""+str(i) for i in range(1,len(old_action))]))
      for tup in itertools.product(str_args, repeat=(len(p)-1)):
         if possible_pred_for_action(p,old_action,tup):             
            disjunction = pddl.conditions.Disjunction([pddl.conditions.NegatedAtom("pre_"+p[0]+"_"+a[0],["var"+str(t) for t in tup])]+[pddl.conditions.Atom(p[0],["?o"+str(t) for t in tup])])
            pre = pre + [disjunction]
      
   eff = []
   if input_level < config.INPUT_STEPS: 
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom("current",["?i1"]))]
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("current",["?i2"]))]
   elif input_level <config.INPUT_MINIMUM:
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom("current",["?i1"]))]
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("current",["?i2"]))]   

   for p in predicates:
      str_args="".join(map(str,[""+str(i) for i in range(1,len(old_action))]))
      for tup in itertools.product(str_args, repeat=(len(p)-1)):
         if possible_pred_for_action(p,old_action,tup):                         
            condition = pddl.conditions.Conjunction([pddl.conditions.Atom("del_"+p[0]+"_"+a[0],["var"+str(t) for t in tup])])      
            eff = eff + [pddl.effects.Effect([],condition,pddl.conditions.NegatedAtom(p[0],["?o"+str(t) for t in tup]))]
      
   for p in predicates:
      str_args="".join(map(str,[""+str(i) for i in range(1,len(old_action))]))
      for tup in itertools.product(str_args, repeat=(len(p)-1)):
         if possible_pred_for_action(p,old_action,tup):                                     
            condition = pddl.conditions.Conjunction([pddl.conditions.Atom("add_"+p[0]+"_"+a[0],["var"+str(t) for t in tup])])
            eff = eff + [pddl.effects.Effect([],condition,pddl.conditions.Atom(p[0],["?o"+str(t) for t in tup]))]
   
   fd_task.actions.append(pddl.actions.Action(a[0],params,len(params),pddl.conditions.Conjunction(pre),eff,0))

   
# Actions for programming the action schema
for a in old_actions:
   var_ids=[]
   for i in range(1,len(a)):
      var_ids=var_ids+[""+str(i)]   
   for p in predicates:
      for tup in itertools.product(var_ids, repeat=(len(p)-1)):
         if possible_pred_for_action(p,a,tup):       
            vars = ["var"+str(t) for t in tup]
            params = []
            pre = []
            pre = pre + [pddl.conditions.Atom("programming1",[])]
            pre = pre + [pddl.conditions.NegatedAtom("programming2",[])]
            pre = pre + [pddl.conditions.NegatedAtom("executing",[])]                        
            pre = pre + [pddl.conditions.Atom("pre_"+p[0]+"_"+a[0],vars)]   
            eff = [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom("pre_"+p[0]+"_"+a[0],vars))]
            fd_task.actions.append(pddl.actions.Action("program_pre_"+p[0]+"_"+a[0]+"_"+"_".join(map(str,vars)),params,len(params),pddl.conditions.Conjunction(pre),eff,0))

            pre = []
            pre = pre + [pddl.conditions.Atom("pre_"+p[0]+"_"+a[0],vars)]
            pre = pre + [pddl.conditions.NegatedAtom("del_"+p[0]+"_"+a[0],vars)]            
            pre = pre + [pddl.conditions.NegatedAtom("add_"+p[0]+"_"+a[0],vars)]
            pre = pre + [pddl.conditions.NegatedAtom("executing",[])]            
            eff = [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("del_"+p[0]+"_"+a[0],vars))]
            eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("programming2",[]))]
            fd_task.actions.append(pddl.actions.Action("program_del_"+p[0]+"_"+a[0]+"_"+"_".join(map(str,vars)),params,len(params),pddl.conditions.Conjunction(pre),eff,0))

            pre = []
            pre = pre + [pddl.conditions.NegatedAtom("pre_"+p[0]+"_"+a[0],vars)]
            pre = pre + [pddl.conditions.NegatedAtom("del_"+p[0]+"_"+a[0],vars)]            
            pre = pre + [pddl.conditions.NegatedAtom("add_"+p[0]+"_"+a[0],vars)]
            pre = pre + [pddl.conditions.NegatedAtom("executing",[])]                        
            eff = [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("add_"+p[0]+"_"+a[0],vars))]
            eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("programming2",[]))]
            fd_task.actions.append(pddl.actions.Action("program_add_"+p[0]+"_"+a[0]+"_"+"_".join(map(str,vars)),params,len(params),pddl.conditions.Conjunction(pre),eff,0))

         
# Actions for programming the tests
pre = [pddl.conditions.NegatedAtom("executing",[])]

eff = [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("test0",[]))]
for f in init_aux:
   if f.predicate!="=":
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),f)]

if input_level <= config.INPUT_LENPLAN:               
   eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("current",["i1"]))]

if input_level <= config.INPUT_STEPS:
   for i in range(0,len(plans[0])):
      action=plans[0][i]
      name=action[1:-1].split(" ")[0]
      params=action[1:-1].split(" ")[1:]
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("plan-"+name,["i"+str(i+1)]+params))]
      
eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("executing",[]))]
fd_task.actions.append(pddl.actions.Action("test_0",[],0,pddl.conditions.Conjunction(pre),eff,0))

for i in range(0,len(plans)):   
   pre = []
   pre = pre + [pddl.conditions.Atom("executing",[])]
   for j in range(0,len(plans)+1):
      if j<i+1:
         pre = pre + [pddl.conditions.Atom("test"+str(j),[])]
      else:
         pre = pre + [pddl.conditions.NegatedAtom("test"+str(j),[])]
         
   if input_level <= config.INPUT_LENPLAN:                        
      pre = pre + [pddl.conditions.Atom("current",["i"+str(len(plans[i])+1)])]
   for g in fd_tasks[i].goal.parts:
      pre = pre + [g]   
   
   eff = []
   eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("test"+str(i+1),[]))]   
   if input_level <= config.INPUT_LENPLAN:                           
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom("current",["i"+str(len(plans[i])+1)]))]      
      eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom("current",["i1"]))]

   if input_level <= config.INPUT_STEPS:                        
      for j in range(0,len(plans[i])):
         name = "plan-"+plans[i][j].replace("(","").replace(")","").split(" ")[0]
         pars = ["i"+str(j+1)]+plans[i][j].replace("(","").replace(")","").split(" ")[1:]
         eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom(name,pars))]
      if i<len(plans)-1:
         for j in range(0,len(plans[i+1])):
            name = "plan-"+plans[i+1][j].replace("(","").replace(")","").split(" ")[0]
            pars = ["i"+str(j+1)]+plans[i+1][j].replace("(","").replace(")","").split(" ")[1:]
            eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom(name,pars))]      
      
   fd_task.actions.append(pddl.actions.Action("test_"+str(i+1),[],0,pddl.conditions.Conjunction(pre),eff,0))

   
# Writing the compilation output domain and problem
fdomain=open("aux_domain.pddl","w")
fdomain.write(fdtask_to_pddl.format_domain(fd_task,fd_domain))
fdomain.close()

fdomain=open("aux_problem.pddl","w")
fdomain.write(fdtask_to_pddl.format_problem(fd_task,fd_domain))
fdomain.close()


# Solving the compilation
cmd = "rm " + config.OUTPUT_FILENAME + " planner_out.log;"+config.PLANNER_PATH+"/M aux_domain.pddl aux_problem.pddl -F "+str(len(plans)+sum([len(p) for p in plans]))+" "+config.PLANNER_PARAMS+" > planner_out.log"
print("\n\nExecuting... " + cmd)
os.system(cmd)

# Reading the plan output by the compilation
pres = [[] for _ in xrange(len(actions))]
dels = [[] for _ in xrange(len(actions))]
adds = [[] for _ in xrange(len(actions))]
file = open(config.OUTPUT_FILENAME, 'r')
for line in file:   
   keys="(program_pre_"
   if keys in line:
      aux = line.replace("\n","").replace(")","").split(keys)[1].split(" ")
      action = aux[0].split("_")[1:]+aux[1:]
      indexa = [a[0] for a in actions].index(action[0])
      pred = [aux[0].split("_")[0]]      
      if [aux[0].split("_")[2:]][0]!=['']:
         pred = pred + [aux[0].split("_")[2:]][0]
      allpres.remove(str("pre_"+pred[0]+"_"+action[0]+"_"+"_".join(map(str,pred[1:]))))

   keys="(program_del_"
   if keys in line:
      aux = line.replace("\n","").replace(")","").split(keys)[1].split(" ")
      action = aux[0].split("_")[1:]+aux[1:]
      indexa = [a[0] for a in actions].index(action[0])      
      delp = [aux[0].split("_")[0]]
      if [aux[0].split("_")[2:]][0]!=['']:
         delp = delp + [aux[0].split("_")[2:]][0]      
      indexp= [str(p[0]) for p in predicates].index(delp[0])

      for index in range(0,len(actions)):
         if (actions[index][0]==action[0]) and (not delp in dels[index]):
            dels[index].append(delp)

   keys="(program_add_"
   if keys in line:
      aux = line.replace("\n","").replace(")","").split(keys)[1].split(" ")
      action = aux[0].split("_")[1:]+aux[1:]
      indexa = [a[0] for a in actions].index(action[0])      
      addp = [aux[0].split("_")[0]]
      if [aux[0].split("_")[2:]][0]!=['']:
         addp = addp + [aux[0].split("_")[2:]][0]            
      indexp= [str(p[0]) for p in predicates].index(addp[0])      

      for index in range(0,len(actions)):
         if (actions[index][0]==action[0]) and (not addp in adds[index]):
            adds[index].append(addp)         
file.close()

for p in allpres:
   act = p.split("_")[2]
   pred = [p.split("_")[1]]+p.split("_")[3:]
   if pred[1] == "":
      pred=[pred[0]]
   indexa = [a[0] for a in actions].index(act)
   for index in range(0,len(actions)):
      if (actions[index][0]==act) and (not pred in pres[index]):
         pres[index].append(pred)

counter = 0
new_fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problems[0])
new_fd_task.actions=[]
for action in actions:
   params = ["?o"+str(i+1) for i in range(0,len(action[1:]))]
   ps = [pddl.pddl_types.TypedObject(params[i],action[i+1]) for i in range(0,len(params))]
   pre =[]
   for p in pres[counter]:
      args = ["?o"+i.replace("var","") for i in p[1:]]
      ball = True
      for arg in args:
         if not arg in [x.name for x in ps]:
            ball = False
      if ball:
         pre=pre+[pddl.conditions.Atom(p[0],args)]
   eff = []
   for p in dels[counter]:
      args = ["?o"+i.replace("var","") for i in p[1:]]
      ball = True
      for arg in args:
         if not arg in [x.name for x in ps]:
            ball = False
      if ball:      
         eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.NegatedAtom(p[0],args))]
   for p in adds[counter]:
      args = ["?o"+i.replace("var","") for i in p[1:]]
      ball = True
      for arg in args:
         if not arg in [x.name for x in ps]:
            ball = False
      if ball:            
         eff = eff + [pddl.effects.Effect([],pddl.conditions.Truth(),pddl.conditions.Atom(p[0],args))]
   new_fd_task.actions.append(pddl.actions.Action(action[0],ps,len(ps),pddl.conditions.Conjunction(pre),eff,0))
   counter = counter + 1
      
# Writing the compilation output domain and problem
fdomain=open("learned_domain.pddl","w")
fdomain.write(fdtask_to_pddl.format_domain(new_fd_task,fd_domain))
fdomain.close()
sys.exit(0)
