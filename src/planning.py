#! /usr/bin/env python
import sys, os, copy
import pddl, pddl_parser
import config

class Literal:
    def __init__(self, n, ags):
        self.name = n
        self.args = ags
        
    def __str__(self):
        return "("+self.name +" " + " ".join(self.args)+")"
 
class State:
    def __init__(self, ls):
        self.literals = ls
        
    def __str__(self):
        return " ".join([str(s) for s in self.literals])

    def findLiteral(self, lit):
        i=0
        for l in self.literals:
            if str(lit).upper()== str(l).upper():                
                return i
            i = i + 1
        return -1

    def addLiteral(self, lit):        
        if self.findLiteral(lit)==-1:
            self.literals = self.literals + [lit]            
        return

    def delLiteral(self, lit):
        i=self.findLiteral(lit)
        
        if i!=-1:
            self.literals.pop(i)            
        return


    def filter_literals_byName(self, names):
        aux = self.literals
        self.literals = [item for item in  aux if names.count(item.name)==0]        
        return   

class Plan:
    def __init__(self, acs):
        self.actions = acs

    def read_plan(self, plan_filename):
        file = open(plan_filename, 'r')
        for line in file:
            if line[0] in ";"  or line=="\n":
                continue

            istart=line.find("(")+1
            iend=line.find(")")
        
            name = line.lower()[istart:iend].split(" ")[0]
            args = line.lower()[istart:iend].split(" ")[1:]
            self.actions = self.actions + [Literal(name,args)]
        file.close()
        
    def __str__(self):
        str_out = "" 
        for a in self.actions:
            str_out = str_out + str(a) + "\n"  
        return str_out    

    def write_plan(self, plan_filename):
        file = open(plan_filename, 'w')
        file.write(str(self))
        file.close()
    

class Rule:
    def __init__(self, s, a):
        self.state = s
        self.action = a
        
    def __str__(self):
        return "IF: " + str(self.state) + "\nTHEN: " + str(self.action)

    
class Policy:
    def __init__(self, rs):
        self.rules = rs

    def findRule(self, rul):
        i=0
        for r in self.rules:
            if str(rul).upper()== str(r).upper():
                return i
            i = i + 1
        return -1

    def addRule(self, rul):        
        if self.findRule(rul)==-1:
            self.rules = self.rules + [rul]            
        return
        
    def read_policy(self, policy_filename):
        file = open(policy_filename, 'r')
        self.rules = []
        state = None        
        for line in file:
            if "IF: " in line:
                ls = []
                for l in line.replace("IF: ","").replace("\n","").split(") ("):
                    name = l.replace("(","").replace(")","").split(" ")[0]
                    args = l.replace("(","").replace(")","").split(" ")[1:]
                    ls = ls + [Literal(name,args)]
                state = State(ls)
                    
            if "THEN: " in line:
                name = line.replace("THEN: ","").replace("\n","").replace("(","").replace(")","").split(" ")[0]
                args = line.replace("THEN: ","").replace("\n","").replace("(","").replace(")","").split(" ")[1:]
                action = Literal(name,args)
                if state != None:
                    self.addRule(Rule(state,action))
                state = None        
        file.close()
        return

    def __str__(self):
        return "\n".join([str(s) for s in self.rules])


    
# Auxiliary functions    
def VAL_computation_state_trajectory(domain_filename, problem_filename, plan_filename):
    # Creating a FD task with the domain and the problem file
    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
    fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
    fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)


    # Creating the initial state
    state=State([])
    for l in fd_task.init:
        if not isinstance(l,pddl.f_expression.FunctionAssignment) and l.predicate!="=":
            state.addLiteral(Literal(l.predicate,[str(arg) for arg in l.args]))

            
    # Running VAL
    cmd = "rm " + config.VAL_OUT + ";"+config.VAL_PATH+"/validate -v " + domain_filename + " " + problem_filename + " " + plan_filename + " > " + config.VAL_OUT
    print("\n\nExecuting... " + cmd)
    os.system(cmd)

    
    # Executing the VAL output    
    file = open(config.VAL_OUT, 'r')
    actions = []
    states = []
    action_id = 0
    plan_size = 0
    baction = False
    for line in file:
        # Reading an action
        if baction==True:
            name = line.replace("\n","").replace("(","").replace(")","").split(" ")[0]      
            args = line.replace("\n","").replace("(","").replace(")","").split(" ")[1:]
            baction = False
            name=name.split("_detdup_")[0]
            actions = actions + [Literal(name,args)]

        if "Plan size: " in line:
            plan_size=int(line.split("Plan size: ")[1])      

        if action_id < plan_size and str(action_id)+":" in line:
            baction = True
            action_id = action_id +1

        # Adding a new policy rule
        if "Checking next happening (time " in line:
            step = int(line.replace(")\n","").split("Checking next happening (time ")[1])
            states=states+[copy.deepcopy(state)] 

        if "Deleting " in line:
            name = line.replace("Deleting ","").replace("(","").replace(")\n","").split(" ")[0]
            args = line.replace("Deleting ","").replace("(","").replace(")\n","").split(" ")[1:]
            state.delLiteral(Literal(name,args))

        if "Adding " in line:
            name = line.replace("Adding ","").replace("(","").replace(")\n","").split(" ")[0]
            args = line.replace("Adding ","").replace("(","").replace(")\n","").split(" ")[1:]
            
            state.addLiteral(Literal(name,args))      
    file.close()
    states=states+[copy.deepcopy(state)]      
    return states
