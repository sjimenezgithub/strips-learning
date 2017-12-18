(define (domain floor-tile)
(:requirements :typing)
(:types robot tile color - object)

(:predicates
		(robot-at ?r - robot ?x - tile)
		(up ?x - tile ?y - tile)
		(down ?x - tile ?y - tile)
		(right ?x - tile ?y - tile)
		(left ?x - tile ?y - tile)

		(clear ?x - tile)
                (painted ?x - tile ?c - color)
		(robot-has ?r - robot ?c - color)
                (available-color ?c - color)
                (free-color ?r - robot))


;=== Types ===
;Type 0: robot1, robot2
;Type 1: tile_0-2, tile_0-1, tile_1-1, tile_0-3, tile_1-3, tile_1-2, tile_2-1, tile_2-2, tile_2-3, tile_3-1, tile_3-2, tile_3-3, tile_4-1, tile_4-2, tile_4-3
;Type 2: white, black


;FORALL ?x:T0. FORALL ?y1:T1.FORALL ?y2:T1. (robot-at x ?y1) AND  (robot-at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - robot ?y1 ?y2 - tile)
		(not (and  (robot-at x ?y1) (robot-at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T0. FORALL ?y1:T2.FORALL ?y2:T2. (robot-has x ?y1) AND  (robot-has x ?y2) -> y1 = y2
(:derived (invariant-2)
	(forall (?x - robot ?y1 ?y2 - color)
		(not (and  (robot-has x ?y1) (robot-has x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T1. FORALL ?y1:T0.FORALL ?y2:T0. (robot-at ?y1 x) AND  (robot-at ?y2 x) -> y1 = y2
(:derived (invariant-3)
	(forall (?x - tile ?y1 ?y2 - robot)
		(not (and  (robot-at ?y1 x) (robot-at ?y2 x) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T1. FORALL ?y1:T2.FORALL ?y2:T2. (painted x ?y1) AND  (painted x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - tile ?y1 ?y2 - color)
		(not (and  (painted x ?y1) (painted x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T1. NOT ((clear_1) AND (robot-at_2))
(:derived (invariant-5)
	(forall (?x - tile ?y1 - robot)
		(not (and (and (clear ?x)) (and (robot-at ?y1 ?x))))))

;FORALL x:T1. NOT ((clear_1) AND (painted_1))
(:derived (invariant-6)
	(forall (?x - tile ?y1 - color )
		(not (and (and (clear ?x)) (and (painted ?x ?y1))))))

;FORALL x:T1. NOT ((robot-at_2) AND (painted_1))
(:derived (invariant-7)
	(forall (?x - tile ?y1 - robot ?y2 - color)
		(not (and (and (robot-at ?y1 ?x)) (and (painted ?x ?y2))))))

)