(define (problem strips-sat-x-1)
(:domain satellite)
(:objects
	satellite0 satellite1 satellite2 - satellite
	instrument0
	instrument1
	instrument2 
	instrument3
	instrument4
	instrument5 
	instrument6
	instrument7
	instrument8  - instrument
	thermograph0
	image2
	spectrograph1 - mode
	GroundStation2
	GroundStation1
	GroundStation0
	Star3
	Star4
	Phenomenon5
	Phenomenon6
	Star7
	Phenomenon8
	Planet9 - direction
)

(:init
	(supports instrument0 image2)
	(supports instrument0 thermograph0)
	(supports instrument0 spectrograph1)
	(calibration-target instrument0 GroundStation2)
	(supports instrument1 thermograph0)
	(supports instrument1 spectrograph1)
	(supports instrument1 image2)
	(calibration-target instrument1 GroundStation1)
	(supports instrument2 image2)
	(calibration-target instrument2 GroundStation0)
	(on-board instrument0 satellite0)
	(on-board instrument1 satellite0)
	(on-board instrument2 satellite0)
	(power-avail satellite0)
	(pointing satellite0 Phenomenon8)
	(supports instrument3 spectrograph1)
	(supports instrument3 thermograph0)
	(calibration-target instrument3 GroundStation0)
	(supports instrument4 image2)
	(supports instrument4 spectrograph1)
	(calibration-target instrument4 GroundStation2)
	(supports instrument5 image2)
	(supports instrument5 spectrograph1)
	(supports instrument5 thermograph0)
	(calibration-target instrument5 GroundStation1)
	(on-board instrument3 satellite1)
	(on-board instrument4 satellite1)
	(on-board instrument5 satellite1)
	(power-avail satellite1)
	(pointing satellite1 GroundStation2)
	(supports instrument6 image2)
	(calibration-target instrument6 GroundStation1)
	(supports instrument7 image2)
	(supports instrument7 thermograph0)
	(calibration-target instrument7 GroundStation1)
	(supports instrument8 spectrograph1)
	(supports instrument8 image2)
	(supports instrument8 thermograph0)
	(calibration-target instrument8 GroundStation0)
	(on-board instrument6 satellite2)
	(on-board instrument7 satellite2)
	(on-board instrument8 satellite2)
	(power-avail satellite2)
	(pointing satellite2 Phenomenon5)
)
(:goal (and
	(pointing satellite2 GroundStation2)
	(pointing satellite1 GroundStation1)
	(pointing satellite0 GroundStation0)
	(have-image Star3 image2)
	(have-image Star4 image2)	
	(have-image Phenomenon5 thermograph0)
	(have-image Phenomenon6 thermograph0)
	(have-image Star7 thermograph0)
	(have-image Phenomenon8 spectrograph1)
	(have-image Planet9 spectrograph1)
	(power-avail satellite0)
	(power-avail satellite1)
	(power-avail satellite2)
))

)
