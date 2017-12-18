(define (domain transport)
  (:requirements :typing )
  (:types
        location target locatable - object
        vehicle package - locatable
        capacity-number - object
  )

  (:predicates
     (road ?l1 ?l2 - location)
     (at ?x - locatable ?v - location)
     (in ?x - package ?v - vehicle)
     (capacity ?v - vehicle ?s1 - capacity-number)
     (capacity-predecessor ?s1 ?s2 - capacity-number)
  )





;=== Types ===
;Type 0: package-1, package-2, package-3, package-4
;Type 1: truck-1, truck-2
;Type 2: city-loc-2, city-loc-4, city-loc-3, city-loc-1, city-loc-7, city-loc-8, capacity-0, capacity-1, capacity-3
;Type 3: city-loc-6, city-loc-5, city-loc-9
;Type 4: capacity-2, capacity-4


;FORALL ?x:T0 U T1. FORALL ?y1:T3.FORALL ?y2:T3. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - locatable ?y1 ?y2 - location)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0 U T1. FORALL ?y1:T0 U T1.FORALL ?y2:T0 U T1. (in x ?y1) AND  (in x ?y2) -> y1 = y2
(:derived (invariant-2)
	(forall (?x - package ?y1 ?y2 - vehicle)
		(not (and  (in x ?y1) (in x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T0 U T1. NOT ((at_1) AND (in_1))
(:derived (invariant-3)
	(forall (?x - package ?y1 - location ?y2 - vehicle)
		(not (and (and (at ?x ?y1)) (and (in ?x ?y2))))))

;FORALL ?x:T1. FORALL ?y1:T4.FORALL ?y2:T4. (capacity x ?y1) AND  (capacity x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - vehicle ?y1 ?y2 - capacity-number)
		(not (and  (capacity x ?y1) (capacity x ?y2) (not (= ?y1 ?y2)) ))))

)
