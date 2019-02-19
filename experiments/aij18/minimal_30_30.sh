#!/bin/bash
declare -a arr=("blocks" "driverlog" "ferry" "floortile" "grid" "gripper" "hanoi" "miconic" "npuzzle" "parking" "rovers" "satellite" "transport" "visitall" "zenotravel")

ulimit -t 1000
rm results.30.30

LANG=en_US

touch results.30.30
#echo $j

for d in "${arr[@]}"
do
   ../../src/experimenter_new.py -s ../../benchmarks/aij18/$d/ 30 30 -t ten-observation -l 0 2  >> results.30.30

done
