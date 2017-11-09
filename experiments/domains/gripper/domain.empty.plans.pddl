(define (domain gripper-strips)
 (:requirements :strips)
 (:types object - None room - object ball - object gripper - object )
 (:predicates (at-robby ?r - room)(at ?b - ball ?r - room)(free ?g - gripper)(carry ?b - ball ?g - gripper))

 (:action drop
   :parameters (?o1 - ball ?o2 - room ?o3 - gripper)
   :precondition (and (carry ?o1 ?o3))
   :effect (and (not (carry ?o1 ?o3))(at ?o1 ?o2)(free ?o3)))

 (:action pick
   :parameters (?o1 - ball ?o2 - room ?o3 - gripper)
   :precondition (and (at ?o1 ?o2)(free ?o3))
   :effect (and (not (at ?o1 ?o2))(not (free ?o3))(carry ?o1 ?o3)))

 (:action move
   :parameters (?o1 - room ?o2 - room)
   :precondition (and (at-robby ?o1))
   :effect (and (not (at-robby ?o1))(at-robby ?o2)))

)