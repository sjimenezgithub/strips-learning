(define (domain grid-navigation)    ;;; Parameters: 2-1-0-0-0-1-0
  (:requirements :typing :strips)
  (:types value - object)
  (:predicates (xcoord ?v - value)
               (ycoord ?v - value)
               (min ?v - value)
               (max ?v - value)
               (next ?v1 ?v2 - value)
               (visited ?v1 ?v2 - value)
               (q0) (q1))

(:action inc_horizontal
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2) (q1))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action dec_horizontal
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1) (q0))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action inc_horizontal_r
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2) (q1))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action dec_horizontal_r
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1) (q0))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action inc_vertical_0
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2) (q0))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2) (not(q0)) (q1)))

(:action inc_vertical_1
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2) (q1))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2) (not(q1)) (q0)))

(:action dec_vertical_0
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1) (q0))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2) (not(q0)) (q1)))

(:action dec_vertical_1
  :parameters (?v1 ?v2 ?v - value)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1) (q1))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2) (not(q1)) (q0)))

)
