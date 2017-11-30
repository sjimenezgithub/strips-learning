;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Domain model to learn a 1 op-visitall 
;;; from example plans
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (domain grid-visit-all)
(:requirements :typing)
(:types        place - object)
(:predicates (connected ?x ?y - place)
	     (at-robot ?x - place)
	     (visited ?x - place)
)

;;;
;;; Invariants with one quantified variable and size 1
;;;

(:derived (invariant-1-1)
  (forall (?o1 - object)
      (not (and (connected ?o1 ?o1)))))


;;;
;;; Invariants with two quantified variables and size 3
;;;

(:derived (invariant-1-2)
  (forall (?o1 ?o2 - object)
      (not (and (at-robot ?o1) (at-robot ?o2) (not (= ?o1 ?o2))))))

)
