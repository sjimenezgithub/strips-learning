(solution 
(:objects girl1 -  person guy1 -  person tent1 -  tent tent0 -  tent place1 -  place couple1 -  couple place4 -  place place0 -  place place2 -  place car1 -  car couple0 -  couple girl0 -  person car0 -  car place3 -  place guy0 -  person )
(:init (at-person girl0 place0) (walked couple1 place0) (walked couple0 place0) (next place2 place3) (at-tent tent0 place0) (next place3 place4) (down tent1) (at-person girl1 place0) (next place0 place1) (at-car car0 place0) (at-person guy0 place0) (at-car car1 place0) (at-tent tent1 place0) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (at-person guy1 place0) (down tent0) )
(:observations (at-person girl0 place0) (walked couple1 place0) (walked couple0 place0) (next place2 place3) (at-tent tent0 place0) (next place3 place4) (down tent1) (at-person girl1 place0) (next place0 place1) (at-car car0 place0) (at-person guy0 place0) (at-car car1 place0) (at-tent tent1 place0) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (at-person guy1 place0) (down tent0) )

(drive-tent girl1 place0 place1 car0 tent1)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (walked couple0 place0) (at-car car0 place1) (next place2 place3) (at-person girl1 place1) (at-tent tent0 place0) (next place3 place4) (down tent1) (next place0 place1) (at-person guy0 place0) (at-car car1 place0) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (at-person guy1 place0) (down tent0) )

(drive-tent guy1 place0 place1 car1 tent0)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (walked couple0 place0) (at-car car0 place1) (next place2 place3) (at-person girl1 place1) (next place3 place4) (down tent1) (at-tent tent0 place1) (next place0 place1) (at-person guy0 place0) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (at-car car1 place1) (down tent0) )

(drive-tent girl1 place1 place2 car1 tent0)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (walked couple0 place0) (at-car car0 place1) (at-tent tent0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (down tent1) (next place0 place1) (at-person guy0 place0) (at-person girl1 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (down tent0) )

(put-up guy1 place1 tent1)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (walked couple0 place0) (at-car car0 place1) (at-tent tent0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (next place0 place1) (at-person guy0 place0) (at-person girl1 place2) (up tent1) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place1 place2) (down tent0) )

(put-up girl1 place2 tent0)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (walked couple0 place0) (at-tent tent0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (next place0 place1) (at-person guy0 place0) (at-person girl1 place2) (up tent1) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (up tent0) (next place1 place2) (at-car car0 place1) )

(walk-together tent1 place1 guy0 place0 girl0 couple0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy1 place1) (at-car car0 place1) (next place2 place3) (at-car car1 place2) (next place3 place4) (walked couple0 place1) (next place1 place2) (at-person guy0 place1) (at-person girl0 place1) (at-person girl1 place2) (up tent1) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (up tent0) (next place0 place1) )

(put-down guy1 place1 tent1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy1 place1) (at-car car0 place1) (next place2 place3) (at-car car1 place2) (next place3 place4) (walked couple0 place1) (next place1 place2) (at-person guy0 place1) (at-person girl0 place1) (at-person girl1 place2) (down tent1) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (up tent0) (next place0 place1) )

(drive guy1 place1 place2 car0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy1 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (walked couple0 place1) (next place1 place2) (at-person guy0 place1) (at-person girl0 place1) (at-person girl1 place2) (down tent1) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (up tent0) (next place0 place1) (at-car car0 place2) )

