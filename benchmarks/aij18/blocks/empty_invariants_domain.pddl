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
        (forall(?x - object ?y1 - object ?y2 - object)
            (not (and  (on ?x ?y1)  (on ?x ?y2) (not (= ?y1 ?y2)) ))))
    (:derived (invariant-2)
        (forall(?x - object ?y1 - object ?y2 - object)
            (not (and  (on ?y1 ?x)  (on ?y2 ?x) (not (= ?y1 ?y2)) ))))
    (:derived (invariant-3)
        (forall (?x - object ?y1 - object)
            (not (and (clear ?x) (on ?y1 ?x)))))
    (:derived (invariant-4)
        (forall (?x - object ?y1 - object)
            (not (and (holding ?x) (on ?x ?y1)))))
    (:derived (invariant-5)
        (forall (?y1 - object ?x - object)
            (not (and (on ?y1 ?x) (holding ?x)))))
    (:derived (invariant-6)
        (forall (?x - object ?y1 - object)
            (not (and (ontable ?x) (on ?x ?y1)))))
    (:derived (invariant-7)
        (forall (?x - object)
            (not (and (ontable ?x) (holding ?x)))))
    (:derived (invariant-8)
        (forall (?x - object)
            (not (and (clear ?x) (holding ?x)))))

)




