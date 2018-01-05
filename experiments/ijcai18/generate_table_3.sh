#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "hiking" "parking" "satellite" "sokoban" "transport" "zenotravel")

ulimit -t 1000

for i in "${arr[@]}"
do
   ../../src/compiler.py -s ../../benchmarks/icaps18/$i/ tim_invariants test plan 3

   echo $i 
   ../../src/evaluator2.py -r ../../benchmarks/icaps18/$i/full_domain.pddl learned_domain.pddl ../../benchmarks/icaps18/$i/test-1.pddl
   cat planner_out.log | grep -e 'actions\sin'
   cat planner_out.log | grep -e 'total\stime'
done
