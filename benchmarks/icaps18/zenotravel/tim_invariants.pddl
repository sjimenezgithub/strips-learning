(define (domain zeno-travel)
(:requirements :typing)
(:types aircraft person - locatable
	locatable city flevel - object)

(:predicates (at ?x - locatable ?c - city)
             (in ?p - person ?a - aircraft)
	     (fuel-level ?a - aircraft ?l - flevel)
	     (next ?l1 ?l2 - flevel))


;=== Types ===
;Type 0: plane1, plane2
;Type 1: city0, city1, city2, city3
;Type 2: fl1, fl2, fl3, fl4, fl5
;Type 3: person1, person2, person4, person3
;Type 4: fl0, fl6

;FORALL ?x:T0 U T3. FORALL ?y1:T1.FORALL ?y2:T1. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - locatable ?y1 ?y2 - city)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0 U T3. FORALL ?y1:T0 U T3.FORALL ?y2:T0 U T3. (in x ?y1) AND  (in x ?y2) -> y1 = y2
(:derived (invariant-2)
	(forall (?x - person ?y1 ?y2 - aircraft)
		(not (and  (in x ?y1) (in x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T3 U T0. NOT ((at_1) AND (in_1))
(:derived (invariant-3)
	(forall (?x - person ?y1 - city ?y2 - aircraft)
		(not (and (and (at ?x ?y1)) (and (in ?x ?y2))))))

;FORALL ?x:T0. FORALL ?y1:T4.FORALL ?y2:T4. (fuel-level x ?y1) AND  (fuel-level x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - aircraft ?y1 ?y2 - flevel)
		(not (and  (fuel-level x ?y1) (fuel-level x ?y2) (not (= ?y1 ?y2)) ))))


)
