(define (domain parking)
 (:requirements :strips :typing)
 (:types car curb)
 (:predicates
    (at-curb ?car - car)
    (at-curb-num ?car - car ?curb - curb)
    (behind-car ?car ?front-car - car)
    (car-clear ?car - car)
    (curb-clear ?curb - curb)
 )


;=== Types ===
;Type 0: car_00, car_01, car_03, car_04, car_02, car_06, car_05, car_07, car_08, car_09, car_10, car_11
;Type 1: curb_0, curb_1, curb_2, curb_3, curb_4, curb_5, curb_6

;FORALL ?x:T0. FORALL ?y1:T1.FORALL ?y2:T1. (at-curb-num x ?y1) AND  (at-curb-num x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - car ?y1 ?y2 - curb)
		(not (and  (at-curb-num x ?y1) (at-curb-num x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0. FORALL ?y1:T0.FORALL ?y2:T0. (behind-car x ?y1) AND  (behind-car x ?y2) -> y1 = y2
(:derived (invariant-2)
	(forall (?x ?y1 ?y2 - car)
		(not (and  (behind-car x ?y1) (behind-car x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T0. NOT ((behind-car_1) AND (at-curb_1 AND at-curb-num_1))
(:derived (invariant-3)
	(forall (?x ?y1 - car ?y2 - curb)
		(not (and (and (behind-car ?x ?y1)) (and (at-curb ?x) (at-curb-num ?x ?y2))))))

;FORALL ?x:T0. FORALL ?y1:T0.FORALL ?y2:T0. (behind-car ?y1 x) AND  (behind-car ?y2 x) -> y1 = y2
(:derived (invariant-4)
	(forall (?x ?y1 ?y2 - car)
		(not (and  (behind-car ?y1 x) (behind-car ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T0. NOT ((car-clear_1) AND (behind-car_2))
(:derived (invariant-5)
	(forall (?x ?y1 - car)
		(not (and (and (car-clear ?x)) (and (behind-car ?y1 ?x))))))

;FORALL ?x:T1. FORALL ?y1:T0.FORALL ?y2:T0. (at-curb-num ?y1 x) AND  (at-curb-num ?y2 x) -> y1 = y2
(:derived (invariant-6)
	(forall (?x - curb ?y1 ?y2 - car)
		(not (and  (at-curb-num ?y1 x) (at-curb-num ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T1. NOT ((at-curb-num_2) AND (curb-clear_1))
(:derived (invariant-7)
	(forall (?x - curb ?y1 - car)
		(not (and (and (at-curb-num ?y1 ?x)) (and (curb-clear ?x))))))

)
