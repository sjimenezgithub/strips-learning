(define (domain hmm)
  (:requirements :strips :typing)
  (:types state observation index) 
  (:predicates (can-transit ?s1 ?s2 - state)
    	       (can-emit ?s - state ?o - observation)
  	       (current-state ?s - state)
	       (current-index ?i - index)
	       (next ?i1 ?i2 - index)
	       (emmited ?o - observation ?i - index)
	       (mode-transit)
	       (mode-emit)
	       )

  (:action transit
	     :parameters (?s1 ?s2 - state)
	     :precondition (and (mode-transit) (current-state ?s1) (can-transit ?s1 ?s2))
	     :effect (and (not (mode-transit)) (mode-emit) (not (current-state ?s1)) (current-state ?s2)))

  (:action emit
	     :parameters (?s - state ?o - observation ?i1 ?i2 - index)
	     :precondition (and (mode-emit) (current-state ?s) (can-emit ?s ?o) (current-index ?i1) (next ?i1 ?i2))
	     :effect (and (not (mode-emit)) (mode-transit) (emmited ?o ?i1) (not (current-index ?i1)) (current-index ?i2)))
)	       