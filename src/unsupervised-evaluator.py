#! /usr/bin/env python
import sys, os, glob
import pddl, pddl_parser
import config, fdtask_to_pddl

                        
#**************************************#
# MAIN
#**************************************#   
try:
   domain_folder_name  = sys.argv[1]
   problem_prefix_filename = sys.argv[2]
   plan_prefix_filename = sys.argv[3]
   learned_domain_filename  = sys.argv[4]
   
except:
   print "Usage:"
   print sys.argv[0] + " <domain> <problem prelfix> <plan prefix> <learned domain>"
   sys.exit(-1)

errors = {}


# Running VAL for each problem and plan
for plan_filename in sorted(glob.glob(domain_folder_name + "/" + plan_prefix_filename + "*")):
   for problem_filename in sorted(glob.glob(domain_folder_name + "/" + problem_prefix_filename + "*")):

      cmd = "rm aux_problem.pddl ; cp " + problem_filename + " aux_problem.pddl"
      print("\n\nExecuting... " + cmd)
      os.system(cmd)

      bmissing_pre=True
      while bmissing_pre:
      
         # Creating a FD task with the domain and the problem file
         fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", learned_domain_filename)
         fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", "aux_problem.pddl")
         fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem) 
      
         cmd = "rm " + config.VAL_OUT + ";"+config.VAL_PATH+"/validate -v " + learned_domain_filename + " " + "aux_problem.pddl" + " " + plan_filename + " > " + config.VAL_OUT
         print("\n\nExecuting... " + cmd)
         os.system(cmd)   
         
         log_file = open(config.VAL_OUT, 'r')      
         bmissing_pre=False
         incomplete_action=""
         for line in log_file:          
            if  "has an unsatisfied precondition at time" in line:            
               incomplete_action= line.split(")")[0][1:].split(" ")[0]
               bmissing_pre=True         
            if bmissing_pre and "(Set (" in line and ") to true)" in line:
               try:
                  errors[incomplete_action]=errors[incomplete_action]+1
               except: 
                  errors[incomplete_action]=1                                                

               if "and (Set " in line:
                  missing_fact = line.replace("and (Set ","")[5:-10]
               elif "    (Set " in line:
                  missing_fact = line.replace("    (Set ","")[5:-10]
               else:
                  missing_fact = line[5:-10]                                 
               
               fact_name = missing_fact.replace("(","").replace(")","").split(" ")[0]
               fact_args = missing_fact.replace("(","").replace(")","").split(" ")[1:]
               fd_task.init.append(pddl.conditions.Atom(fact_name, fact_args))                              
               
               fdomain = open("aux_problem.pddl", "w")
               fdomain.write(fdtask_to_pddl.format_problem(fd_task, fd_domain))
               fdomain.close()                       
         log_file.close()

print errors      
sys.exit(0)
