(define (domain grid-visit-all)
 (:requirements :typing)
 (:types object - None place - object )
 (:predicates (connected ?x - place ?y - place)(at-robot ?x - place)(visited ?x - place))

 (:action move
   :parameters (?o1 - place ?o2 - place)
   :precondition (and (connected ?o1 ?o2)(at-robot ?o1))
   :effect (and (not (at-robot ?o1))(at-robot ?o2)(visited ?o1)(visited ?o2)))

)