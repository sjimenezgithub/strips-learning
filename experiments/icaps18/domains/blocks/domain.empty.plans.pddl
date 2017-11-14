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
   :precondition (and (clear ?o2)(holding ?o1))
   :effect (and (not (clear ?o2))(not (holding ?o1))(clear ?o1)(handempty )(on ?o1 ?o2)))

 (:action put-down
   :parameters (?o1 - object)
   :precondition (and (holding ?o1))
   :effect (and (not (holding ?o1))(clear ?o1)(handempty )(ontable ?o1)))

 (:action unstack
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (on ?o1 ?o2)(clear ?o1)(handempty ))
   :effect (and (not (clear ?o1))(not (handempty ))(not (on ?o1 ?o2))(clear ?o2)(holding ?o1)))

)