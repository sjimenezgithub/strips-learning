#! /usr/bin/env python
import sys, math
import config

def decodeID(n, b):
    e = n//b
    q = n%b
    if n == 0:
        return '0'
    elif n == -1:
        return '0'
    elif e == 0:
        return str(q)
    else:
        return decodeID(e, b) + str(q)


# **************************************#
# MAIN
# **************************************#
try:

    if "-o" in sys.argv:
        index = sys.argv.index("-o")
        observations_file = sys.argv[index+1]
        sys.argv.remove("-o")
        sys.argv.remove(observations_file)
    else:
        observations_file = None

    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    nKind = int(sys.argv[3])
    idAutomata = int(sys.argv[4])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <kind (0 Regular, 1 HMM, 2 Turing Machine)> <idAutomata> [-o observations_file]"
    sys.exit(-1)


observations = set()
if observations_file:
    for line in open(observations_file):
        obs = line.strip().split(',')
        obs = [o.replace('-', '').replace(' ', '') for o in obs]

        observations.update(obs)

else:
    for i in range(nObs):
        observations.add('symbol' + str(i))

observations = list(observations)



str_ID = ""    
if nKind == config.REGULAR:
    str_automata="S"+str(nStates)+"-O"+str(nObs)+"-REGULAR"+"-DET-"+str(idAutomata)
    str_ID = decodeID(idAutomata,nStates)

if nKind == config.HMM:
    str_automata="S"+str(nStates)+"-O"+str(nObs)+"-HMM"+"-NODET-"+str(idAutomata)
    str_ID = decodeID(idAutomata,2)
    
if nKind == config.TURING:
    str_automata="S"+str(nStates)+"-O"+str(nObs)+"-TURING"+"-DET-"+str(idAutomata)
    str_ID = decodeID(idAutomata,nStates*nObs*2)

if nKind == config.HMM:
    str_MAX = "0" * (nStates*nStates + nStates*nObs)
else:
    str_MAX = "0"*nStates*nObs

for aux in range(len(str_MAX)-len(str_ID)):
    str_ID = "0" + str_ID

    
str_out=""
str_out = str_out +  "(define (domain S"+str(nStates)+"-O"+str(nObs)+")    ;;; "+str_automata+"\n"
str_out = str_out +  "  (:requirements :strips)\n"
str_out = str_out +  "  (:predicates (head ?x)\n"
str_out = str_out +  "               (next ?x1 ?x2)"
str_out = str_out + "\n              "
for i in range(nStates):
   str_istate="S"+str(i)
   str_out = str_out +  " (state"+str_istate+")"
str_out = str_out + "\n              "
# for j in range(nObs):
#    str_iobs="O"+str(j)
#    str_out = str_out +  " (symbol"+str_iobs+" ?x)"
for i in range(len(observations)):
    str_out += " ({} ?x)".format(observations[i])

if nKind == config.HMM:
    str_out = str_out + "\n              "    
    str_out = str_out +  " (mode-emit) (mode-transit)"   
str_out = str_out +  ")\n"
str_out = str_out + "\n"


counter=0
set_index_obs = set([])
set_index_state = set([])

for i in range(nStates):
   for j in range(len(observations)):
      str_istate="S"+str(i)
      # str_iobs="O"+str(j)
      str_iobs = observations[j]
      
      if nKind == config.REGULAR:
          if idAutomata == -1:
              transition_state = ""
          else:
              str_ostate = "S" + str_ID[counter]
              transition_state = "(state"+str_ostate+")"
          
          str_rule=str_istate+"-"+str_iobs 
          str_out = str_out +  "(:action update-rule-"+str_rule+"\n"
          str_out = str_out +  "  :parameters (?x1 ?x2)\n"
          str_out = str_out +  "  :precondition (and (head ?x1) (next ?x1 ?x2) (state"+str_istate+") ("+str_iobs+" ?x1))\n"
          str_out = str_out +  "  :effect (and (not (head ?x1)) (not (state"+str_istate+"))\n"
          str_out = str_out +  "               (head ?x2)" + transition_state + "))\n\n"


      if nKind == config.HMM:          
          for i2 in range(nStates):
              index_obs = len(str_ID) - 1 - (i * nObs + j)
              index_state = len(str_ID) - 1 - (nStates * nObs + nStates * i + i2)
              
              if str_ID[index_state]=="1" and not index_state in set_index_state:
                  str_ostate = "S" + str(i2)
                  str_rule = str_istate + "-" + str_ostate              
                  
                  set_index_state.add(index_state)                  
                  str_out = str_out +  "(:action transit-rule-"+str_rule+"\n"
                  str_out = str_out +  "  :parameters ()\n"
                  str_out = str_out +  "  :precondition (and (mode-transit) (state"+str_istate+"))\n" 
                  str_out = str_out +  "  :effect (and (not (mode-transit)) (not (state"+str_istate+"))\n"
                  str_out = str_out +  "               (mode-emit) (state"+str_ostate+")))\n\n"                            

              if str_ID[index_obs] == "1" and not index_obs in set_index_obs:
                  str_rule = str_istate + "-" + str_iobs               
                  
                  set_index_obs.add(index_obs)
                  str_out = str_out +  "(:action emit-rule-"+str_rule+"\n"
                  str_out = str_out +  "  :parameters (?x1 ?x2)\n"
                  str_out = str_out +  "  :precondition (and (mode-emit) (head ?x1) (next ?x1 ?x2) (state"+str_istate+") (symbol"+str_iobs+" ?x1))\n" 
                  str_out = str_out +  "  :effect (and (not (mode-emit)) (not (head ?x1))\n"
                  str_out = str_out +  "               (mode-transit) (head ?x2)))\n\n"          
                  
          
      if nKind == config.TURING:
          ostate_counter = 0
          obs_counter = 0
          shift_counter = 0

          for n in range(int(str_ID[counter])):
              if shift_counter == 1:
                  obs_counter = obs_counter + 1
                  shift_counter = 0
                  
                  if obs_counter == nObs:                  
                      ostate_counter = ostate_counter + 1
                      obs_counter = 0
              else:
                  shift_counter = shift_counter + 1
                        
          str_ostate = "S" + str(ostate_counter)
          str_oobs = "O" + str(obs_counter)

          str_rule = str_istate+"-"+str_iobs 
          str_out = str_out +  "(:action update-rule-"+str_rule+"\n"              
          str_out = str_out +  "  :parameters (?x1 ?x2)\n"          
          if (shift_counter %2) == 0:
              str_out = str_out +  "  :precondition (and (head ?x1) (next ?x2 ?x1) (state"+str_istate+") (symbol"+str_iobs+" ?x1))\n" 
          else:
              str_out = str_out +  "  :precondition (and (head ?x1) (next ?x1 ?x2) (state"+str_istate+") (symbol"+str_iobs+" ?x1))\n"               
          str_out = str_out +  "  :effect (and (not (head ?x1)) (not (state"+str_istate+")) (not (symbol"+str_iobs+" ?x1))\n"
          str_out = str_out +  "               (head ?x2) (state"+str_ostate+") (symbol"+str_oobs+" ?x1)))\n\n"

      counter = counter+1          

         
str_out = str_out +  ")\n"

fdomain = open("domain.pddl", "w")
fdomain.write(str_out)
fdomain.close()

sys.exit(0)
