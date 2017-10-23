(define (domain zeno-travel)
(:requirements :typing)
(:types aircraft person - locatable
	locatable city flevel - object)

(:predicates (at ?x - locatable ?c - city)
             (in ?p - person ?a - aircraft)
	     (fuel-level ?a - aircraft ?l - flevel)
	     (next ?l1 ?l2 - flevel))


(:action board
 :parameters (?o1 ?o2 ?o3) 
 :precondition (and (at ?o1 ?o3)
                    (at ?o2 ?o3))
 :effect (and (not (at ?o1 ?o3))
              (in ?o1 ?o2)))

(:action debark
 :parameters (?o1 ?o2 ?o3)
 :precondition (and (in ?o1 ?o2)
                    (at ?o2 ?o3))
 :effect (and (not (in ?o1 ?o2))
              (at ?o1 ?o3)))


(:action fly 
 :parameters (?o1 ?o2 ?o3 ?o4 ?o5)
 :precondition (and (at ?o1 ?o2)
                 (fuel-level ?o1 ?o4)
		 (next ?o5 ?o4))
 :effect (and (not (at ?o1 ?o2))
              (at ?o1 ?o3)
              (not (fuel-level ?o1 ?o4))
              (fuel-level ?o1 ?o5)))
                                  
(:action zoom
 :parameters (?o1 ?o2 ?o3 ?o4 ?o5 ?o6)
 :precondition (and (at ?o1 ?o2)
                    (fuel-level ?o1 ?o4)
		    (next ?o5 ?o4)
		    (next ?o6 ?o5))
 :effect (and (not (at ?o1 ?o2))
              (at ?o1 ?o3)
              (not (fuel-level ?o1 ?o4))
              (fuel-level ?o1 ?o6)))


(:action refuel
 :parameters (?o1 ?o2 ?o3 ?o4)
 :precondition (and (fuel-level ?o1 ?o3)
                    (next ?o3 ?o4)
                    (at ?o1 ?o2))
 :effect (and (fuel-level ?o1 ?o4)
 	      (not (fuel-level ?o ?o3))))
)
