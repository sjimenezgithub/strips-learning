(define (problem hiking-2-2)
  (:domain hiking)
  (:objects tent0 -  tent car1 -  car tent1 -  tent place0 -  place couple0 -  couple place1 -  place place2 -  place place3 -  place car0 -  car place4 -  place guy0 -  person girl0 -  person )
  (:init (next place1 place2) (down tent1) (next place0 place1) (walked couple0 place1) (next place3 place4) (partners couple0 guy0 girl0) (down tent0) (next place2 place3) (at-person girl0 place2) (at-car car0 place2) (at-tent tent0 place2) (at-tent tent1 place3) (at-person guy0 place4) (at-car car1 place4) )
  (:goal (and (next place1 place2)(down tent1)(next place0 place1)(walked couple0 place1)(next place3 place4)(partners couple0 guy0 girl0)(next place2 place3)(at-person girl0 place2)(at-car car0 place2)(at-tent tent0 place2)(at-tent tent1 place3)(at-person guy0 place4)(at-car car1 place4)(up tent0)(not (at-tent tent0 place0))(not (at-tent tent0 place1))(not (at-tent tent0 place3))(not (at-tent tent0 place4))(not (at-tent tent1 place0))(not (at-tent tent1 place1))(not (at-tent tent1 place2))(not (at-tent tent1 place4))(not (at-person guy0 place0))(not (at-person guy0 place1))(not (at-person guy0 place2))(not (at-person guy0 place3))(not (at-person girl0 place0))(not (at-person girl0 place1))(not (at-person girl0 place3))(not (at-person girl0 place4))(not (at-car car0 place0))(not (at-car car0 place1))(not (at-car car0 place3))(not (at-car car0 place4))(not (at-car car1 place0))(not (at-car car1 place1))(not (at-car car1 place2))(not (at-car car1 place3))(not (partners couple0 guy0 guy0))(not (partners couple0 girl0 guy0))(not (partners couple0 girl0 girl0))(not (up tent1))(not (down tent0))(not (walked couple0 place0))(not (walked couple0 place2))(not (walked couple0 place3))(not (walked couple0 place4))(not (next place0 place0))(not (next place0 place2))(not (next place0 place3))(not (next place0 place4))(not (next place1 place0))(not (next place1 place1))(not (next place1 place3))(not (next place1 place4))(not (next place2 place0))(not (next place2 place1))(not (next place2 place2))(not (next place2 place4))(not (next place3 place0))(not (next place3 place1))(not (next place3 place2))(not (next place3 place3))(not (next place4 place0))(not (next place4 place1))(not (next place4 place2))(not (next place4 place3))(not (next place4 place4)))))