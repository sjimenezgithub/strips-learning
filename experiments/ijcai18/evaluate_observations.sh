#!/bin/bash
declare -a arr=("blocks" "ferry" "gripper" "hanoi")

ulimit -t 1000

for i in "${arr[@]}"
do
   ../../src/compiler.py -s ../../benchmarks/icaps18/$i/ empty_domain test plan 2

   echo $i 
   ../../src/evaluator2.py -r ../../benchmarks/icaps18/$i/full_domain.pddl learned_domain.pddl ../../benchmarks/icaps18/$i/test-1.pddl
   cat planner_out.log | grep -e 'actions\sin'
   cat planner_out.log | grep -e 'total\stime'
done
