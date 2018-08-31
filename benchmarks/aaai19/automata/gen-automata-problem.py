#! /usr/bin/env python
import sys, math, os, random
import config


# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    nKind = int(sys.argv[3])
    nsteps = int(sys.argv[4])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <kind (0 Regular, 1 HMM, 2 Turing Machine)> <steps> "
    sys.exit(-1)

    
str_problem="prob"
str_out = ""
str_out = str_out +  "(define (problem "+str_problem+")\n"
str_out = str_out +  "  (:domain S"+str(nStates)+"-O"+str(nObs)+")\n"
str_out = str_out +  "  (:objects"
for n in range(nsteps):
   str_out = str_out +  " t"+str(n)
str_out = str_out +  ")\n"

str_istate="S"+str(0)
str_ihead="t"+str(0)
str_out = str_out +  "  (:init (state"+str_istate+")\n        "

str_itape=""
for i in range(nsteps):
    str_itape = str_itape + str(random.randint(0, 1))

for n in range(len(str_itape)-1):
   str_out = str_out +  " (next t"+str(n)+" t"+str(n+1)+")"

if nKind == config.REGULAR:
    str_out = str_out +  "\n        "    
    str_out = str_out +  " (head t0)"   

if nKind == config.HMM:
    str_out = str_out +  "\n        "    
    str_out = str_out +  " (mode-emit) (head "+str_ihead+")"

if nKind == config.TURING:
    str_out = str_out +  "\n        "        
    str_out = str_out +  " (head t"+str(len(str_itape)/2)+")"
    

str_out = str_out +  "\n        "    
for n in range(len(str_itape)):
   str_out = str_out +  " (symbolO"+str_itape[n]+" t"+str(n)+")"   
str_out = str_out +  " )\n"

if nKind == config.REGULAR:
    str_out = str_out +  "  (:goal (and (head t"+str(len(str_itape)-1)+") "
    
if nKind == config.HMM:
    str_out = str_out +  "  (:goal (and (mode-transit) (head t"+str(len(str_itape)-1)+") "
    
if nKind == config.TURING:
    str_out = str_out +  "  (:goal (and (head t0) "
str_out = str_out +  ")))"


fproblem = open("problem.pddl", "w")
fproblem.write(str_out)
fproblem.close()


sys.exit(0)


