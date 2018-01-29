(define (problem Hiking-2-2)
(:domain hiking)
(:objects 
 car0 car1 - car
 tent0 tent1 - tent
 couple0 - couple
 place0 place1 place2 place3 place4 - place
 guy0 girl0 - person
)
(:init
(partners couple0 guy0 girl0)
(at-person guy0 place1)
(at-person girl0 place1)
(walked couple0 place1)
(at-tent tent0 place0)
(down tent0)
(at-tent tent1 place0)
(down tent1)
(at-car car0 place1)
(at-car car1 place1)
(next place0 place1)
(next place1 place2)
(next place2 place3)
(next place3 place4)
)
(:goal
(and
(walked couple0 place4)
)
)
)
