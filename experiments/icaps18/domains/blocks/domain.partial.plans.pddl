(define (domain blocks)
 (:requirements :strips)
 (:types object - None )
 (:predicates (on ?o1 - object ?o2 - object)(ontable ?o1 - object)(clear ?o1 - object)(handempty)(holding ?o1 - object))

 (:action stack
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (clear ?o2)(holding ?o1))
   :effect (and (not (clear ?o2))(not (holding ?o1))(clear ?o1)(handempty )(on ?o1 ?o2)))

 (:action put-down
   :parameters (?o1 - object)
   :precondition (and (holding ?o1))
   :effect (and (not (holding ?o1))(clear ?o1)(handempty )(ontable ?o1)))

 (:action pick-up
   :parameters (?o1 - object)
   :precondition (and (clear ?o1)(ontable ?o1)(handempty ))
   :effect (and (not (ontable ?o1))(not (clear ?o1))(not (handempty ))(holding ?o1)))

 (:action unstack
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (on ?o1 ?o2)(clear ?o1)(handempty ))
   :effect (and (holding ?o1)(clear ?o2)(not (clear ?o1))(not (handempty ))(not (on ?o1 ?o2))))

)