#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "miconic" "npuzzle" "parking" "satellite" "transport" "visitall" "zenotravel")

ulimit -t 1000
rm results*
rm sem-results*

LANG=en_US

for j in {0..100..10}
do
touch results.100.$j
touch sem-results.100.$j

#echo $j

for d in "${arr[@]}"
do
   ../../src/experimenter_new.py -s ../../benchmarks/aij18/$d/ 100 $j -t ten-observation -l 5 >> results.100.$j

   ../../src/compiler_new.py -v learned_domain.pddl ../../benchmarks/aij18/$d/ 100 $j -t ten-observation -l 5 >> sem-results.100.$j

done

done
