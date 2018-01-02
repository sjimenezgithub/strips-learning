(define (domain ferry)
(:types car location - object)
(:predicates (not-eq ?x ?y - object)
	     (at-ferry ?l - location)
	     (at ?c - car ?l - location)
	     (empty-ferry)
	     (on ?c - car))


;=== Types ===
;Type 0: c0, c1, c2, c3, c4, c5, c6, c7, c8
;Type 1: l1, l2, l3, l5
;Type 2: l4
;Type 3: l0


;FORALL ?x:T0. FORALL ?y1:T1.FORALL ?y2:T1. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - car ?y1 ?y2 - location)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))
;FORALL x:T0. NOT ((at_1) AND (on_1))
(:derived (invariant-2)
	(forall (?x - car ?y1 - location)
		(not (and (and (at ?x ?y1)) (and (on ?x))))))

)