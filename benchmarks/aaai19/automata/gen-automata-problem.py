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
    str_itape = sys.argv[3]
    str_otape = sys.argv[4]
    nhead = int(sys.argv[5])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <itape> <otape> <head position>"
    sys.exit(-1)

   
str_problem="prob"
str_out = ""
str_out = str_out +  "(define (problem "+str_problem+")\n"
str_out = str_out +  "  (:domain S"+str(nStates)+"-O"+str(nObs)+")\n"
str_out = str_out +  "  (:objects "
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

str_out = str_out +  "  (:goal (and (head t"+str(nhead)+") "
for n in range(0,len(str_otape)):
   str_out = str_out +  " (symbolO"+str_otape[n]+" t"+str(n)+")"   
str_out = str_out +  ")))"



fproblem = open("problem.pddl", "w")
fproblem.write(str_out)
fproblem.close()

sys.exit(0)
