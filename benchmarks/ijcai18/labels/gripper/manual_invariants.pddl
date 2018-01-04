(define (domain gripper-strips)
  (:types room ball gripper)

   (:predicates (at-robby ?r - room)
		(at ?b - ball ?r - room)
		(free ?g - gripper)
		(carry ?b - ball ?g - gripper))

;;;
;;; Invariants with two quantified variables and size 2
;;;

(:derived (invariant-1-1)
  (forall (?o1 - gripper ?o2 - ball)
      (not (and (free ?o1) (carry ?o2 ?o1)))))

;;;
;;; Invariants with two quantified variables and size 3
;;;

(:derived (invariant-1-2)
  (forall (?o1 ?o2 - room)
      (not (and (at-robby ?o1) (at-robby ?o2) (not (= ?o1 ?o2))))))

)