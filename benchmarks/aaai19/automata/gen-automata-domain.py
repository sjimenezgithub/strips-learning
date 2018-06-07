#! /usr/bin/env python
import sys, math

REGULAR = 0
STACK = 1
TURING = 2


def baseb(n, b):
    e = n//b
    q = n%b
    if n == 0:
        return '0'
    elif e == 0:
        return str(q)
    else:
        return baseb(e, b) + str(q)


# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    nKind = int(sys.argv[3])
    bDet = sys.argv[4]
    idAutomata = int(sys.argv[5])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <kind (0 regular, 1 stack, 2 Turing Machine)> <bDeterministic> <idAutomata [0-states^(states*observations))>"
    sys.exit(-1)

if nKind == REGULAR:
    str_automata="S"+str(nStates)+"-O"+str(nObs)+"-REGULAR"+"-DET-"+str(idAutomata)
    MAX_ID=int(math.pow(nStates,(nStates*nObs)))-1
    str_MAX = baseb(MAX_ID,nStates)
    str_ID = baseb(idAutomata,nStates)

if nKind == TURING:
    str_automata="S"+str(nStates)+"-O"+str(nObs)+"-TURING"+"-DET-"+str(idAutomata)
    unit =  max(nStates,nObs,2)
    MAX_ID=int(math.pow(unit*unit*unit,(nStates*nObs)))-1
    str_MAX = baseb(MAX_ID,unit*unit*unit)
    str_ID = baseb(idAutomata,unit*unit*unit)
    
str_out=""
str_out = str_out +  "(define (domain S"+str(nStates)+"-O"+str(nObs)+")    ;;; "+str_automata+"\n"
str_out = str_out +  "  (:requirements :strips)\n"
str_out = str_out +  "  (:predicates (head ?x)\n"
str_out = str_out +  "               (next ?x1 ?x2)"
str_out = str_out + "\n              "
for i in range(0,nStates):
   str_istate="S"+str(i)
   str_out = str_out +  " (state"+str_istate+")"
str_out = str_out + "\n              "
for j in range(0,nObs):
   str_iobs="O"+str(j)
   str_out = str_out +  " (symbol"+str_iobs+" ?x)"
str_out = str_out +  ")\n"
str_out = str_out + "\n"


counter=0
for i in range(0,nStates):
   for j in range(0,nObs):
      str_istate="S"+str(i)
      str_iobs="O"+str(j)

      if nKind == REGULAR:
          for aux in range(0,(len(str_MAX)-len(str_ID))):
              str_ID = "0" + str_ID          
          str_ostate="S"+str_ID[counter]
          
          str_rule=str_istate+"-"+str_iobs + "-" + str_ostate
          str_out = str_out +  "(:action update-rule-"+str_rule+"\n"
          str_out = str_out +  "  :parameters (?x ?xr)\n"
          str_out = str_out +  "  :precondition (and (head ?x) (next ?x ?xr) (state"+str_istate+") (symbol"+str_iobs+" ?x))\n" 
          str_out = str_out +  "  :effect (and (not (head ?x)) (not (state"+str_istate+"))\n"
          str_out = str_out +  "               (head ?xr) (state"+str_ostate+")))\n\n"

      if nKind == TURING:
          for aux in range(0,(len(str_MAX)-len(str_ID))):
              str_ID = "0" + str_ID          
          str_output = baseb(int(str_ID[counter]),unit)

          for aux in range(0,(3-len(str_output))):
              str_output = "0" + str_output
              
          str_ostate = str_output[0]
          str_oobs = str_output[1]
          bleft = int(str_output[2])%2        
          
          if bleft:
              str_rule = str_istate+"-"+str_iobs + "-" + str_ostate + "-" + str_oobs+ "-left"
              str_out = str_out +  "(:action update-rule-"+str_rule+"\n"              
              str_out = str_out +  "  :parameters (?xl ?x)\n"
              str_out = str_out +  "  :precondition (and (head ?x) (next ?xl ?x) (next ?x) (state"+str_istate+") (symbol"+str_iobs+" ?x))\n" 
              str_out = str_out +  "  :effect (and (not (head ?x)) (not (state"+str_istate+") (not (symbol"+str_iobs+" ?x))\n"
              str_out = str_out +  "               (head ?xl) (state"+str_ostate+") (symbol"+str_oobs+" ?x)))\n\n"
          else:
              str_rule = str_istate+"-"+str_iobs + "-" + str_ostate + "-" + str_oobs+ "-right"              
              str_out = str_out +  "(:action update-rule-"+str_rule+"\n"              
              str_out = str_out +  "  :parameters (?x ?xr)\n"
              str_out = str_out +  "  :precondition (and (head ?x) (next ?x ?xr) (state"+str_istate+") (symbol"+str_iobs+" ?x))\n" 
              str_out = str_out +  "  :effect (and (not (head ?x)) (not (state"+str_istate+") (not (symbol"+str_iobs+" ?x))\n"
              str_out = str_out +  "               (head ?xr) (state"+str_ostate+") (symbol"+str_oobs+" ?x)))\n\n"              

      counter=counter+1          

         
str_out = str_out +  ")\n"

fdomain = open("domain.pddl", "w")
fdomain.write(str_out)
fdomain.close()

sys.exit(0)
