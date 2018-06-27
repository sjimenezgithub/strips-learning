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
   nprobs  = int(sys.argv[3])
   
except:
   print "Usage:"
   print sys.argv[0] + " <source folder name> <destination folder name> <nprobs>"
   sys.exit(-1)

for item in sorted(glob.glob(source_folder_name+"/*")):
   domain_name = item[len(source_folder_name)+1:]
   domain_filename = source_folder_name + "/" + domain_name + "/domain.pddl"
   problem_filename = source_folder_name + "/" + domain_name + "/problem1.pddl"

   cmd = "mkdir " + destination_folder_name + "/" + domain_name+ "/" 
   print("\n\nExecuting... " + cmd)
   os.system(cmd)   

   for i in range(0,nprobs):     
      cmd = "./example-generator.py " + domain_filename + " " + problem_filename +  " M 9 -h 10"
      print("\n\nExecuting... " + cmd)
      os.system(cmd)
      
      # Creating a FD task for the new problem file
      fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)      
      fd_problem = pddl_parser.pddl_file.parse_pddl_file("task","./test-01.pddl")
      fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)            
      
      # Loging the output files
      trace_name= "trace"+str(i).zfill(2)
      cmd = "mkdir " + destination_folder_name + "/" + domain_name+ "/" + trace_name
      print("\n\nExecuting... " + cmd)
      os.system(cmd)
           
      cmd = "mv test-* " + destination_folder_name + "/" + domain_name + "/" + trace_name
      print("\n\nExecuting... " + cmd)
      os.system(cmd)

      cmd = "mv plan-* " + destination_folder_name + "/" + domain_name + "/" + trace_name
      print("\n\nExecuting... " + cmd)
      os.system(cmd)

      cmd = "cp observation-01.txt " + destination_folder_name + "/" + domain_name + "/ten-observation-"+str(i).zfill(2) 
      print("\n\nExecuting... " + cmd)
      os.system(cmd)

      cmd = "mv observation-* " + destination_folder_name + "/" + domain_name + "/" + trace_name
      print("\n\nExecuting... " + cmd)
      os.system(cmd)

      
      # Creating the new problem file     
      fd_task.init=[]
      for item in fd_task.goal.parts:
         fd_task.init=fd_task.init+[item]
      fd_task.goal=pddl.conditions.Conjunction([])

      problem_filename = "tmp.pddl"     
      fproblem = open(problem_filename, "w")
      fproblem.write(fdtask_to_pddl.format_problem(fd_task, fd_domain))
      fproblem.close()
   
sys.exit(0)
