(define (domain zeno-travel)
 (:requirements :typing)
 (:types object - None aircraft - locatable person - locatable locatable - object city - object flevel - object )
 (:predicates (at ?x - locatable ?c - city)(in ?p - person ?a - aircraft)(fuel-level ?a - aircraft ?l - flevel)(next ?l1 - flevel ?l2 - flevel))

 (:action debark
   :parameters (?o1 - person ?o2 - aircraft ?o3 - city)
   :precondition (and (in ?o1 ?o2))
   :effect (and (not (in ?o1 ?o2))(at ?o1 ?o3)))

 (:action fly
   :parameters (?o1 - aircraft ?o2 - city ?o3 - city ?o4 - flevel ?o5 - flevel)
   :precondition (and (next ?o5 ?o4)(at ?o1 ?o2)(fuel-level ?o1 ?o4))
   :effect (and (not (at ?o1 ?o2))(not (fuel-level ?o1 ?o4))(at ?o1 ?o3)(fuel-level ?o1 ?o5)))

 (:action zoom
   :parameters (?o1 - aircraft ?o2 - city ?o3 - city ?o4 - flevel ?o5 - flevel ?o6 - flevel)
   :precondition (and (next ?o5 ?o4)(next ?o6 ?o5)(at ?o1 ?o2)(fuel-level ?o1 ?o4))
   :effect (and (not (fuel-level ?o1 ?o4))(at ?o1 ?o3)(fuel-level ?o1 ?o6)(in ?o1 ?o1)))

 (:action refuel
   :parameters (?o1 - aircraft ?o2 - city ?o3 - flevel ?o4 - flevel)
   :precondition (and (next ?o3 ?o4)(fuel-level ?o1 ?o3))
   :effect (and (not (fuel-level ?o1 ?o3))(at ?o1 ?o2)(fuel-level ?o1 ?o4)))

 (:action board
   :parameters (?o1 - person ?o2 - aircraft ?o3 - city)
   :precondition (and )
   :effect (and (in ?o1 ?o2)(in ?o2 ?o2)))

)