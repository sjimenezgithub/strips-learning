import sys
import utils,pddl

def format_problem(task,domain):
   str_out = "(define (problem " + task.task_name + ")\n"
   str_out = str_out + "  (:domain "+ task.domain_name + ")\n"

   str_out = str_out + "  (:objects "
   for i in sorted(set(task.objects)):
      str_out = str_out + str(i).replace(":"," - ") + " "
   
   str_out = str_out + ")\n"

   str_out = str_out + "  (:init " + format_condition([i for i in task.init if i.predicate!="="])+")\n"
   str_out = str_out + "  (:goal " + format_condition(task.goal)+")"
   str_out = str_out + ")"

   return str_out


def format_domain(task,domain):
   str_out = "(define (domain " + task.domain_name + ")\n"
   str_out = str_out + " (:requirements " + str(task.requirements).replace(",","").replace(":non-deterministic","") + ")\n"

   str_out = str_out + " (:types "
   for i in task.types:
      str_out = str_out + i.name + " - " + str(i.basetype_name) + " "
   str_out = str_out + ")\n"
   
   constants=utils.compute_constants(task,domain)
   constants_str = list()
   if len(constants)>0:
      str_out = str_out + " (:constants "
      for i in sorted(set(task.objects)):
         aux = str(i).replace(":"," - ")
         constants_str.append(aux)
      constants_str = sorted(constants_str)
      str_out += " ".join(constants_str) + ")\n"

   str_out = str_out + " (:predicates "
   predicates_str = list()
   for i in task.predicates:
      if i.name != "=":
         aux = "(" + i.name
         for j in i.arguments:
            aux += " " + j.name + " - " + j.type_name
         aux += ")"
         predicates_str.append(aux)
   predicates_str = sorted(predicates_str)
   str_out += " ".join(predicates_str) + ")\n"

   # for axiom in task.axioms:
   #    str_out = str_out + " (:derived (" + axiom.name + ")\n"
   #    str_out = str_out + format_condition(axiom.condition)
   #    str_out = str_out + ")\n"


   str_out=str_out+"\n"
   for a in task.actions:
      str_out=str_out + format_action(a,task)
   str_out=str_out + ")"

   return str_out   


def format_action(a,task):
   str_out=""

   str_out=str_out + " (:action " + a.name +"\n"
   str_out=str_out + "   :parameters (" + " ".join(map(str, a.parameters)).replace(":"," -") + ")\n"
   str_out=str_out + "   :precondition " + format_condition(a.precondition) +"\n"
   str_out=str_out + "   :effect (and "
   for item in a.effects:
      str_out = str_out + format_effect(item)
   str_out = str_out + "))\n\n"   

   return str_out


def format_condition(c):
   str_out=""
   
   if isinstance(c,list):
      for item in c:
         str_out = str_out + format_condition(item) +" "

   if isinstance(c,pddl.conditions.Conjunction):
      str_out=str_out+"(and "
      for item in c.parts:
         str_out=str_out+format_condition(item)      
      str_out=str_out+")"

   if isinstance(c,pddl.conditions.Disjunction):
      str_out=str_out+"(or "
      for item in c.parts:
         str_out=str_out+format_condition(item)      
      str_out=str_out+")"

   if isinstance(c,pddl.conditions.UniversalCondition):
      str_out = str_out + "(forall ("
   if isinstance(c,pddl.conditions.ExistentialCondition):         
      str_out = str_out + "(exists ("

   if isinstance(c,pddl.conditions.UniversalCondition) or isinstance(c,pddl.conditions.ExistentialCondition):
      for p in c.parameters:
         str_out = str_out + p.name + " - " + p.type_name +" "
      str_out = str_out + ")" + format_condition(list(c.parts)) + ")"

   if isinstance(c,pddl.conditions.NegatedAtom):
      str_out=str_out+"(not ("+str(c.predicate)+" "+" ".join(map(str, c.args))+"))"

   if isinstance(c,pddl.conditions.Atom):
      str_out=str_out+"("+str(c.predicate)+" "+" ".join(map(str, c.args))+")"

   return str_out


def format_effect(e):
   str_out=""

   if isinstance(e,pddl.effects.Effect):
      if e.parameters:
         str_out=str_out+"(forall (" + " ".join(map(str, e.parameters)).replace(":"," - ")+")"
         
      if e.condition != pddl.conditions.Truth():
         str_out=str_out+"(when "+format_condition(e.condition)


      if e.literal.negated:
         str_out=str_out+"(not ("+str(e.literal.predicate)+" "+" ".join(map(str, e.literal.args))+"))"
      else:
         str_out=str_out+"("+str(e.literal.predicate)+" "+" ".join(map(str, e.literal.args))+")"
         
      if e.condition != pddl.conditions.Truth():
         str_out=str_out+")"

      if e.parameters:
         str_out=str_out+")"
   return str_out

