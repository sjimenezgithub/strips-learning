(solution 
(:objects left -  gripper ball8 -  ball ball6 -  ball ball5 -  ball ball2 -  ball ball7 -  ball right -  gripper ball4 -  ball ball3 -  ball ball1 -  ball roomb -  room rooma -  room )
(:init (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (free left) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )
(:observations (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (free left) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(move roomb rooma)

(:observations (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (at-robby rooma) (free left) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(pick ball7 rooma right)

(:observations (at ball1 rooma) (at ball2 rooma) (carry ball7 right) (at ball6 rooma) (at ball8 rooma) (at-robby rooma) (free left) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(pick ball8 rooma left)

(:observations (carry ball8 left) (at ball1 rooma) (at ball2 rooma) (carry ball7 right) (at ball6 rooma) (at-robby rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(move rooma roomb)

(:observations (carry ball8 left) (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (carry ball7 right) (at ball6 rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(drop ball7 roomb right)

(:observations (carry ball8 left) (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball7 roomb) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(drop ball8 roomb left)

(:observations (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball8 roomb) (free left) (at ball7 roomb) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(move roomb rooma)

(:observations (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball8 roomb) (at-robby rooma) (free left) (at ball7 roomb) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) )

(pick ball4 rooma left)

(:observations (carry ball4 left) (at ball1 rooma) (at ball2 rooma) (free right) (at ball6 rooma) (at ball8 roomb) (at-robby rooma) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(pick ball6 rooma right)

(:observations (at ball1 rooma) (at ball2 rooma) (carry ball4 left) (at ball8 roomb) (at-robby rooma) (carry ball6 right) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(move rooma roomb)

(:observations (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (carry ball4 left) (at ball8 roomb) (carry ball6 right) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(drop ball4 roomb left)

(:observations (at-robby roomb) (at ball1 rooma) (at ball2 rooma) (at ball8 roomb) (at ball4 roomb) (carry ball6 right) (free left) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(drop ball6 roomb right)

(:observations (at-robby roomb) (at ball6 roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball8 roomb) (at ball4 roomb) (free left) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(move roomb rooma)

(:observations (at ball6 roomb) (at ball1 rooma) (at ball2 rooma) (free right) (at ball8 roomb) (at-robby rooma) (at ball4 roomb) (free left) (at ball7 roomb) (at ball3 rooma) (at ball5 rooma) )

(pick ball3 rooma right)

(:observations (at ball6 roomb) (at ball1 rooma) (at ball2 rooma) (carry ball3 right) (at ball8 roomb) (at-robby rooma) (at ball5 rooma) (free left) (at ball7 roomb) (at ball4 roomb) )

(pick ball1 rooma left)

(:observations (at ball6 roomb) (at ball2 rooma) (carry ball3 right) (at ball8 roomb) (at-robby rooma) (at ball5 rooma) (carry ball1 left) (at ball7 roomb) (at ball4 roomb) )

(move rooma roomb)

(:observations (at-robby roomb) (at ball6 roomb) (at ball2 rooma) (carry ball3 right) (at ball8 roomb) (at ball5 rooma) (carry ball1 left) (at ball7 roomb) (at ball4 roomb) )

(drop ball1 roomb left)

(:observations (at-robby roomb) (at ball6 roomb) (at ball1 roomb) (at ball2 rooma) (carry ball3 right) (at ball8 roomb) (at ball5 rooma) (free left) (at ball7 roomb) (at ball4 roomb) )

(drop ball3 roomb right)

(:observations (at-robby roomb) (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (at ball2 rooma) (free right) (at ball8 roomb) (at ball5 rooma) (free left) (at ball7 roomb) (at ball4 roomb) )

(move roomb rooma)

(:observations (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (at ball2 rooma) (free right) (at ball8 roomb) (at-robby rooma) (at ball5 rooma) (free left) (at ball7 roomb) (at ball4 roomb) )

(pick ball2 rooma left)

(:observations (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (free right) (carry ball2 left) (at ball8 roomb) (at-robby rooma) (at ball5 rooma) (at ball7 roomb) (at ball4 roomb) )

(pick ball5 rooma right)

(:observations (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (carry ball2 left) (at ball8 roomb) (at-robby rooma) (carry ball5 right) (at ball7 roomb) (at ball4 roomb) )

(move rooma roomb)

(:observations (at-robby roomb) (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (carry ball2 left) (at ball8 roomb) (carry ball5 right) (at ball7 roomb) (at ball4 roomb) )

(drop ball2 roomb left)

(:observations (at ball2 roomb) (at-robby roomb) (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (at ball8 roomb) (carry ball5 right) (free left) (at ball7 roomb) (at ball4 roomb) )

(drop ball5 roomb right)

(:observations (at ball2 roomb) (at-robby roomb) (at ball6 roomb) (at ball3 roomb) (at ball1 roomb) (free right) (at ball8 roomb) (free left) (at ball7 roomb) (at ball5 roomb) (at ball4 roomb) )

(move roomb rooma)

(:goal (and (at ball7 roomb)(at ball8 roomb)(at ball4 roomb)(at ball6 roomb)(at ball1 roomb)(at ball3 roomb)(at ball2 roomb)(free left)(at ball5 roomb)(free right)(at-robby rooma)(not (at-robby roomb))(not (at ball8 rooma))(not (at ball7 rooma))(not (at ball6 rooma))(not (at ball5 rooma))(not (at ball4 rooma))(not (at ball3 rooma))(not (at ball2 rooma))(not (at ball1 rooma))(not (carry ball8 left))(not (carry ball8 right))(not (carry ball7 left))(not (carry ball7 right))(not (carry ball6 left))(not (carry ball6 right))(not (carry ball5 left))(not (carry ball5 right))(not (carry ball4 left))(not (carry ball4 right))(not (carry ball3 left))(not (carry ball3 right))(not (carry ball2 left))(not (carry ball2 right))(not (carry ball1 left))(not (carry ball1 right)))))