(define (domain ferry)
(:types car location - object)
(:predicates (not-eq ?x ?y - object)
	     (at-ferry ?l - location)
	     (at ?c - car ?l - location)
	     (empty-ferry)
	     (on ?c - car))


;;;
;;; Invariants with one quantified variable and size 1
;;;

(:derived (invariant-1-1)
  (forall (?o1 - car)
      (not (and (not-eq ?o1 ?o1)))))


;;;
;;; Invariants with one quantified variable and size 2
;;;

(:derived (invariant-1-2)
  (forall (?o1 - car)
      (not (and (empty-ferry) (on ?o1)))))


;;;
;;; Invariants with two quantified variables and size 2
;;;

(:derived (invariant-1-3)
  (forall (?o1 - car ?o2 - location)
      (not (and (on ?o1) (at ?o1 ?o2)))))

;;;
;;; Invariants with two quantified variables and size 3
;;;

(:derived (invariant-1-4)
  (forall (?o1 ?o2 - location)
      (not (and (at-ferry ?o1) (at-ferry ?o2) (not (= ?o1 ?o2))))))
)