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

(:derived (invariant-1)
	(forall(?x - locatable ?y1 - location ?y2 - location)
		(not (and  (at ?x ?y1)  (at ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-2)
	(forall(?x - package ?y1 - vehicle ?y2 - vehicle)
		(not (and  (in ?x ?y1)  (in ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-3)
	(forall (?x - package ?y1 - location ?y2 - vehicle)
		(not (and (at ?x ?y1) (in ?x ?y2)))))
(:derived (invariant-4)
	(forall(?x - vehicle ?y1 - capacity-number ?y2 - capacity-number)
		(not (and  (capacity ?x ?y1)  (capacity ?x ?y2) (not (= ?y1 ?y2)) ))))

)
