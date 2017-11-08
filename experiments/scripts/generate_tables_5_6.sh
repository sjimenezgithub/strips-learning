#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "gripper" "miconic" "satellite" "transport" "visitall" "zenotravel")

for i in "${arr[@]}"
do
   ../../src/compiler2.py -s ../../benchmarks/icaps18/$i/ empty_domain test plan 0

   echo $i 
   ../../src/evaluator2.py ../../benchmarks/reference/$i/domain.pddl learned_domain.pddl ../../benchmarks/icaps18/$i/test-1.pddl
   cat planner_out.log | grep -e 'actions\sin'
   cat planner_out.log | grep -e 'total\stime'
done
