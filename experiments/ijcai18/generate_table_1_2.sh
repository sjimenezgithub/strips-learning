#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "hiking" "npuzzle" "parking" "satellite" "sokoban" "transport" "zenotravel")

ulimit -t 1000

for i in "${arr[@]}"
do
   ../../src/compiler.py -s ../../benchmarks/ijcai18/labels/$i/ empty_domain test plan 3

   echo $i "w/o reformulation"
   ../../src/evaluator2.py ../../benchmarks/ijcai18/labels/$i/full_domain.pddl learned_domain.pddl ../../benchmarks/ijcai18/labels/$i/test-01.pddl
   echo $i "with reformulation"
   ../../src/evaluator2.py -r ../../benchmarks/ijcai18/labels/$i/full_domain.pddl learned_domain.pddl ../../benchmarks/ijcai18/labels/$i/test-01.pddl
   cat planner_out.log | grep -e 'actions\sin'
   cat planner_out.log | grep -e 'total\stime'
done
