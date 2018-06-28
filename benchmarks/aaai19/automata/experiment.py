#! /usr/bin/env python
import sys,os,random

# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    nObs = int(sys.argv[2])
    nModels = int(sys.argv[3])    
    nlen = int(sys.argv[4])

except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <nObservations> <nModels> <length> "
    sys.exit(-1)


# Generate the n possible automatas
for i in range(0,nModels):
    cmd=  "./gen-automata-domain.py " + str(nStates) + " " + str(nObs) + " 2 " + str(i)
    print cmd
    os.system(cmd)

    cmd=  "mv domain.pddl models/domain-"+str(i)+".pddl"
    print cmd
    os.system(cmd)


# Pick one automata
random.seed()
picked_id = random.randint(0, nModels-1)
cmd =  "cp models/domain-"+str(picked_id)+".pddl domain.pddl"
print cmd
os.system(cmd)


# Generate trace for picked automata
cmd=  "./gen-automata-trace.py " + str(nStates) + " " + str(nObs) + " " + str(nlen)
print cmd
os.system(cmd)


sys.exit(0)

