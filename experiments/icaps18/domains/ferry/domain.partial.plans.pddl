(define (domain ferry)
 (:requirements :strips)
 (:types object - None car - object location - object )
 (:predicates (not-eq ?x - object ?y - object)(at-ferry ?l - location)(at ?c - car ?l - location)(empty-ferry)(on ?c - car))

 (:action board
   :parameters (?o1 - car ?o2 - location)
   :precondition (and (at ?o1 ?o2)(empty-ferry ))
   :effect (and (not (at ?o1 ?o2))(not (empty-ferry ))(on ?o1)))

 (:action sail
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (not-eq ?o1 ?o2)(at-ferry ?o1))
   :effect (and (at-ferry ?o2)(not (at-ferry ?o1))))

 (:action debark
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (on ?o1)(at-ferry ?o2))
   :effect (and (at ?o1 ?o2)(empty-ferry )(not (on ?o1))))

)