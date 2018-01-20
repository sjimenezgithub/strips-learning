(define (domain zeno-travel)
(:requirements :typing)
(:types aircraft person - locatable
	locatable city flevel - object)

(:predicates (at ?x - locatable ?c - city)
             (in ?p - person ?a - aircraft)
	     (fuel-level ?a - aircraft ?l - flevel)
	     (next ?l1 ?l2 - flevel))

(:derived (invariant-1)
	(forall(?x - locatable ?y1 - city ?y2 - city)
		(not (and  (at ?x ?y1)  (at ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-2)
	(forall(?x - person ?y1 - aircraft ?y2 - aircraft)
		(not (and  (in ?x ?y1)  (in ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-3)
	(forall (?x - person ?y1 - city ?y2 - aircraft)
		(not (and (at ?x ?y1) (in ?x ?y2)))))
(:derived (invariant-4)
	(forall(?x - aircraft ?y1 - flevel ?y2 - flevel)
		(not (and  (fuel-level ?x ?y1)  (fuel-level ?x ?y2) (not (= ?y1 ?y2)) ))))

)
