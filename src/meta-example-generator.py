#! /usr/bin/env python
import sys, os, glob
import pddl, pddl_parser
import fdtask_to_pddl, planning


#**************************************#
# MAIN
#**************************************#   
try:
   source_folder_name  = sys.argv[1]
   destination_folder_name  = sys.argv[2]
except:
   print "Usage:"
   print sys.argv[0] + " <source folder name> <destination folder name>"
   sys.exit(-1)


experiments = {'blocks': "../benchmarks/generator/blocks/domain.pddl ../benchmarks/generator/blocks/problem3.pddl LPG 10 100",
               'childsnack': None,
               'driverlog': "../benchmarks/generator/driverlog/domain.pddl ../benchmarks/generator/driverlog/problem1.pddl M 10 100",
               'ferry': "../benchmarks/generator/ferry/domain.pddl ../benchmarks/generator/ferry/problem1.pddl M 10 100",
               'floortile': "../benchmarks/generator/floortile/domain.pddl ../benchmarks/generator/floortile/problem1.pddl M 10 100",
               'grid': "../benchmarks/generator/grid/domain.pddl ../benchmarks/generator/grid/problem1.pddl M 10 100",
               'gripper': "../benchmarks/generator/gripper/domain.pddl ../benchmarks/generator/gripper/problem1.pddl M 10 100",
               'hanoi': "../benchmarks/generator/hanoi/domain.pddl ../benchmarks/generator/hanoi/problem1.pddl LPG 10 100",
               'hiking': None,
               'miconic': "../benchmarks/generator/miconic/domain.pddl ../benchmarks/generator/miconic/problem1.pddl M 10 100",
               'npuzzle': "../benchmarks/generator/npuzzle/domain.pddl ../benchmarks/generator/npuzzle/problem1.pddl LPG 10 100",
               'parking': None,
               'pegsol': None,
               'satellite': "../benchmarks/generator/satellite/domain.pddl ../benchmarks/generator/satellite/problem1.pddl M 10 100",
               'sokoban': None,
               'transport': "../benchmarks/generator/transport/domain.pddl ../benchmarks/generator/transport/problem1.pddl M 10 100",
               'visitall': "../benchmarks/generator/transport/domain.pddl ../benchmarks/generator/transport/problem1.pddl M 10 100",
               'zenotravel': "../benchmarks/generator/transport/domain.pddl ../benchmarks/generator/transport/problem1.pddl M 10 100"
}
   
for item in sorted(glob.glob(source_folder_name+"/*")):
   domain_name = item[len(source_folder_name)+1:]
   domain_filename = source_folder_name + "/" + domain_name + "/domain.pddl"
   problem_filename = source_folder_name + "/" + domain_name + "/problem1.pddl"

   cmd = "mkdir " + destination_folder_name + "/" + domain_name+ "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)   

   if experiments[domain_name]==None:
      continue
   cmd = "./example-generator.py " + experiments[domain_name]
   print("\n\nExecuting... " + cmd)
   os.system(cmd)
            
   # Loging the output files
   cmd = "mkdir " + destination_folder_name + "/" + domain_name+ "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)
           
   cmd = "mv test-* " + destination_folder_name + "/" + domain_name + "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)

   cmd = "mv plan-* " + destination_folder_name + "/" + domain_name + "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)

   cmd = "mv ten-observation-* " + destination_folder_name + "/" + domain_name + "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)
   
sys.exit(0)
