#! /usr/bin/env python
import sys,os

# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    nlen = int(sys.argv[3])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <length> "
    sys.exit(-1)

cmd=  "./gen-automata-problem.py "  + str(nStates) + " " + str(nObs) + " " + "0" * nlen
print cmd
os.system(cmd)
    
cmd=  "../../../src/example-generator.py domain.pddl problem.pddl M " + str(nlen-1) + " " + str(nlen)
print cmd
os.system(cmd)

sys.exit(0)

