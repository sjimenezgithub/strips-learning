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

(:derived (invariant-1)
	(forall (?x ?y1 ?y2 - object)
		(not (and  (on x ?y1) (on x ?y2) (not (= ?y1 ?y2)) ))))

(:derived (invariant-2)
	(forall (?x ?y1 ?y2 - object)
		(not (and  (on ?y1 x) (on ?y2 x) (not (= ?y1 ?y2)) ))))

(:derived (invariant-3)
	(forall (?x ?y1 ?y2 ?y3)
		(not (and (and (on ?y1 ?x) (ontable ?x)) (and (on ?x ?y2) (on ?y3 ?x))))))

(:derived (invariant-4)
	(forall (?x ?y1 ?y2)
		(not (and (and (on ?y1 ?x) (ontable ?x)) (and (on ?x ?y2) (clear ?x))))))

(:derived (invariant-5)
	(forall (?x ?y1)
		(not (and (and (on ?y1 ?x) (ontable ?x)) (and (ontable ?x) (clear ?x))))))

(:derived (invariant-6)
	(forall (?x ?y1)
		(not (and (and (on ?y1 ?x) (ontable ?x)) (and (holding ?x))))))

(:derived (invariant-7)
	(forall (?x ?y1 ?y2 ?y3)
		(not (and (and (on ?x ?y1) (on ?y2 ?x)) (and (on ?x ?y3) (clear ?x))))))

(:derived (invariant-8)
	(forall (?x ?y1 ?y2)
		(not (and (and (on ?x ?y1) (on ?y2 ?x)) (and (ontable ?x) (clear ?x))))))

(:derived (invariant-9)
	(forall (?x ?y1 ?y2)
		(not (and (and (on ?x ?y1) (on ?y2 ?x)) (and (holding ?x))))))

(:derived (invariant-10)
	(forall (?x ?y1)
		(not (and (and (on ?x ?y1) (clear ?x)) (and (ontable ?x) (clear ?x))))))

(:derived (invariant-11)
	(forall (?x ?y1)
		(not (and (and (on ?x ?y1) (clear ?x)) (and (holding ?x))))))

(:derived (invariant-12)
	(forall (?x )
		(not (and (and (ontable ?x) (clear ?x)) (and (holding ?x))))))


)




