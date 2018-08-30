#! /usr/bin/env python
import sys,os
import config


# **************************************#
# MAIN
# **************************************#
try:
    domain_filename = sys.argv[1]
    problem_filename = sys.argv[2]    
    nKind = int(sys.argv[3])
    nsteps = int(sys.argv[4])

except:
    print "Usage:"
    print sys.argv[0] + " <domain> <problem> <kind (0 Regular, 1 HMM, 2 Turing Machine)> <steps> "
    sys.exit(-1)

    
if nKind == config.REGULAR:    
    cmd=  "/home/slimbook/research/strips-learning/src/example-generator.py " + domain_filename + " " + problem_filename +" M " + str(nsteps) + " " + str(5)

if nKind == config.HMM:    
    cmd=  "/home/slimbook/research/strips-learning/src/example-generator.py " + domain_filename + " " + problem_filename +" M " + str(nsteps) + " " + str(5)
    
if nKind == config.TURING:
    cmd=  "/home/slimbook/research/strips-learning/src/example-generator.py " + domain_filename + " " + problem_filename +" M " + str(nsteps) + " " + str(5)    

print cmd
os.system(cmd)
sys.exit(0)


