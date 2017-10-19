(define (domain zeno-travel)
(:requirements :typing)
(:types aircraft person - locatable
	locatable city flevel - object)

(:predicates (at ?x - locatable ?c - city)
             (in ?p - person ?a - aircraft)
	     (fuel-level ?a - aircraft ?l - flevel)
	     (next ?l1 ?l2 - flevel))
)
