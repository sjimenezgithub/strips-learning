(define (problem hiking-2-2)
  (:domain hiking)
  (:objects place1 -  place place2 -  place car0 -  car car1 -  car tent1 -  tent tent0 -  tent couple0 -  couple couple1 -  couple place0 -  place place4 -  place place3 -  place guy0 -  person girl0 -  person guy1 -  person girl1 -  person )
  (:init (next place0 place1) (next place3 place4) (partners couple0 guy0 girl0) (partners couple1 guy1 girl1) (walked couple1 place0) (next place1 place2) (next place2 place3) (at-tent tent1 place1) (walked couple0 place2) (down tent0) (at-person girl0 place0) (at-car car1 place0) (at-tent tent0 place0) (at-person guy0 place0) (up tent1) (at-person guy1 place0) (at-car car0 place0) (at-person girl1 place0) )
  (:goal (and (next place0 place1)(next place3 place4)(partners couple0 guy0 girl0)(partners couple1 guy1 girl1)(walked couple1 place0)(next place1 place2)(next place2 place3)(at-tent tent1 place1)(walked couple0 place2)(down tent0)(at-person guy0 place0)(up tent1)(at-person guy1 place0)(at-car car0 place0)(at-person girl1 place0)(at-person girl0 place2)(at-car car1 place2)(at-tent tent0 place2)(not (at-tent tent0 place0))(not (at-tent tent0 place1))(not (at-tent tent0 place3))(not (at-tent tent0 place4))(not (at-tent tent1 place0))(not (at-tent tent1 place2))(not (at-tent tent1 place3))(not (at-tent tent1 place4))(not (at-person guy0 place1))(not (at-person guy0 place2))(not (at-person guy0 place3))(not (at-person guy0 place4))(not (at-person girl0 place0))(not (at-person girl0 place1))(not (at-person girl0 place3))(not (at-person girl0 place4))(not (at-person guy1 place1))(not (at-person guy1 place2))(not (at-person guy1 place3))(not (at-person guy1 place4))(not (at-person girl1 place1))(not (at-person girl1 place2))(not (at-person girl1 place3))(not (at-person girl1 place4))(not (at-car car0 place1))(not (at-car car0 place2))(not (at-car car0 place3))(not (at-car car0 place4))(not (at-car car1 place0))(not (at-car car1 place1))(not (at-car car1 place3))(not (at-car car1 place4))(not (partners couple0 guy0 guy0))(not (partners couple0 guy0 guy1))(not (partners couple0 guy0 girl1))(not (partners couple0 girl0 guy0))(not (partners couple0 girl0 girl0))(not (partners couple0 girl0 guy1))(not (partners couple0 girl0 girl1))(not (partners couple0 guy1 guy0))(not (partners couple0 guy1 girl0))(not (partners couple0 guy1 guy1))(not (partners couple0 guy1 girl1))(not (partners couple0 girl1 guy0))(not (partners couple0 girl1 girl0))(not (partners couple0 girl1 guy1))(not (partners couple0 girl1 girl1))(not (partners couple1 guy0 guy0))(not (partners couple1 guy0 girl0))(not (partners couple1 guy0 guy1))(not (partners couple1 guy0 girl1))(not (partners couple1 girl0 guy0))(not (partners couple1 girl0 girl0))(not (partners couple1 girl0 guy1))(not (partners couple1 girl0 girl1))(not (partners couple1 guy1 guy0))(not (partners couple1 guy1 girl0))(not (partners couple1 guy1 guy1))(not (partners couple1 girl1 guy0))(not (partners couple1 girl1 girl0))(not (partners couple1 girl1 guy1))(not (partners couple1 girl1 girl1))(not (up tent0))(not (down tent1))(not (walked couple0 place0))(not (walked couple0 place1))(not (walked couple0 place3))(not (walked couple0 place4))(not (walked couple1 place1))(not (walked couple1 place2))(not (walked couple1 place3))(not (walked couple1 place4))(not (next place0 place0))(not (next place0 place2))(not (next place0 place3))(not (next place0 place4))(not (next place1 place0))(not (next place1 place1))(not (next place1 place3))(not (next place1 place4))(not (next place2 place0))(not (next place2 place1))(not (next place2 place2))(not (next place2 place4))(not (next place3 place0))(not (next place3 place1))(not (next place3 place2))(not (next place3 place3))(not (next place4 place0))(not (next place4 place1))(not (next place4 place2))(not (next place4 place3))(not (next place4 place4)))))