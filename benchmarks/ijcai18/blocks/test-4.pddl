(define (problem blocks-4-1)
  (:domain blocks)
  (:objects c -  object d -  object b -  object a -  object )
  (:init (ontable d) (on a d) (clear b) (ontable b) (holding c) (clear a) )
  (:goal (and (ontable d)(on a d)(clear b)(ontable b)(clear a)(clear c)(handempty )(ontable c)(not (on a a))(not (on a c))(not (on a b))(not (on c a))(not (on c c))(not (on c d))(not (on c b))(not (on d a))(not (on d c))(not (on d d))(not (on d b))(not (on b a))(not (on b c))(not (on b d))(not (on b b))(not (ontable a))(not (clear d))(not (holding a))(not (holding c))(not (holding d))(not (holding b)))))