(walk-together tent0 place2 guy0 place1 girl0 couple0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy0 place2) (at-person guy1 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (down tent1) (next place1 place2) (at-person girl0 place2) (at-person girl1 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (up tent0) (next place0 place1) (at-car car0 place2) )

(put-down girl1 place2 tent0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy0 place2) (at-person guy1 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (down tent1) (next place1 place2) (at-person girl0 place2) (at-person girl1 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (down tent0) )

(drive-passenger girl1 place2 place1 car0 guy1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy0 place2) (at-car car0 place1) (next place2 place3) (at-car car1 place2) (at-person guy1 place1) (next place3 place4) (down tent1) (next place1 place2) (at-person girl1 place1) (at-person girl0 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (down tent0) )

(drive-tent-passenger girl0 place2 place0 car1 tent0 guy0)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (at-car car0 place1) (next place2 place3) (at-person girl1 place1) (at-tent tent0 place0) (next place3 place4) (down tent1) (next place1 place2) (at-person guy0 place0) (at-car car1 place0) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (down tent0) )

(put-up guy1 place1 tent1)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (at-person guy1 place1) (at-car car0 place1) (next place2 place3) (at-person girl1 place1) (at-tent tent0 place0) (next place3 place4) (next place1 place2) (at-person guy0 place0) (at-car car1 place0) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (up tent1) (down tent0) )

(drive-passenger guy1 place1 place0 car0 girl1)

(:observations (at-tent tent1 place1) (at-person girl0 place0) (walked couple1 place0) (next place2 place3) (at-tent tent0 place0) (next place3 place4) (at-person guy1 place0) (next place1 place2) (at-car car0 place0) (at-person guy0 place0) (at-car car1 place0) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (at-person girl1 place0) (up tent1) (down tent0) )

