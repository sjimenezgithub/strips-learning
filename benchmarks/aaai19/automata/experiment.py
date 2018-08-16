#! /usr/bin/env python
import sys,os,random,glob

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


# Random generation of n candidate automatas
random.seed()
candidates=[]

while (len(candidates) < nModels):
    automata_id = random.randint(0, (nStates*nObs)-1)

    if not automata_id in candidates:
        candidates.append(automata_id)

        cmd =  "mkdir models"
        print cmd
        os.system(cmd)
        
   
        cmd =  "./gen-automata-domain.py " + str(nStates) + " " + str(nObs) + " 0 " + str(automata_id)
        print cmd
        os.system(cmd)

        cmd =  "mv domain.pddl models/domain-"+str(automata_id)+".pddl"
        print cmd
        os.system(cmd)

        
# Pick one automata
picked_id = random.randint(0, nModels-1)
domain_filename = "domain-"+str(candidates[picked_id])+".pddl"
cmd =  "cp models/" + domain_filename + " ./"
print cmd
os.system(cmd)


# Generate trace for picked automata
cmd=  "rm problem.pddl; ./gen-automata-problem.py "  + str(nStates) + " " + str(nObs) + " " + "0" * nlen
print cmd
os.system(cmd)
    
cmd=  "/home/slimbook/research/strips-learning/src/example-generator.py " + domain_filename + " problem.pddl M " + str(nlen) + " " + str(5)
print cmd
os.system(cmd)


# Evaluate the trace for all the candidate automata
scores=[]
for item in candidates:
    domain_filename = "models/domain-"+str(item)+".pddl"
    score_filename = "domain-"+str(item)+ ".score"
    cmd=  "/home/slimbook/research/strips-learning/src/compiler_new.py -v " + domain_filename + " ./ 100 10 -t ten-observation-01 > " + score_filename
    print cmd
    os.system(cmd)

    score_file = open(score_filename, 'r')
    scores.append(float(score_file.readline().split(" & ")[1]))
    score_file.close()
    
print candidates
print scores
    
sys.exit(0)



