(define (domain n-puzzle)
  (:requirements :typing)
  (:types position tile)
  (:predicates (at ?tile - tile ?position - position)
	       (neighbor ?p1 - position ?p2 - position) 
	       (empty ?position - position)
   )
)