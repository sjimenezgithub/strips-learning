#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "gripper" "miconic" "satellite" "transport" "visitall" "zenotravel")

if [ $1 == 0 ]
then
   mode="plans"
elif [ $1 == 2 ]
then
   mode="lenplan"
elif [ $1 == 3 ]
then
   mode="minimum"
else
   echo wrong input
   exit
fi


for i in "${arr[@]}"
do
   ../../src/compiler2.py -s ../../benchmarks/icaps18/$i/ empty_domain test plan $1

   echo $i 
   ../../src/evaluator2.py ../../benchmarks/reference/$i/domain.pddl learned_domain.pddl ../../benchmarks/icaps18/$i/test-1.pddl
   cat planner_out.log | grep -e 'actions\sin'
   cat planner_out.log | grep -e 'total\stime'
   cp learned_domain.pddl ../domains/$i/domain.empty.$mode.pddl
done
