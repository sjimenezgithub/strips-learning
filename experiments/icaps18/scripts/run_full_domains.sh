#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "gripper" "miconic" "satellite" "transport" "visitall" "zenotravel")
rm -rf tmp/
mkdir tmp
for i in "${arr[@]}"
do
   rm aux.log
   touch aux.log
   for j in $(seq 1 5);
   do
      cp ../../benchmarks/icaps18/$i/full_domain.pddl tmp/
      cp ../../benchmarks/icaps18/$i/test-$j.pddl tmp/
      cp ../../benchmarks/icaps18/$i/plan-$j.pddl tmp/
      ../../src/compiler2.py tmp/ full_domain test plan 0
      cat planner_out.log | grep -e 'total\stime' >> aux.log
      rm tmp/*
   done

   echo $i 
   cat aux.log
done
rm cat aux.log
