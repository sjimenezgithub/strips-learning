#! /usr/bin/env python
import sys,os,random,glob
import config


# **************************************#
# MAIN
# **************************************#
try:
    nModels = int(sys.argv[1])    
    nStates  = int(sys.argv[2])
    nObs = int(sys.argv[3])
    nKind = int(sys.argv[4])        
    nsteps = int(sys.argv[5])
    ratioPartialObs = int(sys.argv[6])

except:
    print "Usage:"
    print sys.argv[0] + " <nModels> <nStates> <nObservations> <kind (0 Regular, 1 HMM, 2 Turing Machine)> <steps> <ratioPartialObs>"
    sys.exit(-1)


# Random generation of n candidate automatas
random.seed()
candidates=[]

while (len(candidates) < nModels):

    if nKind == config.REGULAR:    
        automata_id = random.randint(0, (nStates**(nStates*nObs)) - 1)

    if nKind == config.HMM:    
        automata_id = random.randint(0, 2**(nStates*nStates + nStates*nObs) - 1)        

    if nKind == config.TURING:    
        automata_id = random.randint(0, ((2*nStates*nObs)**(nStates*nObs)) - 1)
        
    if not automata_id in candidates:
        candidates.append(automata_id)

        cmd =  "mkdir models"
        print cmd
        os.system(cmd)
           
        cmd =  "mkdir models/domain-"+str(automata_id)
        print cmd
        os.system(cmd)

        cmd =  "rm domain.pddl; ./gen-automata-domain.py " + str(nStates) + " " + str(nObs) + " " + str(nKind) + " " + str(automata_id)
        print cmd
        os.system(cmd)
        
        cmd =  "mv domain.pddl models/domain-"+str(automata_id)+"/domain-"+str(automata_id)+".pddl"
        print cmd
        os.system(cmd)
        
        
# Pick one model
picked_id = random.randint(0, nModels-1)
domain_filename = "./models/domain-"+str(candidates[picked_id]) +"/domain-"+str(candidates[picked_id])+".pddl"

    
# Compute trace with picked model
trace_filename = "ten-observation-01"
problem_filename = "problem.pddl"
cmd=  "rm " + problem_filename +"; ./gen-automata-problem.py "  + str(nStates) + " " + str(nObs) + " " + str(nKind) + " " + str(nsteps)
print cmd
os.system(cmd)

cmd=  "rm " + trace_filename + "; ./gen-automata-trace.py " + domain_filename + " " + problem_filename + " " + str(nKind) + " " + str(nsteps)
print cmd
os.system(cmd)

if not os.path.isfile(trace_filename):
    print "Trace cannnot be extracted from " + domain_filename + " and " + problem_filename
    sys.exit(0)


# Evaluate trace for all the candidate automata
scores=[]
for item in candidates:
    domain_filename = "./models/domain-"+str(item) +"/domain-"+str(item)+".pddl"
    score_filename = "./models/domain-"+str(item) +"/domain-"+str(item)+ ".score"
    cmd=  "ulimit -t 100;/home/slimbook/research/strips-learning/src/compiler_new.py -s -f -v " + domain_filename + " ./ 100 " + str(ratioPartialObs) + " -t " + trace_filename +" > " + score_filename
    print cmd
    os.system(cmd)

    cmd=  "mv learning_* domain-* sas_plan val.log plan-*.txt  planner.log  planner_out.log -t ./models/domain-"+str(item)
    print cmd
    os.system(cmd)        

    score_file = open(score_filename, 'r')
    scores.append(float(score_file.readline().split(" & ")[1]))
    score_file.close()

    
# Show results    
print candidates
print scores
print "Actual:" + str(candidates[picked_id])
maxs = [candidates[i] for i in range(len(scores)) if scores[i]==max(scores)]
print "Recognized:" + str(maxs)    
if candidates[picked_id] in maxs:
    print "Success!!!"
else:
    print "Failure"

sys.exit(0)
