(define (domain hanoi)
(:requirements :strips)
(:predicates (clear ?x)
             (on ?x ?y)
             (smaller ?x ?y))

;;;
;;; Invariants with two quantified variable and size 2
;;;
(:derived (invariant-2-1)
  (forall (?o1 ?o2 - object)
      (not (and (on ?o1 ?o2) (clear ?o2)))))
      
(:derived (invariant-2-2)
  (forall (?o1 ?o2 - object)
      (not (and (on ?o1 ?o2) (on ?o2 ?o1)))))

(:derived (invariant-2-3)
  (forall (?o1 ?o2 - object)
      (not (and (not (= ?o1 ?o2)) (smaller ?o1 ?o2) (smaller ?o2 ?o1)))))


)
