(define (domain ferry)
 (:requirements :strips)
 (:types object - None car - object location - object )
 (:predicates (not-eq ?x - object ?y - object)(at-ferry ?l - location)(at ?c - car ?l - location)(empty-ferry)(on ?c - car))

 (:action debark
   :parameters (?o1 - car ?o2 - location)
   :precondition (and (at ?o1 ?o2)(empty-ferry ))
   :effect (and (not (at ?o1 ?o2))(not (empty-ferry ))(at-ferry ?o2)(on ?o1)))

 (:action board
   :parameters (?o1 - car ?o2 - location)
   :precondition (and (on ?o1))
   :effect (and (not (on ?o1))(at ?o1 ?o2)(empty-ferry )))

 (:action sail
   :parameters (?o1 - location ?o2 - location)
   :precondition (and (at-ferry ?o2)(empty-ferry ))
   :effect (and (not (at-ferry ?o2))(at-ferry ?o1)))

)