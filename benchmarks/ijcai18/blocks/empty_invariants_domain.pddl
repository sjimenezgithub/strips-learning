;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Domain model to learn a 4 op-blocks world 
;;; from example plans
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain blocks)
  (:requirements :strips :typing :adl)
  (:types object)
  (:predicates
	       (on ?o1 - object ?o2 - object)
	       (ontable ?o - object)
	       (clear ?o - object)	       
	       (holding ?o  - object)
	       (handempty)
	       )

;;;
;;; Invariants with one quantified variable and size 2
;;;
(:derived (invariant-1-1)
  (forall (?o1 - block)
      (not (and (handempty) (holding ?o1)))))

(:derived (invariant-1-2)
  (forall (?o1 - block)
      (not (and (holding ?o1) (clear ?o1)))))

(:derived (invariant-1-3)
  (forall (?o1 - block)
      (not (and (holding ?o1) (ontable ?o1)))))

(:derived (invariant-1-4)
  (forall (?o1 - block)
      (not (and (on ?o1 ?o1)))))

;;;
;;; Invariants with two quantified variable and size 2
;;;
(:derived (invariant-2-1)
  (forall (?o1 ?o2 - block)
      (not (and (on ?o1 ?o2) (holding ?o1)))))

(:derived (invariant-2-2)
  (forall (?o1 ?o2 - block)
      (not (and (on ?o1 ?o2) (holding ?o2)))))

(:derived (invariant-2-3)
  (forall (?o1 ?o2 - block)
      (not (and (on ?o1 ?o2) (clear ?o2)))))

(:derived (invariant-2-4)
  (forall (?o1 ?o2 - block)
      (not (and (on ?o1 ?o2) (ontable ?o1)))))

(:derived (invariant-2-5)
  (forall (?o1 ?o2 - block)
      (not (and (on ?o1 ?o2) (on ?o1 ?o2)))))

)
