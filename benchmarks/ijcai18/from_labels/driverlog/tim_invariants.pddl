(define (domain driverlog)
  (:requirements :strips)
  (:types location locatable - object
  	  truck driver package - locatable)

  (:predicates 	(at ?lt - locatable ?loc - location)
		(in ?p - package ?t - truck)
		(driving ?d - driver ?v - truck)
		(link ?x ?y - location) (path ?x ?y - location)
		(empty ?v - truck))

;=== Types ===
;Type 0: truck1, truck2
;Type 1: p0-1, p0-2, p1-0, p2-1
;Type 2: s0, s1, s2
;Type 3: driver2, driver1, package1, package3, package2

;FORALL ?x:T0. FORALL ?y1:T0 U T3.FORALL ?y2:T0 U T3. (driving ?y1 x) AND  (driving ?y2 x) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - truck ?y1 ?y2 - driver)
		(not (and  (driving ?y1 x) (driving ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T0. NOT ((empty_1) AND (driving_2))
(:derived (invariant-2)
	(forall (?x - truck ?y1 - driver)
		(not (and (and (empty ?x)) (and (driving ?y1 ?x))))))

;FORALL ?x:T0 U T3. FORALL ?y1:T2.FORALL ?y2:T2. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-3)
	(forall (?x - locatable ?y1 ?y2 - location)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0 U T3. FORALL ?y1:T0 U T3.FORALL ?y2:T0 U T3. (in x ?y1) AND  (in x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - package ?y1 ?y2 - truck)
		(not (and  (in x ?y1) (in x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0 U T3. FORALL ?y1:T0.FORALL ?y2:T0. (driving x ?y1) AND  (driving x ?y2) -> y1 = y2
(:derived (invariant-5)
	(forall (?x - driver ?y1 ?y2 - truck)
		(not (and  (driving x ?y1) (driving x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T3 U T0. NOT ((at_1) AND (in_1)) ?? package o locatable
(:derived (invariant-6)
	(forall (?x - package ?y1 - location ?y2 - truck)
		(not (and (and (at ?x ?y1)) (and (in ?x ?y2))))))

;FORALL x:T3 U T0. NOT ((at_1) AND (driving_1)) ?? locatable o driver
(:derived (invariant-7)
	(forall (?x - driver ?y1 - location ?y2 - truck)
		(not (and (and (at ?x ?y1)) (and (driving ?x ?y2))))))

)


