(define (domain grid-visit-all)
(:requirements :typing)
(:types        place - object)
(:predicates (connected ?x ?y - place)
	     (at-robot ?x - place)
	     (visited ?x - place)
)
	
(:action move
:parameters (?o1 ?o2 - place)
:precondition (and (at-robot ?o1) (connected ?o1 ?o2))
:effect (and (at-robot ?o2) (not (at-robot ?o1)) (visited ?o2))
)

)
