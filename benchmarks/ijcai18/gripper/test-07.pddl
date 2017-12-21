(define (problem strips-gripper-x-1)
  (:domain gripper-strips)
  (:objects ball3 -  ball ball4 -  ball roomb -  room rooma -  room ball2 -  ball ball1 -  ball left -  gripper right -  gripper )
  (:init (at ball3 rooma) (at ball4 rooma) (at ball1 roomb) (free left) (at ball2 roomb) (free right) (at-robby rooma) )
  (:goal (and (at ball4 rooma)(at ball1 roomb)(at ball2 roomb)(free right)(at-robby rooma)(carry ball3 left)(not (at-robby roomb))(not (at ball4 roomb))(not (at ball3 rooma))(not (at ball3 roomb))(not (at ball2 rooma))(not (at ball1 rooma))(not (free left))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 right))(not (carry ball2 left))(not (carry ball2 right))(not (carry ball1 left))(not (carry ball1 right)))))