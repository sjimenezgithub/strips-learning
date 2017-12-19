(define (domain gripper-strips)
  (:types room ball gripper)

   (:predicates (at-robby ?r - room)
		(at ?b - ball ?r - room)
		(free ?g - gripper)
		(carry ?b - ball ?g - gripper))


;=== Types ===
;Type 0: rooma
;Type 1: left, right
;Type 2: ball6, ball7, ball5, ball4, ball3, ball2, ball1
;Type 3: roomb

;FORALL ?x:T1. FORALL ?y1:T2.FORALL ?y2:T2. (carry ?y1 x) AND  (carry ?y2 x) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - gripper ?y1 ?y2 - ball)
		(not (and  (carry ?y1 x) (carry ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T1. NOT ((free_1) AND (carry_2))
(:derived (invariant-2)
	(forall (?x - gripper ?y1 - ball)
		(not (and (and (free ?x)) (and (carry ?y1 ?x))))))

;FORALL ?x:T2. FORALL ?y1:T0 U T3.FORALL ?y2:T0 U T3. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-3)
	(forall (?x - ball ?y1 ?y2 - room)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T2. FORALL ?y1:T1.FORALL ?y2:T1. (carry x ?y1) AND  (carry x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - ball ?y1 ?y2 - gripper)
		(not (and  (carry x ?y1) (carry x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T2. NOT ((at_1) AND (carry_1))
(:derived (invariant-5)
	(forall (?x - ball ?y1 - room ?y2 - gripper)
		(not (and (and (at ?x ?y1)) (and (carry ?x ?y2))))))
)