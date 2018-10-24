#! /usr/bin/env python
import sys, math, os, random


# **************************************#
# MAIN
# **************************************#
try:
    nStates  = int(sys.argv[1])
    pre_inc_horizontal = int(sys.argv[2])
    eff_inc_horizontal = int(sys.argv[3])
    pre_dec_horizontal = int(sys.argv[4])
    pre_inc_vertical = int(sys.argv[5])
    eff_inc_vertical = int(sys.argv[6])
    pre_dec_vertical = int(sys.argv[7])
    
except:
    print "Usage:"
    print sys.argv[0] + " <nStates> <pre-inc-horizontal [-3, nStates]> <eff-inc-horizontal [-1,0,1]>  <pre-dec-horizontal [-3, nStates]>  <pre-inc-vertical [-3, nStates]>  <eff-inc-vertical [-1,0,1]> <pre-dec-vertical [-3, nStates]>  "    
    sys.exit(-1)


str_id = sys.argv[1]+"-"+sys.argv[2]+"-"+sys.argv[3]+"-"+sys.argv[4]+"-"+sys.argv[5]+"-"+sys.argv[6]+"-"+sys.argv[7]
    
str_out=""
str_out = str_out +  "(define (domain grid-navigation)    ;;; Parameters: "+str_id+"\n"
str_out = str_out +  "  (:requirements :typing :strips)\n"
str_out = str_out +  "  (:types value - object)\n"
str_out = str_out +  "  (:predicates (xcoord ?v - value)\n"
str_out = str_out +  "               (ycoord ?v - value)\n"
str_out = str_out +  "               (min ?v - value)\n"
str_out = str_out +  "               (max ?v - value)\n"
str_out = str_out +  "               (next ?v1 ?v2 - value)\n"
str_out = str_out +  "               (visited ?v1 ?v2 - value)\n"
str_out = str_out +  "              "
for i in range(nStates):
       str_out = str_out + " (q"+str(i)+")"
str_out = str_out +  ")\n\n"


#
if pre_inc_horizontal == 0 and eff_inc_horizontal != 0:
    for i in range(nStates):
        str_out = str_out +  "(:action inc_horizontal_"+str(i)+"\n"
        str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2) (q"+str(i)+"))\n"     

        str_out = str_out +  "  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)"
        str_out = str_out +  " (not(q"+str(i)+")) (q"+str((i+eff_inc_horizontal)%nStates)+")"
        str_out = str_out +  "))\n\n"
else:
    str_out = str_out +  "(:action inc_horizontal\n"
    str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
    if pre_inc_horizontal >= 0:
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2) (q"+str(pre_inc_horizontal)+"))\n"
    else:
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2)"
        if pre_inc_horizontal == -2:
            str_out = str_out +  " (min ?v)"
        if pre_inc_horizontal == -3:
            str_out = str_out +  " (max ?v)"            
        str_out = str_out +  ")\n"
        
    str_out = str_out +  "  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)"
    if eff_inc_horizontal != 0:
        str_out = str_out +  " (not(q"+str(pre_inc_horizontal)+")) (q"+str((pre_inc_horizontal+eff_inc_horizontal)%nStates)+")"
    else:
        str_out = str_out +  ""
    str_out = str_out +  "))\n\n"


#    
if pre_dec_horizontal == 0 and eff_inc_horizontal != 0:
    for i in range(nStates):
        str_out = str_out +  "(:action dec_horizontal_"+str(i)+"\n"
        str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1) (q"+str(i)+"))\n"     

        str_out = str_out +  "  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)"
        str_out = str_out +  " (not(q"+str(i)+")) (q"+str((i+-1*eff_inc_horizontal)%nStates)+")"
        str_out = str_out +  "))\n\n"

else:
    str_out = str_out +  "(:action dec_horizontal\n"
    str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
    if pre_dec_horizontal >= 0:
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1) (q"+str(pre_dec_horizontal)+"))\n"
    else:
        str_out = str_out +  "  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1)"
        if pre_dec_horizontal == -2:
            str_out = str_out +  " (min ?v)"
        if pre_dec_horizontal == -3:
            str_out = str_out +  " (max ?v)"            
        str_out = str_out +  ")\n"             
       
    str_out = str_out +  "  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)"
    if eff_inc_horizontal != 0:
        str_out = str_out +  " (not(q"+str(pre_dec_horizontal)+")) (q"+str((pre_dec_horizontal+-1*eff_inc_horizontal)%nStates)+")"
    else:
        str_out = str_out +  ""
    str_out = str_out +  "))\n\n"


#    
if pre_inc_vertical == 0 and eff_inc_vertical != 0:
    for i in range(nStates):
        str_out = str_out +  "(:action inc_vertical_"+str(i)+"\n"
        str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
        str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2) (q"+str(i)+"))\n"
        str_out = str_out +  "  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)"
        str_out = str_out +  " (not(q"+str(i)+")) (q"+str((i+eff_inc_vertical)%nStates)+")"
        str_out = str_out +  "))\n\n"
else:     
    str_out = str_out +  "(:action inc_vertical\n"
    str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
    if pre_inc_vertical >= 0:
        str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2) (q"+str(pre_inc_vertical)+"))\n"
    else:
        str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2)"
        if pre_inc_vertical == -2:
            str_out = str_out +  " (min ?v)"
        if pre_inc_vertical == -3:
            str_out = str_out +  " (max ?v)"            
        str_out = str_out +  ")\n"             
 
    str_out = str_out +  "  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)"
    if eff_inc_vertical != 0:
        str_out = str_out +  " (not(q"+str(pre_inc_vertical)+")) (q"+str((pre_inc_vertical+eff_inc_vertical)%nStates)+")"
    else:
        str_out = str_out +  ""
    str_out = str_out +  "))\n\n"

    
#
if pre_dec_vertical == 0 and eff_inc_vertical != 0:
    for i in range(nStates):
        str_out = str_out +  "(:action dec_vertical_"+str(i)+"\n"
        str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
        str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1) (q"+str(i)+"))\n"
        str_out = str_out +  "  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)"
        str_out = str_out +  " (not(q"+str(i)+")) (q"+str((i+-1*eff_inc_vertical)%nStates)+")"
        str_out = str_out +  "))\n\n"
else:    
   str_out = str_out +  "(:action dec_vertical\n"
   str_out = str_out +  "  :parameters (?v1 ?v2 ?v)\n"
   if pre_dec_vertical >= 0:
       str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1) (q"+str(pre_dec_vertical)+"))\n"
   else:
       str_out = str_out +  "  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1)"
       if pre_dec_vertical == -2:
           str_out = str_out +  " (min ?v)"
       if pre_dec_vertical == -3:
           str_out = str_out +  " (max ?v)"           
       str_out = str_out +  ")\n"       

   str_out = str_out +  "  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)"
   if eff_inc_vertical != 0:
       str_out = str_out +  " (not(q"+str(pre_dec_vertical)+")) (q"+str((pre_dec_vertical+-1*eff_inc_vertical)%nStates)+")"
   else:
       str_out = str_out +  ""
   str_out = str_out +  "))\n\n"


   
str_out = str_out +  ")\n"

fdomain = open("domain.pddl", "w")
fdomain.write(str_out)
fdomain.close()

sys.exit(0)


