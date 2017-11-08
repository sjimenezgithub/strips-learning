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
)
		



 