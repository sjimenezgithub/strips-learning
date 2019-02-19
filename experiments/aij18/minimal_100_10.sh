#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "miconic" "npuzzle" "parking" "rovers" "satellite" "transport" "visitall" "zenotravel")

ulimit -t 1000
rm results.100.10
rm sem-results.100.10

LANG=en_US

touch results.100.10
touch sem-results.100.10
#echo $j

for d in "${arr[@]}"
do
   ../../src/experimenter_new.py -s ../../benchmarks/aij18/$d/ 100 10 -t ten-observation -l 0 2 >> results.100.10

   ../../src/compiler_new.py -v learned_domain.pddl ../../benchmarks/aij18/$d/ 100 10 -t ten-observation -l 5 10 >> sem-results.100.10 
done
