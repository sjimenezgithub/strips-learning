#! /usr/bin/env python
import sys

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


        
