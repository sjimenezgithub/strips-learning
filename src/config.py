#! /usr/bin/env python

PROJECT_PATH = "~/PycharmProjects/strips-learning/"
PLANNER_PATH = PROJECT_PATH + "/util/madagascar"
PLANNER_NAME = "MpC"
OUTPUT_FILENAME = "sas_plan"
PLANNER_PARAMS = "-P 2 -S 1 -Q -o "+OUTPUT_FILENAME

# Diferent modes
INPUT_PLANS = 0
INPUT_STEPS = 1
INPUT_LENPLAN = 2
INPUT_MINIMUM = 3
