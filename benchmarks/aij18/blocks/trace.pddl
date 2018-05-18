(solution 
(:objects b -  object d -  object f -  object e -  object c -  object g -  object a -  object )
(:init (on a g) (ontable g) (on d b) (on e f) (handempty ) (on c d) (clear c) (ontable f) (on b e) (clear a) )
(:observations (on a g) (ontable g) (on d b) (on e f) (handempty ) (on c d) (clear c) (ontable f) (on b e) (clear a) )

(unstack c d)

(:observations (on a g) (ontable g) (clear d) (on d b) (on e f) (ontable f) (on b e) (clear a) (holding c) )

(put-down c)

(:observations (on a g) (ontable g) (clear d) (on d b) (on e f) (ontable c) (handempty ) (clear c) (ontable f) (on b e) (clear a) )

(unstack d b)

(:observations (on a g) (holding d) (ontable g) (on e f) (ontable c) (clear b) (clear c) (ontable f) (on b e) (clear a) )

(put-down d)

(:observations (on a g) (handempty ) (ontable g) (clear d) (on e f) (ontable c) (clear b) (ontable d) (clear c) (ontable f) (on b e) (clear a) )

(unstack b e)

(:observations (on a g) (ontable g) (clear d) (on e f) (ontable c) (ontable d) (clear c) (holding b) (clear e) (ontable f) (clear a) )

(put-down b)

(:observations (on a g) (handempty ) (ontable g) (ontable b) (clear d) (on e f) (ontable c) (clear b) (ontable d) (clear c) (clear e) (ontable f) (clear a) )

(unstack e f)

(:observations (on a g) (ontable g) (ontable b) (clear d) (holding e) (ontable c) (clear b) (ontable d) (clear c) (ontable f) (clear f) (clear a) )

(put-down e)

(:observations (on a g) (handempty ) (ontable g) (ontable b) (clear d) (clear e) (ontable e) (ontable c) (clear b) (ontable d) (clear c) (ontable f) (clear f) (clear a) )

(pick-up c)

(:observations (on a g) (ontable g) (ontable b) (clear d) (clear e) (ontable e) (clear b) (ontable d) (ontable f) (clear f) (clear a) (holding c) )

(stack c d)

(:observations (on a g) (handempty ) (ontable g) (ontable b) (clear e) (ontable e) (clear b) (on c d) (ontable d) (clear c) (ontable f) (clear f) (clear a) )

(unstack a g)

(:observations (ontable g) (ontable b) (clear e) (clear b) (on c d) (ontable d) (clear c) (ontable f) (holding a) (clear f) (ontable e) (clear g) )

(put-down a)

(:observations (handempty ) (ontable g) (ontable b) (clear e) (clear a) (clear b) (on c d) (ontable d) (clear c) (ontable a) (ontable f) (clear f) (ontable e) (clear g) )

(pick-up g)

(:observations (ontable b) (clear e) (clear a) (clear b) (on c d) (ontable d) (clear c) (holding g) (ontable a) (ontable f) (clear f) (ontable e) )

(stack g c)

(:observations (handempty ) (ontable b) (clear e) (on g c) (clear a) (clear b) (on c d) (ontable d) (ontable a) (ontable f) (clear f) (ontable e) (clear g) )

(pick-up f)

(:observations (ontable b) (holding f) (clear e) (on g c) (clear a) (clear b) (on c d) (ontable d) (ontable a) (ontable e) (clear g) )

(stack f g)

(:observations (handempty ) (ontable b) (on f g) (clear e) (on g c) (clear a) (clear b) (on c d) (ontable d) (ontable a) (clear f) (ontable e) )

(pick-up b)

(:observations (on f g) (ontable a) (on g c) (ontable e) (on c d) (ontable d) (holding b) (clear e) (clear f) (clear a) )

(stack b f)

(:observations (on f g) (ontable a) (on g c) (ontable e) (clear b) (on c d) (ontable d) (clear e) (on b f) (handempty ) (clear a) )

(pick-up e)

(:observations (on f g) (ontable a) (ontable d) (holding e) (clear b) (on c d) (on g c) (on b f) (clear a) )

(stack e b)

(:observations (on f g) (ontable a) (ontable d) (handempty ) (on c d) (on g c) (on e b) (clear e) (on b f) (clear a) )

(pick-up a)

(:observations (on f g) (clear e) (on g c) (on c d) (ontable d) (on e b) (on b f) (holding a) )

(stack a e)

(:goal (and (ontable d)(on c d)(on g c)(on f g)(on b f)(on e b)(clear a)(handempty )(on a e)(not (on e e))(not (on e d))(not (on e f))(not (on e g))(not (on e c))(not (on e a))(not (on b e))(not (on b b))(not (on b d))(not (on b g))(not (on b c))(not (on b a))(not (on d e))(not (on d b))(not (on d d))(not (on d f))(not (on d g))(not (on d c))(not (on d a))(not (on f e))(not (on f b))(not (on f d))(not (on f f))(not (on f c))(not (on f a))(not (on g e))(not (on g b))(not (on g d))(not (on g f))(not (on g g))(not (on g a))(not (on c e))(not (on c b))(not (on c f))(not (on c g))(not (on c c))(not (on c a))(not (on a b))(not (on a d))(not (on a f))(not (on a g))(not (on a c))(not (on a a))(not (ontable e))(not (ontable b))(not (ontable f))(not (ontable g))(not (ontable c))(not (ontable a))(not (clear e))(not (clear b))(not (clear d))(not (clear f))(not (clear g))(not (clear c))(not (holding e))(not (holding b))(not (holding d))(not (holding f))(not (holding g))(not (holding c))(not (holding a)))))