(define (domain transport)
 (:requirements :typing)
 (:types object - None location - object target - object locatable - object vehicle - locatable package - locatable capacity-number - object )
 (:predicates (road ?l1 - location ?l2 - location)(at ?x - locatable ?v - location)(in ?x - package ?v - vehicle)(capacity ?v - vehicle ?s1 - capacity-number)(capacity-predecessor ?s1 - capacity-number ?s2 - capacity-number))

 (:action pick-up
   :parameters (?o1 - vehicle ?o2 - location ?o3 - package ?o4 - capacity-number ?o5 - capacity-number)
   :precondition (and (capacity-predecessor ?o4 ?o5)(at ?o3 ?o2)(capacity ?o1 ?o5))
   :effect (and (not (at ?o3 ?o2))(not (capacity ?o1 ?o5))(capacity ?o1 ?o4)(in ?o3 ?o1)))

 (:action drive
   :parameters (?o1 - vehicle ?o2 - location ?o3 - location)
   :precondition (and (at ?o1 ?o2)(road ?o2 ?o3))
   :effect (and (not (at ?o1 ?o2))(at ?o1 ?o3)))

 (:action drop
   :parameters (?o1 - vehicle ?o2 - location ?o3 - package ?o4 - capacity-number ?o5 - capacity-number)
   :precondition (and (at ?o1 ?o2)(in ?o3 ?o1)(capacity-predecessor ?o4 ?o5)(capacity ?o1 ?o4))
   :effect (and (not (in ?o3 ?o1))(at ?o3 ?o2)(capacity ?o1 ?o5)(not (capacity ?o1 ?o4))))

)