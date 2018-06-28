#! /usr/bin/env python
import sys,os

cmd=  "rm -rf *.pyc *.py~ aux_* sas_plan val.log test-*.pddl plan-*.txt observation-*.txt"
print cmd
os.system(cmd)

sys.exit(0)

