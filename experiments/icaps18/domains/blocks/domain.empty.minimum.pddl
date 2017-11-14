(define (domain blocks)
 (:requirements :adl :strips :typing)
 (:types object - None object - object )
 (:predicates (on ?o1 - object ?o2 - object)(ontable ?o - object)(clear ?o - object)(holding ?o - object)(handempty))

 (:action pick-up
   :parameters (?o1 - object)
   :precondition (and (ontable ?o1)(clear ?o1)(handempty ))
   :effect (and (not (clear ?o1))(not (handempty ))(not (ontable ?o1))(holding ?o1)))

 (:action stack
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (ontable ?o2)(clear ?o1)(handempty ))
   :effect (and (not (clear ?o1))(not (ontable ?o2))(on ?o2 ?o1)))

 (:action put-down
   :parameters (?o1 - object)
   :precondition (and (holding ?o1))
   :effect (and (not (holding ?o1))(clear ?o1)(handempty )(ontable ?o1)))

 (:action unstack
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (on ?o2 ?o1)(handempty ))
   :effect (and (not (on ?o2 ?o1))(clear ?o1)(ontable ?o1)(ontable ?o2)))

)