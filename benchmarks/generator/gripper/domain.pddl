(define (domain gripper-strips)
  (:types room ball gripper)

   (:predicates (at-robby ?r - room)
		(at ?b - ball ?r - room)
		(free ?g - gripper)
		(carry ?b - ball ?g - gripper))

   (:action move
       :parameters  (?o1 ?o2 - room)
       :precondition (and  (at-robby ?o1) (not (at-robby ?o2)))
       :effect (and  (at-robby ?o2)
		     (not (at-robby ?o1))))



   (:action pick
       :parameters (?o1 - ball ?o2 - room ?o3 - gripper)
       :precondition  (and  (at ?o1 ?o2) (at-robby ?o2) (free ?o3))
       :effect (and (carry ?o1 ?o3)
		    (not (at ?o1 ?o2)) 
		    (not (free ?o3))))


   (:action drop
       :parameters (?o1 - ball ?o2 - room ?o3 - gripper)
       :precondition  (and  (carry ?o1 ?o3) (at-robby ?o2))
       :effect (and (at ?o1 ?o2)
		    (free ?o3)
		    (not (carry ?o1 ?o3)))))
