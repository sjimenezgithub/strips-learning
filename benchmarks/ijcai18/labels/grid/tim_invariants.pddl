(define (domain grid)
(:requirements :strips)
(:types place key shape)
(:predicates (conn ?x ?y - place)
             (key-shape ?k - key ?s - shape)
             (lock-shape ?p - place ?s - shape)
             (at ?k - key ?p - place)
	     (at-robot ?p - place)
             (locked ?p - place)
	     (open ?p - place)
             (holding ?k - key)
             (arm-empty))


;=== Types ===
;Type 0: node0-1, node0-0, node0-2, node0-4, node0-3, node1-0, node1-1, node1-2, node1-3, node1-4, node2-0, node2-1, node2-2, node2-3, node2-4, node3-0, node3-1, node3-2, node3-3, node3-4, node4-0, node4-1, node4-2, node4-3, node4-4
;Type 1: triangle, diamond, square, circle
;Type 2: key0, key1, key2, key3, key4, key5, key6, key7, key8


;FORALL ?x:T2. FORALL ?y1:T0.FORALL ?y2:T0. (at x ?y1) AND  (at x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - key ?y1 ?y2 - place)
		(not (and  (at x ?y1) (at x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T2. NOT ((at_1) AND (holding_1))
(:derived (invariant-2)
	(forall (?x - key ?y1 - place)
		(not (and (and (at ?x ?y1)) (and (holding ?x))))))

;FORALL x:T0. NOT ((open_1) AND (locked_1))
(:derived (invariant-3)
	(forall (?x - place)
		(not (and (and (open ?x)) (and (locked ?x))))))



)


