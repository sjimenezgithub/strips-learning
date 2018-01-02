(define (domain satellite)
(:requirements :equality :strips)
(:types satellite direction instrument mode - object)
(:predicates (on-board ?i - instrument ?s - satellite)
	     (supports ?i - instrument ?m - mode)
	     (pointing ?s - satellite ?d - direction)
	     (power-avail ?s - satellite)
	     (power-on ?i - instrument)
	     (calibrated ?i - instrument)
	     (have-image ?d - direction ?m - mode)
	     (calibration-target ?i - instrument ?d - direction))


;=== Types ===
;Type 0: groundstation2, phenomenon5, phenomenon8
;Type 1: instrument0, instrument1, instrument2, instrument3, instrument5, instrument4, instrument6, instrument7, instrument8, thermograph0, image2, spectrograph1, groundstation1, groundstation0, star3, star4, phenomenon6, star7, planet9
;Type 2: satellite2, satellite1, satellite0

;FORALL ?x:T2. FORALL ?y1:T0.FORALL ?y2:T0. (pointing x ?y1) AND  (pointing x ?y2) -> y1 = y2
(:derived (invariant-#)
	(forall (?x - satellite ?y1 ?y2 - direction)
		(not (and  (pointing x ?y1) (pointing x ?y2) (not (= ?y1 ?y2)) ))))
)
