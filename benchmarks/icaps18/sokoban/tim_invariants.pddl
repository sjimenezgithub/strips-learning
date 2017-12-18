(define (domain sokoban-sequential)
  (:requirements :typing )
  (:types thing location direction - object
          player stone - thing)
  (:predicates (clear ?l - location)
	       (at ?t - thing ?l - location)
	       (at-goal ?s - stone)
	       (IS-GOAL ?l - location)
	       (IS-NONGOAL ?l - location)
               (MOVE-DIR ?from ?to - location ?dir - direction))


;=== Types ===
;Type 0: player-01, stone-01, stone-02, stone-03
;Type 1: dir-down, dir-right, dir-up, pos-1-2, dir-left, pos-1-4, pos-1-3, pos-1-5, pos-1-6, pos-2-1, pos-2-2, pos-2-6, pos-2-7, pos-3-1, pos-3-7, pos-4-1, pos-4-7, pos-5-1, pos-5-2, pos-5-5, pos-5-6, pos-5-7, pos-6-2, pos-6-5, pos-7-2, pos-7-3, pos-7-4, pos-7-5
;Type 2: pos-1-1, pos-1-7, pos-2-3, pos-2-4, pos-2-5, pos-3-2, pos-3-3, pos-3-4, pos-3-5, pos-3-6, pos-4-2, pos-4-3, pos-4-4, pos-4-5, pos-4-6, pos-5-3, pos-5-4, pos-6-1, pos-6-3, pos-6-4, pos-6-6, pos-6-7, pos-7-1, pos-7-6, pos-7-7

;FORALL ?x:T0. FORALL ?y1:T2.FORALL ?y2:T2. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - thing ?y1 ?y2 - location)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T2. FORALL ?y1:T0.FORALL ?y2:T0. (at ?y1 x) AND  (at ?y2 x) -> y1 = y2
(:derived (invariant-2)
	(forall (?x - location ?y1 ?y2 - thing)
		(not (and  (at ?y1 x) (at ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL x:T2. NOT ((clear_1) AND (at_2))
(:derived (invariant-3)
	(forall (?x - location ?y1 - thing)
		(not (and (and (clear ?x)) (and (at ?y1 ?x))))))

)