(drive-tent girl0 place0 place2 car1 tent0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (next place2 place3) (at-car car1 place2) (next place3 place4) (at-person guy1 place0) (next place1 place2) (at-car car0 place0) (at-person guy0 place0) (at-person girl0 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (at-person girl1 place0) (up tent1) (down tent0) )

(drive guy0 place0 place2 car0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (at-person guy1 place0) (next place1 place2) (at-person girl0 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (at-person girl1 place0) (up tent1) (down tent0) )

(put-up girl0 place2 tent0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (walked couple1 place0) (at-person guy0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (at-person girl1 place0) (next place1 place2) (at-person girl0 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (up tent0) (at-person guy1 place0) (up tent1) )

(walk-together tent1 place1 guy1 place0 girl1 couple1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (at-person guy0 place2) (next place2 place3) (at-car car1 place2) (next place3 place4) (at-person guy1 place1) (next place1 place2) (walked couple1 place1) (at-person girl1 place1) (at-person girl0 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (up tent0) (up tent1) )

(drive girl0 place2 place1 car1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (at-person guy0 place2) (next place2 place3) (at-person guy1 place1) (next place3 place4) (next place1 place2) (at-person girl1 place1) (at-person girl0 place1) (walked couple1 place1) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (up tent0) (at-car car1 place1) (up tent1) )

(put-down guy1 place1 tent1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (at-person guy0 place2) (next place2 place3) (at-person guy1 place1) (next place3 place4) (down tent1) (next place1 place2) (at-person girl0 place1) (walked couple1 place1) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (up tent0) (at-car car1 place1) (at-person girl1 place1) )

(walk-together tent0 place2 guy1 place1 girl1 couple1)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (at-person guy0 place2) (at-person guy1 place2) (next place2 place3) (next place3 place4) (down tent1) (next place1 place2) (at-person girl0 place1) (at-person girl1 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (up tent0) (at-car car1 place1) (walked couple1 place2) )

(put-down guy0 place2 tent0)

(:observations (at-tent tent1 place1) (at-tent tent0 place2) (at-person guy0 place2) (at-person guy1 place2) (next place2 place3) (down tent0) (next place3 place4) (down tent1) (next place1 place2) (at-person girl0 place1) (at-person girl1 place2) (walked couple0 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (at-car car1 place1) (walked couple1 place2) )

(drive-tent girl0 place1 place4 car1 tent1)

(:observations (walked couple0 place2) (at-tent tent0 place2) (at-person guy0 place2) (at-person guy1 place2) (at-car car1 place4) (next place2 place3) (next place3 place4) (down tent1) (at-person girl0 place4) (next place1 place2) (walked couple1 place2) (at-tent tent1 place4) (at-person girl1 place2) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (at-car car0 place2) (next place0 place1) (down tent0) )

(drive-tent-passenger guy1 place2 place3 car0 tent0 girl1)

(:observations (walked couple0 place2) (at-tent tent1 place4) (at-person guy0 place2) (at-car car0 place3) (at-car car1 place4) (next place2 place3) (next place3 place4) (down tent1) (at-person girl0 place4) (next place1 place2) (walked couple1 place2) (at-tent tent0 place3) (at-person girl1 place3) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (next place0 place1) (at-person guy1 place3) (down tent0) )

(put-up girl0 place4 tent1)

(:goal (and (next place0 place1)(next place3 place4)(partners couple0 guy0 girl0)(partners couple1 guy1 girl1)(next place1 place2)(next place2 place3)(walked couple0 place2)(at-person guy0 place2)(walked couple1 place2)(down tent0)(at-person girl0 place4)(at-car car1 place4)(at-tent tent1 place4)(at-person guy1 place3)(at-car car0 place3)(at-tent tent0 place3)(at-person girl1 place3)(up tent1)(not (at-tent tent0 place0))(not (at-tent tent0 place1))(not (at-tent tent0 place2))(not (at-tent tent0 place4))(not (at-tent tent1 place0))(not (at-tent tent1 place1))(not (at-tent tent1 place2))(not (at-tent tent1 place3))(not (at-person guy0 place0))(not (at-person guy0 place1))(not (at-person guy0 place3))(not (at-person guy0 place4))(not (at-person girl0 place0))(not (at-person girl0 place1))(not (at-person girl0 place2))(not (at-person girl0 place3))(not (at-person guy1 place0))(not (at-person guy1 place1))(not (at-person guy1 place2))(not (at-person guy1 place4))(not (at-person girl1 place0))(not (at-person girl1 place1))(not (at-person girl1 place2))(not (at-person girl1 place4))(not (at-car car0 place0))(not (at-car car0 place1))(not (at-car car0 place2))(not (at-car car0 place4))(not (at-car car1 place0))(not (at-car car1 place1))(not (at-car car1 place2))(not (at-car car1 place3))(not (partners couple0 guy0 guy0))(not (partners couple0 guy0 guy1))(not (partners couple0 guy0 girl1))(not (partners couple0 girl0 guy0))(not (partners couple0 girl0 girl0))(not (partners couple0 girl0 guy1))(not (partners couple0 girl0 girl1))(not (partners couple0 guy1 guy0))(not (partners couple0 guy1 girl0))(not (partners couple0 guy1 guy1))(not (partners couple0 guy1 girl1))(not (partners couple0 girl1 guy0))(not (partners couple0 girl1 girl0))(not (partners couple0 girl1 guy1))(not (partners couple0 girl1 girl1))(not (partners couple1 guy0 guy0))(not (partners couple1 guy0 girl0))(not (partners couple1 guy0 guy1))(not (partners couple1 guy0 girl1))(not (partners couple1 girl0 guy0))(not (partners couple1 girl0 girl0))(not (partners couple1 girl0 guy1))(not (partners couple1 girl0 girl1))(not (partners couple1 guy1 guy0))(not (partners couple1 guy1 girl0))(not (partners couple1 guy1 guy1))(not (partners couple1 girl1 guy0))(not (partners couple1 girl1 girl0))(not (partners couple1 girl1 guy1))(not (partners couple1 girl1 girl1))(not (up tent0))(not (down tent1))(not (walked couple0 place0))(not (walked couple0 place1))(not (walked couple0 place3))(not (walked couple0 place4))(not (walked couple1 place0))(not (walked couple1 place1))(not (walked couple1 place3))(not (walked couple1 place4))(not (next place0 place0))(not (next place0 place2))(not (next place0 place3))(not (next place0 place4))(not (next place1 place0))(not (next place1 place1))(not (next place1 place3))(not (next place1 place4))(not (next place2 place0))(not (next place2 place1))(not (next place2 place2))(not (next place2 place4))(not (next place3 place0))(not (next place3 place1))(not (next place3 place2))(not (next place3 place3))(not (next place4 place0))(not (next place4 place1))(not (next place4 place2))(not (next place4 place3))(not (next place4 place4)))))