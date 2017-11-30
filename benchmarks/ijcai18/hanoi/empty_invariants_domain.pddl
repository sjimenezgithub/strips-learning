(define (domain hanoi)
(:requirements :strips)
(:predicates (clear ?x)
             (on ?x ?y)
             (smaller ?x ?y))

;;;
;;; Invariants with one quantified variable and size 1
;;;

(:derived (invariant-1-1)
  (forall (?o1 - object)
      (not (and (smaller ?o1 ?o1)))))


;;;
;;; Invariants with two quantified variable and size 2
;;;
(:derived (invariant-2-2)
  (forall (?o1 ?o2 - object)
      (not (and (on ?o1 ?o2) (clear ?o2)))))
      
(:derived (invariant-2-3)
  (forall (?o1 ?o2 - object)
      (not (and (smaller ?o1 ?o2) (smaller ?o2 ?o1)))))

(:derived (invariant-2-4)
  (forall (?o1 ?o2 - object)
      (not (and (on ?o1 ?o2) (on ?o2 ?o1)))))
      
)
