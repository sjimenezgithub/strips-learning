;  (c) 2001 Copyright (c) University of Huddersfield
;  Automatically produced from GIPO from the domain hiking
;  All rights reserved. Use of this software is permitted for non-commercial
;  research purposes, and it may be copied only for that use.  All copies must
;  include this copyright message.  This software is made available AS IS, and
;  neither the GIPO team nor the University of Huddersfield make any warranty about
;  the software or its performance.

(define (domain hiking)
  (:requirements :strips :equality :typing)
  (:types car tent person couple place )
  (:predicates
              (at-tent ?o1 - tent ?o2 - place)
              (at-person ?o1 - person ?o2 - place)
              (at-car ?o1 - car ?o2 - place)
              (partners ?o1 - couple ?o2 - person ?o3 - person)
              (up ?o1 - tent)
              (down ?o1 - tent)
              (walked ?o1 - couple ?o2 - place)
              (next ?o1 - place ?o2 - place))


;=== Types ===
;Type 0: place1, place2, place3
;Type 1: car0, car1
;Type 2: guy0, girl0, guy1, girl1
;Type 3: tent1, tent0
;Type 4: place0
;Type 5: couple0, couple1

;FORALL ?x:T3. FORALL ?y1:T4.FORALL ?y2:T4. (at-tent x ?y1) AND  (at-tent x ?y2) -> y1 = y2
(:derived (invariant-1)
	(forall (?x - tent ?y1 ?y2 - place)
		(not (and  (at-tent x ?y1) (at-tent x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL x:T3. NOT ((down_1) AND (up_1))
(:derived (invariant-2)
	(forall (?x - tent)
		(not (and (and (down ?x)) (and (up ?x))))))

;FORALL ?x:T1. FORALL ?y1:T4.FORALL ?y2:T4. (at-car x ?y1) AND  (at-car x ?y2) -> y1 = y2
(:derived (invariant-3)
	(forall (?x - car ?y1 ?y2 - place)
		(not (and  (at-car x ?y1) (at-car x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T5. FORALL ?y1:T4.FORALL ?y2:T4. (walked x ?y1) AND  (walked x ?y2) -> y1 = y2
(:derived (invariant-4)
	(forall (?x - couple ?y1 ?y2 - place)
		(not (and  (walked x ?y1) (walked x ?y2) (not (= ?y1 ?y2)) ))))

;FORALL ?x:T2. FORALL ?y1:T4.FORALL ?y2:T4. (at-person x ?y1) AND  (at-person x ?y2) -> y1 = y2
(:derived (invariant-5)
	(forall (?x - person ?y1 ?y2 - place)
		(not (and  (at-person x ?y1) (at-person x ?y2) (not (= ?y1 ?y2)) ))))
)

