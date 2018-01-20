(define (domain grid)
(:requirements :strips)
(:types place key shape)
(:predicates (conn ?x ?y - place)
             (key-shape ?k - key ?s - shape)
             (lock-shape ?p - place ?s - shape)
             (at ?k - key ?p - place)
	     (at-robot ?p - place)
             (locked ?p - place)
	     (open ?p - place)
             (holding ?k - key)             

             (arm-empty))

(:derived (invariant-1)
	(forall(?x - key ?y1 - place ?y2 - place)
		(not (and  (at ?x ?y1)  (at ?x ?y2) (not (= ?y1 ?y2)) ))))
(:derived (invariant-2)
	(forall (?x - key ?y1 - place)
		(not (and (at ?x ?y1) (holding ?x)))))
(:derived (invariant-3)
	(forall (?x - place)
		(not (and (open ?x) (locked ?x)))))

)

	
