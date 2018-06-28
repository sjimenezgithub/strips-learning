#! /usr/bin/env python
import sys, math



# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    str_itape = sys.argv[3]

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <itape> "
    sys.exit(-1)

   
str_problem="prob"
str_out = ""
str_out = str_out +  "(define (problem "+str_problem+")\n"
str_out = str_out +  "  (:domain S"+str(nStates)+"-O"+str(nObs)+")\n"
str_out = str_out +  "  (:objects"
for n in range(0,len(str_itape)):
   str_out = str_out +  " t"+str(n)
str_out = str_out +  ")\n"

str_istate="S"+str(0)
str_ihead="t"+str(0)
str_out = str_out +  "  (:init (state"+str_istate+") (head "+str_ihead+")\n        "

for n in range(0,len(str_itape)-1):
   str_out = str_out +  " (next t"+str(n)+" t"+str(n+1)+")"
str_out = str_out +  "\n        "

for n in range(0,len(str_itape)):
   str_out = str_out +  " (symbolO"+str_itape[n]+" t"+str(n)+")"   
str_out = str_out +  " )\n"

str_out = str_out +  "  (:goal (and (head t"+str(len(str_itape)-1)+") "
str_out = str_out +  ")))"


fproblem = open("problem.pddl", "w")
fproblem.write(str_out)
fproblem.close()

sys.exit(0)
