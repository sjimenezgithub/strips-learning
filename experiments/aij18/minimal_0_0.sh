#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "miconic" "npuzzle" "parking" "satellite" "transport" "visitall" "zenotravel")

#declare -a arr=("transport" "visitall" "zenotravel")

ulimit -t 1800
rm results*
rm sem-results*

LANG=en_US

touch results.0.0
touch sem-results.0.0
#echo $j

for d in "${arr[@]}"
do
   ../../src/experimenter_new.py -s ../../benchmarks/aij18/$d/ 0 0 -t ten-observation -l 2  >> results.0.0

   ../../src/compiler_new.py -v learned_domain.pddl ../../benchmarks/aij18/$d/ 0 0 -t ten-observation -l 5 >> sem-results.0.0

done
