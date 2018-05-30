#! /usr/bin/env python
import sys,glob,os
import pddl, pddl_parser
import config, fdtask_to_pddl

# **************************************#
# MAIN
# **************************************#
try:
    source_folder_name  = sys.argv[1]
    destination_folder_name  = sys.argv[2]

except:
    print "Usage:"
    print sys.argv[0] + " <source folder name>  <destination folder name>"
    sys.exit(-1)


# Reading the source examples
for item in sorted(glob.glob(source_folder_name+"/*")):
   domain_name = item[len(source_folder_name)+1:]
   domain_filename = source_folder_name + "/" + domain_name + "/empty_domain.pddl"
   fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
   
   plan=[]
   for plan_file_name in sorted(glob.glob(source_folder_name + "/" + domain_name + "/plan-*.txt")):
       plan_file = open(plan_file_name, 'r')
       step = plan_file.readline().replace('\n', '')
       plan.append(step[3:])
       plan_file.close()
       
   # HEAD
   problem_filenames = sorted(glob.glob(source_folder_name + "/" + domain_name + "/test-*.pddl"))
   problem_filename = problem_filenames[0]
   fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
   fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

   str_out = ""
   str_out = str_out + "(solution \n"
   str_out = str_out + "(:objects "
   for i in sorted(set(fd_task.objects)):
      str_out = str_out + str(i).replace(":"," - ") + " "
   str_out = str_out + ")\n"   
   str_out = str_out + "(:init " + fdtask_to_pddl.format_condition([i for i in fd_task.init if i.predicate!="="])+")\n"

   # body
   counter = 0
   for test_file_name in problem_filenames:
       fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", test_file_name)
       fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)
       str_out = str_out + "(:observations " + fdtask_to_pddl.format_condition([i for i in fd_task.init if i.predicate!="="])+")\n"       
       str_out = str_out + "\n" + plan[counter] + "\n\n"
       counter = counter + 1

   # tail
   problem_filename = problem_filenames[-1]
   fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
   fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)
   str_out = str_out + "(:goal "    
   for item in fd_task.goal.parts:
       str_out=str_out+fdtask_to_pddl.format_condition(item)
   str_out = str_out + "))"

   # Generation
   output_folder = destination_folder_name + "/" + domain_name 
   cmd = "mkdir " + output_folder
   print("\n\nExecuting... " + cmd)
   os.system(cmd)

   plan_file = open(output_folder + "/trace01", 'w')
   plan_file.write(str_out)
   plan_file.close()   
   
sys.exit(0)
