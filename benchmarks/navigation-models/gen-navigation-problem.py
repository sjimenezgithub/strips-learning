#! /usr/bin/env python
import sys, math, os, random


# **************************************#
# MAIN
# **************************************#
try:
    nSize  = int(sys.argv[1])

except:
    print "Usage:"
    print sys.argv[0] + " <nSize> "
    sys.exit(-1)

    
str_problem="prob"
str_out = ""
str_out = str_out +  "(define (problem "+str_problem+")\n"
str_out = str_out +  "  (:domain grid-navigation)\n"
str_out = str_out +  "  (:objects"
for n in range(nSize):
   str_out = str_out +  " v"+str(n)
str_out = str_out +  " - value)\n"

str_istate="S"+str(0)
str_ihead="t"+str(0)
str_out = str_out +  "  (:init (xcoord v0) (ycoord v0)\n        "


for n in range(nSize-1):
   str_out = str_out +  " (next v"+str(n)+" v"+str(n+1)+")"

str_out = str_out +  "\n        "    
str_out = str_out +  " (q0)"
str_out = str_out +  ")\n"

str_out = str_out +  "  (:goal (and "

for i in range(nSize):
    for j in range(nSize):
        str_out = str_out +  " (visited v"+str(i)+" v"+str(j)+")"
str_out = str_out +  ")))"

fproblem = open("problem.pddl", "w")
fproblem.write(str_out)
fproblem.close()


sys.exit(0)


