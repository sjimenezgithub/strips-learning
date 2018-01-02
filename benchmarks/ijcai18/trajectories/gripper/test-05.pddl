(define (problem strips-gripper-x-3)
  (:domain gripper-strips)
  (:objects ball7 -  ball ball8 -  ball roomb -  room rooma -  room ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball left -  gripper right -  gripper )
  (:init (at ball6 rooma) (at ball5 rooma) (at ball2 rooma) (at ball3 rooma) (at ball4 rooma) (at ball1 rooma) (carry ball7 right) (carry ball8 left) (at-robby roomb) )
  (:goal (and (at ball6 rooma)(at ball5 rooma)(at ball2 rooma)(at ball3 rooma)(at ball4 rooma)(at ball1 rooma)(carry ball8 left)(at-robby roomb)(at ball7 roomb)(free right)(not (at-robby rooma))(not (at ball8 rooma))(not (at ball8 roomb))(not (at ball7 rooma))(not (at ball6 roomb))(not (at ball5 roomb))(not (at ball4 roomb))(not (at ball3 roomb))(not (at ball2 roomb))(not (at ball1 roomb))(not (free left))(not (carry ball8 right))(not (carry ball7 left))(not (carry ball7 right))(not (carry ball6 left))(not (carry ball6 right))(not (carry ball5 left))(not (carry ball5 right))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 left))(not (carry ball3 right))(not (carry ball2 left))(not (carry ball2 right))(not (carry ball1 left))(not (carry ball1 right)))))