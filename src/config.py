#! /usr/bin/env python

PROJECT_PATH = "~/PhD/strips-learning/"

VAL_PATH = PROJECT_PATH + "/util/VAL/"
VAL_OUT="val.log"

PLANNER_PATH = PROJECT_PATH + "/util/madagascar"
PLANNER_NAME = "M"
OUTPUT_FILENAME = "sas_plan"
PLANNER_PARAMS = "-S 1 -Q -o "+OUTPUT_FILENAME

# Diferent compiler modes
INPUT_PLANS = 0
INPUT_STEPS = 1
INPUT_LENPLAN = 2
INPUT_MINIMUM = 3


