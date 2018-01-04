
(define (domain hanoi)
(:requirements :strips)
(:predicates (clear ?x)
             (on ?x ?y)
             (smaller ?x ?y))

(:derived (invariant-1)
	(forall(?x - object ?y1 - object ?y2 - object)
		(not (and  (on ?x ?y1)  (on ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-2)
	(forall(?x - object ?y1 - object ?y2 - object)
		(not (and  (on ?y1 ?x)  (on ?y2 ?x) (not (= ?y1 ?y2)) ))))
(:derived (invariant-3)
	(forall (?x - object ?y1 - object)
		(not (and (clear ?x) (on ?y1 ?x)))))

)
