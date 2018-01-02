(define (problem strips-gripper-x-3)
  (:domain gripper-strips)
  (:objects ball7 -  ball ball8 -  ball roomb -  room rooma -  room ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball left -  gripper right -  gripper )
  (:init (at ball5 rooma) (at ball7 roomb) (at ball8 roomb) (at ball4 roomb) (at ball6 roomb) (at ball1 roomb) (at ball3 roomb) (free right) (at-robby rooma) (carry ball2 left) )
  (:goal (and (at ball7 roomb)(at ball8 roomb)(at ball4 roomb)(at ball6 roomb)(at ball1 roomb)(at ball3 roomb)(at-robby rooma)(carry ball2 left)(carry ball5 right)(not (at-robby roomb))(not (at ball8 rooma))(not (at ball7 rooma))(not (at ball6 rooma))(not (at ball5 rooma))(not (at ball5 roomb))(not (at ball4 rooma))(not (at ball3 rooma))(not (at ball2 rooma))(not (at ball2 roomb))(not (at ball1 rooma))(not (free left))(not (free right))(not (carry ball8 left))(not (carry ball8 right))(not (carry ball7 left))(not (carry ball7 right))(not (carry ball6 left))(not (carry ball6 right))(not (carry ball5 left))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 left))(not (carry ball3 right))(not (carry ball2 right))(not (carry ball1 left))(not (carry ball1 right)))))