(define (domain grid-navigation)    ;;; Parameters: 2--2-0--2--1-0--1
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
  :parameters (?v1 ?v2 ?v)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v1 ?v2) (min ?v))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action dec_horizontal
  :parameters (?v1 ?v2 ?v)
  :precondition (and (ycoord ?v) (xcoord ?v1) (next ?v2 ?v1) (min ?v))
  :effect (and (visited ?v2 ?v) (not (xcoord ?v1)) (xcoord ?v2)))

(:action inc_vertical
  :parameters (?v1 ?v2 ?v)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v1 ?v2))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)))

(:action dec_vertical
  :parameters (?v1 ?v2 ?v)
  :precondition (and (xcoord ?v) (ycoord ?v1) (next ?v2 ?v1))
  :effect (and (visited ?v ?v2) (not (ycoord ?v1)) (ycoord ?v2)))

)
