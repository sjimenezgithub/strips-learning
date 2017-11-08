(define (domain miconic)
 (:requirements :strips)
 (:types object - None floor - object person - object )
 (:predicates (origin ?p - person ?f - floor)(destin ?p - person ?f - floor)(above ?f1 - floor ?f2 - floor)(boarded ?p - person)(served ?p - person)(lift-at ?f - floor))

 (:action board
   :parameters (?o1 - floor ?o2 - person)
   :precondition (and (origin ?o2 ?o1))
   :effect (and (boarded ?o2)))

 (:action up
   :parameters (?o1 - floor ?o2 - floor)
   :precondition (and (above ?o1 ?o2)(lift-at ?o1))
   :effect (and (not (lift-at ?o1))(lift-at ?o2)))

 (:action depart
   :parameters (?o1 - floor ?o2 - person)
   :precondition (and (lift-at ?o1)(destin ?o2 ?o1)(boarded ?o2))
   :effect (and (not (boarded ?o2))(served ?o2)))

 (:action down
   :parameters (?o1 - floor ?o2 - floor)
   :precondition (and (lift-at ?o1)(above ?o2 ?o1))
   :effect (and (lift-at ?o2)(not (lift-at ?o1))))

)