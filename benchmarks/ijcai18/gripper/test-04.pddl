(define (problem strips-gripper-x-1)
  (:domain gripper-strips)
  (:objects ball3 -  ball ball4 -  ball roomb -  room rooma -  room ball2 -  ball ball1 -  ball left -  gripper right -  gripper )
  (:init (at ball3 rooma) (at ball4 rooma) (carry ball1 left) (carry ball2 right) (at-robby roomb) )
  (:goal (and (at ball3 rooma)(at ball4 rooma)(carry ball2 right)(at-robby roomb)(at ball1 roomb)(free left)(not (at-robby rooma))(not (at ball4 roomb))(not (at ball3 roomb))(not (at ball2 rooma))(not (at ball2 roomb))(not (at ball1 rooma))(not (free right))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 left))(not (carry ball3 right))(not (carry ball2 left))(not (carry ball1 left))(not (carry ball1 right)))))