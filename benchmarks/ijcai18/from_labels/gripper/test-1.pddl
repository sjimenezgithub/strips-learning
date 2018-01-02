(define (problem strips-gripper-x-2)
  (:domain gripper-strips)
  (:objects ball6 -  ball ball7 -  ball roomb -  room rooma -  room ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball left -  gripper right -  gripper )
  (:init (at ball7 rooma) (free left) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) )
  (:goal (and (at ball7 rooma)(at ball3 rooma)(at ball4 rooma)(at ball5 rooma)(at ball1 rooma)(carry ball6 right)(at-robby roomb)(at ball2 roomb)(free left)(not (at-robby rooma))(not (at ball7 roomb))(not (at ball6 rooma))(not (at ball6 roomb))(not (at ball5 roomb))(not (at ball4 roomb))(not (at ball3 roomb))(not (at ball2 rooma))(not (at ball1 roomb))(not (free right))(not (carry ball7 left))(not (carry ball7 right))(not (carry ball6 left))(not (carry ball5 left))(not (carry ball5 right))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 left))(not (carry ball3 right))(not (carry ball2 left))(not (carry ball2 right))(not (carry ball1 left))(not (carry ball1 right)))))