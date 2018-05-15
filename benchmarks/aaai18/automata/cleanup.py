#! /usr/bin/env python
import sys,os

cmd=  "rm -rf *.pyc *.py~ "
print cmd
os.system(cmd)

sys.exit(0)

