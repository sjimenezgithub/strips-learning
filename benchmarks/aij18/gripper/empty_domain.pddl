(define (domain gripper-strips)
  (:types room ball gripper)

   (:predicates (at-robby ?r - room)
		(at ?b - ball ?r - room)
		(free ?g - gripper)
		(carry ?b - ball ?g - gripper))
)