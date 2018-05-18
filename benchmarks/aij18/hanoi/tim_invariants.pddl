
(define (domain hanoi)
(:requirements :strips)
(:predicates (clear ?x)
             (on ?x ?y)
             (smaller ?x ?y))


;=== Types ===
;Type 0: peg1, peg2, peg3
;Type 1: d2, d1, d3, d4

;FORALL ?x:T1. FORALL ?y1:T0 U T1.FORALL ?y2:T0 U T1. (on x ?y1) AND  (on x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x ?y1 ?y2 - object)
		(not (and  (on x ?y1) (on x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0 U T1. FORALL ?y1:T1.FORALL ?y2:T1. (on ?y1 x) AND  (on ?y2 x) -> y1 = y2
(:derived (invariant-2)
	(forall (?x ?y1 ?y2 - object)
		(not (and  (on ?y1 x) (on ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T0 U T1. NOT ((on_2) AND (clear_1))
(:derived (invariant-3)
	(forall (?x ?y1 - object)
		(not (and (and (on ?y1 ?x)) (and (clear ?x))))))

 )
