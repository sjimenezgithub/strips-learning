(define (domain n-puzzle)
  (:requirements :typing)
  (:types position tile)
  (:predicates (at ?tile - tile ?position - position)
	       (neighbor ?p1 - position ?p2 - position) 
	       (empty ?position - position)
   )

		
(:derived (invariant-3)
	(forall (?y1 - tile ?x - position)
		(not (and (at ?y1 ?x) (empty ?x)))))

)