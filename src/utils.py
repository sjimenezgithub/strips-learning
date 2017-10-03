#! /usr/bin/env python
import pddl

def compute_constants(task,domain):
   constants=set()

   for i in range(0,len(domain)):
      if domain [i][0]==":constants":
         btype=False
         for c in domain[i][1:]:
            if c=="-":
               btype=True
            elif btype==False:
               io=[o.name for o in task.objects].index(c)
               constants.add(task.objects[io])
            else:
               btype=False
   
   for action in task.actions:
      for atom in action.precondition.parts:
         if isinstance(atom,pddl.conditions.Literal):
            for arg in atom.args:
               if not "?" in str(arg):            
                  io=[o.name for o in task.objects].index(arg)
                  constants.add(task.objects[io])                  
   return constants


def get_predicate(name,task):
   for p in task.predicates:
      if name==p.name:
         return p


def compute_dynamic_predicates(task):
   dynamic_predicates=set()
   for a in task.actions:
      for e in a.effects:
         dynamic_predicates.add(get_predicate(e.literal.predicate,task))
   return dynamic_predicates


def inliterals(l,ls):
   if type(l)==str:
      n1 = l.replace("(","").replace(")","").split(" ")[0]
      a1 = " ".join(map(str, l.replace("(","").replace(")","").split(" ")[0]))
      b1 = True

   if isinstance(l,pddl.predicates.Predicate):      
      n1 = l.name
      a1 = " ".join(map(str, [aux.name for aux in l.arguments]))
      b1 = True
      
   if isinstance(l,pddl.conditions.Literal):
      n1 = l.predicate
      a1 = " ".join(map(str, l.args))
      b1 = not(l.negated)

   for l2 in ls:
      if isinstance(l2,pddl.predicates.Predicate):      
         n2=l2.name
         a2=a1
         b2=b1
         
      if isinstance(l2,pddl.conditions.Literal):
         n2=l2.predicate
         a2=" ".join(map(str, l2.args))
         b2=not(l2.negated)

      if isinstance(l2,pddl.effects.Effect):
         n2=l2.literal.predicate
         a2=" ".join(map(str, l2.literal.args))
         b2=not(l2.literal.negated)
         
      if n1==n2 and a1==a2 and b1==b2:
         return True      
   return False 


def get_outcomes(aname,task):
   outcomes=[]
   for a in task.actions:
      if (aname == a.name.split("_DETDUP_")[0]):
         outcomes.append(a.effects)
   return outcomes


def is_special_predicate(name):
   if "xstacktopx" in name.lower():
      return True
   
   if "xDEL".lower() in name.lower():
      return True
   
   if "xADD".lower() in name.lower():
      return True
   
   if "=" in name:
      return True
   
   return False
