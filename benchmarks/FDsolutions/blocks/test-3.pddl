(define (problem blocks-4-1)
  (:domain blocks)
  (:objects d -  object c -  object b -  object a -  object )
  (:init (ontable d) (ontable b) (clear c) (ontable c) (clear d) (clear a) (handempty ) (on a b) (not (on a a)) (not (on a c)) (not (on a d)) (not (on c a)) (not (on c c)) (not (on c d)) (not (on c b)) (not (on d a)) (not (on d c)) (not (on d d)) (not (on d b)) (not (on b a)) (not (on b c)) (not (on b d)) (not (on b b)) (not (ontable a)) (not (clear b)) (not (holding a)) (not (holding c)) (not (holding d)) (not (holding b)) )
  (:goal (and (ontable b)(on a b)(clear c)(on c a)(holding d))))