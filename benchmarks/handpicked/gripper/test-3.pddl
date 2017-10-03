(define (problem strips-gripper-x-2)
   (:domain gripper-strips)
   (:objects rooma roomb - room ball4 ball3 ball2 ball1 - ball left right - gripper)   
   (:init
          (at ball1 roomb)	  
          (at ball2 roomb)   
          (at ball3 roomb)
          (at ball4 roomb)	 	  
	  
          (free left)
          (free right)
	  
          (at-robby rooma)
	  )
	  
   (:goal (and	  

          (not (at ball1 rooma))
          (at ball1 roomb)

          (at ball2 rooma)
          (not (at ball2 roomb))

          (at ball3 rooma)
          (not (at ball3 roomb))	  	  
	  
          (not (at ball4 rooma))	  
          (at ball4 roomb)	 
	  
          (free left)
          (free right)

	  (not (carry ball1 left))
	  (not (carry ball2 left))
	  (not (carry ball3 left))	  
	  (not (carry ball4 left))
	  
	  (not (carry ball1 right))
	  (not (carry ball2 right))
	  (not (carry ball3 right))
	  (not (carry ball4 right))	  
	  
          (at-robby rooma)
          (not (at-robby roomb))	  
)))