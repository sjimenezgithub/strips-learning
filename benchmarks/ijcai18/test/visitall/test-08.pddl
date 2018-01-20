(define (problem grid-5)
  (:domain grid-visit-all)
  (:objects loc-x0-y1 -  place loc-x0-y2 -  place loc-x0-y0 -  place loc-x0-y4 -  place loc-x0-y3 -  place loc-x1-y0 -  place loc-x1-y1 -  place loc-x1-y2 -  place loc-x1-y3 -  place loc-x1-y4 -  place loc-x2-y0 -  place loc-x2-y1 -  place loc-x2-y2 -  place loc-x2-y3 -  place loc-x2-y4 -  place loc-x3-y0 -  place loc-x3-y1 -  place loc-x3-y2 -  place loc-x3-y3 -  place loc-x3-y4 -  place loc-x4-y0 -  place loc-x4-y1 -  place loc-x4-y2 -  place loc-x4-y3 -  place loc-x4-y4 -  place )
  (:init (connected loc-x1-y0 loc-x1-y1) (connected loc-x3-y3 loc-x2-y3) (connected loc-x0-y1 loc-x1-y1) (connected loc-x4-y2 loc-x3-y2) (connected loc-x4-y3 loc-x3-y3) (connected loc-x3-y0 loc-x3-y1) (connected loc-x1-y4 loc-x0-y4) (connected loc-x2-y3 loc-x1-y3) (connected loc-x4-y4 loc-x3-y4) (connected loc-x0-y3 loc-x1-y3) (connected loc-x1-y3 loc-x1-y4) (connected loc-x3-y1 loc-x3-y2) (connected loc-x4-y1 loc-x3-y1) (connected loc-x3-y2 loc-x3-y1) (connected loc-x1-y0 loc-x2-y0) (connected loc-x3-y2 loc-x3-y3) (connected loc-x0-y0 loc-x0-y1) (connected loc-x4-y2 loc-x4-y3) (connected loc-x2-y0 loc-x2-y1) (connected loc-x3-y1 loc-x3-y0) (connected loc-x1-y2 loc-x1-y3) (connected loc-x4-y0 loc-x3-y0) (connected loc-x2-y4 loc-x3-y4) (connected loc-x3-y0 loc-x2-y0) (connected loc-x0-y0 loc-x1-y0) (connected loc-x2-y3 loc-x2-y2) (connected loc-x0-y1 loc-x0-y2) (connected loc-x1-y2 loc-x2-y2) (connected loc-x4-y1 loc-x4-y0) (connected loc-x1-y2 loc-x0-y2) (connected loc-x2-y1 loc-x1-y1) (connected loc-x2-y2 loc-x3-y2) (connected loc-x1-y2 loc-x1-y1) (connected loc-x3-y4 loc-x2-y4) (connected loc-x0-y1 loc-x0-y0) (connected loc-x0-y2 loc-x1-y2) (connected loc-x4-y3 loc-x4-y4) (connected loc-x1-y1 loc-x1-y0) (connected loc-x1-y3 loc-x2-y3) (visited loc-x0-y0) (connected loc-x0-y3 loc-x0-y4) (connected loc-x1-y1 loc-x0-y1) (connected loc-x3-y3 loc-x4-y3) (connected loc-x1-y1 loc-x1-y2) (connected loc-x2-y2 loc-x2-y3) (connected loc-x1-y1 loc-x2-y1) (connected loc-x4-y0 loc-x4-y1) (connected loc-x3-y3 loc-x3-y2) (connected loc-x0-y4 loc-x0-y3) (connected loc-x2-y2 loc-x2-y1) (connected loc-x0-y2 loc-x0-y3) (connected loc-x2-y1 loc-x3-y1) (connected loc-x3-y0 loc-x4-y0) (connected loc-x3-y4 loc-x4-y4) (connected loc-x2-y2 loc-x1-y2) (connected loc-x3-y3 loc-x3-y4) (connected loc-x2-y1 loc-x2-y2) (connected loc-x4-y2 loc-x4-y1) (connected loc-x1-y4 loc-x1-y3) (connected loc-x0-y2 loc-x0-y1) (connected loc-x2-y0 loc-x3-y0) (connected loc-x2-y4 loc-x1-y4) (connected loc-x4-y1 loc-x4-y2) (connected loc-x2-y1 loc-x2-y0) (connected loc-x4-y4 loc-x4-y3) (connected loc-x1-y3 loc-x1-y2) (connected loc-x4-y3 loc-x4-y2) (connected loc-x2-y4 loc-x2-y3) (connected loc-x2-y3 loc-x2-y4) (connected loc-x3-y2 loc-x4-y2) (connected loc-x3-y1 loc-x4-y1) (connected loc-x1-y3 loc-x0-y3) (connected loc-x3-y1 loc-x2-y1) (connected loc-x2-y3 loc-x3-y3) (connected loc-x2-y0 loc-x1-y0) (connected loc-x0-y4 loc-x1-y4) (connected loc-x1-y0 loc-x0-y0) (connected loc-x3-y2 loc-x2-y2) (connected loc-x3-y4 loc-x3-y3) (connected loc-x0-y3 loc-x0-y2) (connected loc-x1-y4 loc-x2-y4) (visited loc-x0-y1) (visited loc-x0-y2) (visited loc-x0-y3) (visited loc-x0-y4) (visited loc-x1-y4) (visited loc-x2-y4) (at-robot loc-x3-y4) (visited loc-x3-y4) )
  (:goal (and (connected loc-x1-y0 loc-x1-y1)(connected loc-x3-y3 loc-x2-y3)(connected loc-x0-y1 loc-x1-y1)(connected loc-x4-y2 loc-x3-y2)(connected loc-x4-y3 loc-x3-y3)(connected loc-x3-y0 loc-x3-y1)(connected loc-x1-y4 loc-x0-y4)(connected loc-x2-y3 loc-x1-y3)(connected loc-x4-y4 loc-x3-y4)(connected loc-x0-y3 loc-x1-y3)(connected loc-x1-y3 loc-x1-y4)(connected loc-x3-y1 loc-x3-y2)(connected loc-x4-y1 loc-x3-y1)(connected loc-x3-y2 loc-x3-y1)(connected loc-x1-y0 loc-x2-y0)(connected loc-x3-y2 loc-x3-y3)(connected loc-x0-y0 loc-x0-y1)(connected loc-x4-y2 loc-x4-y3)(connected loc-x2-y0 loc-x2-y1)(connected loc-x3-y1 loc-x3-y0)(connected loc-x1-y2 loc-x1-y3)(connected loc-x4-y0 loc-x3-y0)(connected loc-x2-y4 loc-x3-y4)(connected loc-x3-y0 loc-x2-y0)(connected loc-x0-y0 loc-x1-y0)(connected loc-x2-y3 loc-x2-y2)(connected loc-x0-y1 loc-x0-y2)(connected loc-x1-y2 loc-x2-y2)(connected loc-x4-y1 loc-x4-y0)(connected loc-x1-y2 loc-x0-y2)(connected loc-x2-y1 loc-x1-y1)(connected loc-x2-y2 loc-x3-y2)(connected loc-x1-y2 loc-x1-y1)(connected loc-x3-y4 loc-x2-y4)(connected loc-x0-y1 loc-x0-y0)(connected loc-x0-y2 loc-x1-y2)(connected loc-x4-y3 loc-x4-y4)(connected loc-x1-y1 loc-x1-y0)(connected loc-x1-y3 loc-x2-y3)(visited loc-x0-y0)(connected loc-x0-y3 loc-x0-y4)(connected loc-x1-y1 loc-x0-y1)(connected loc-x3-y3 loc-x4-y3)(connected loc-x1-y1 loc-x1-y2)(connected loc-x2-y2 loc-x2-y3)(connected loc-x1-y1 loc-x2-y1)(connected loc-x4-y0 loc-x4-y1)(connected loc-x3-y3 loc-x3-y2)(connected loc-x0-y4 loc-x0-y3)(connected loc-x2-y2 loc-x2-y1)(connected loc-x0-y2 loc-x0-y3)(connected loc-x2-y1 loc-x3-y1)(connected loc-x3-y0 loc-x4-y0)(connected loc-x3-y4 loc-x4-y4)(connected loc-x2-y2 loc-x1-y2)(connected loc-x3-y3 loc-x3-y4)(connected loc-x2-y1 loc-x2-y2)(connected loc-x4-y2 loc-x4-y1)(connected loc-x1-y4 loc-x1-y3)(connected loc-x0-y2 loc-x0-y1)(connected loc-x2-y0 loc-x3-y0)(connected loc-x2-y4 loc-x1-y4)(connected loc-x4-y1 loc-x4-y2)(connected loc-x2-y1 loc-x2-y0)(connected loc-x4-y4 loc-x4-y3)(connected loc-x1-y3 loc-x1-y2)(connected loc-x4-y3 loc-x4-y2)(connected loc-x2-y4 loc-x2-y3)(connected loc-x2-y3 loc-x2-y4)(connected loc-x3-y2 loc-x4-y2)(connected loc-x3-y1 loc-x4-y1)(connected loc-x1-y3 loc-x0-y3)(connected loc-x3-y1 loc-x2-y1)(connected loc-x2-y3 loc-x3-y3)(connected loc-x2-y0 loc-x1-y0)(connected loc-x0-y4 loc-x1-y4)(connected loc-x1-y0 loc-x0-y0)(connected loc-x3-y2 loc-x2-y2)(connected loc-x3-y4 loc-x3-y3)(connected loc-x0-y3 loc-x0-y2)(connected loc-x1-y4 loc-x2-y4)(visited loc-x0-y1)(visited loc-x0-y2)(visited loc-x0-y3)(visited loc-x0-y4)(visited loc-x1-y4)(visited loc-x2-y4)(visited loc-x3-y4)(at-robot loc-x3-y3)(visited loc-x3-y3)(not (connected loc-x0-y0 loc-x0-y0))(not (connected loc-x0-y0 loc-x0-y2))(not (connected loc-x0-y0 loc-x0-y3))(not (connected loc-x0-y0 loc-x0-y4))(not (connected loc-x0-y0 loc-x1-y1))(not (connected loc-x0-y0 loc-x1-y2))(not (connected loc-x0-y0 loc-x1-y3))(not (connected loc-x0-y0 loc-x1-y4))(not (connected loc-x0-y0 loc-x2-y0))(not (connected loc-x0-y0 loc-x2-y1))(not (connected loc-x0-y0 loc-x2-y2))(not (connected loc-x0-y0 loc-x2-y3))(not (connected loc-x0-y0 loc-x2-y4))(not (connected loc-x0-y0 loc-x3-y0))(not (connected loc-x0-y0 loc-x3-y1))(not (connected loc-x0-y0 loc-x3-y2))(not (connected loc-x0-y0 loc-x3-y3))(not (connected loc-x0-y0 loc-x3-y4))(not (connected loc-x0-y0 loc-x4-y0))(not (connected loc-x0-y0 loc-x4-y1))(not (connected loc-x0-y0 loc-x4-y2))(not (connected loc-x0-y0 loc-x4-y3))(not (connected loc-x0-y0 loc-x4-y4))(not (connected loc-x0-y1 loc-x0-y1))(not (connected loc-x0-y1 loc-x0-y3))(not (connected loc-x0-y1 loc-x0-y4))(not (connected loc-x0-y1 loc-x1-y0))(not (connected loc-x0-y1 loc-x1-y2))(not (connected loc-x0-y1 loc-x1-y3))(not (connected loc-x0-y1 loc-x1-y4))(not (connected loc-x0-y1 loc-x2-y0))(not (connected loc-x0-y1 loc-x2-y1))(not (connected loc-x0-y1 loc-x2-y2))(not (connected loc-x0-y1 loc-x2-y3))(not (connected loc-x0-y1 loc-x2-y4))(not (connected loc-x0-y1 loc-x3-y0))(not (connected loc-x0-y1 loc-x3-y1))(not (connected loc-x0-y1 loc-x3-y2))(not (connected loc-x0-y1 loc-x3-y3))(not (connected loc-x0-y1 loc-x3-y4))(not (connected loc-x0-y1 loc-x4-y0))(not (connected loc-x0-y1 loc-x4-y1))(not (connected loc-x0-y1 loc-x4-y2))(not (connected loc-x0-y1 loc-x4-y3))(not (connected loc-x0-y1 loc-x4-y4))(not (connected loc-x0-y2 loc-x0-y0))(not (connected loc-x0-y2 loc-x0-y2))(not (connected loc-x0-y2 loc-x0-y4))(not (connected loc-x0-y2 loc-x1-y0))(not (connected loc-x0-y2 loc-x1-y1))(not (connected loc-x0-y2 loc-x1-y3))(not (connected loc-x0-y2 loc-x1-y4))(not (connected loc-x0-y2 loc-x2-y0))(not (connected loc-x0-y2 loc-x2-y1))(not (connected loc-x0-y2 loc-x2-y2))(not (connected loc-x0-y2 loc-x2-y3))(not (connected loc-x0-y2 loc-x2-y4))(not (connected loc-x0-y2 loc-x3-y0))(not (connected loc-x0-y2 loc-x3-y1))(not (connected loc-x0-y2 loc-x3-y2))(not (connected loc-x0-y2 loc-x3-y3))(not (connected loc-x0-y2 loc-x3-y4))(not (connected loc-x0-y2 loc-x4-y0))(not (connected loc-x0-y2 loc-x4-y1))(not (connected loc-x0-y2 loc-x4-y2))(not (connected loc-x0-y2 loc-x4-y3))(not (connected loc-x0-y2 loc-x4-y4))(not (connected loc-x0-y3 loc-x0-y0))(not (connected loc-x0-y3 loc-x0-y1))(not (connected loc-x0-y3 loc-x0-y3))(not (connected loc-x0-y3 loc-x1-y0))(not (connected loc-x0-y3 loc-x1-y1))(not (connected loc-x0-y3 loc-x1-y2))(not (connected loc-x0-y3 loc-x1-y4))(not (connected loc-x0-y3 loc-x2-y0))(not (connected loc-x0-y3 loc-x2-y1))(not (connected loc-x0-y3 loc-x2-y2))(not (connected loc-x0-y3 loc-x2-y3))(not (connected loc-x0-y3 loc-x2-y4))(not (connected loc-x0-y3 loc-x3-y0))(not (connected loc-x0-y3 loc-x3-y1))(not (connected loc-x0-y3 loc-x3-y2))(not (connected loc-x0-y3 loc-x3-y3))(not (connected loc-x0-y3 loc-x3-y4))(not (connected loc-x0-y3 loc-x4-y0))(not (connected loc-x0-y3 loc-x4-y1))(not (connected loc-x0-y3 loc-x4-y2))(not (connected loc-x0-y3 loc-x4-y3))(not (connected loc-x0-y3 loc-x4-y4))(not (connected loc-x0-y4 loc-x0-y0))(not (connected loc-x0-y4 loc-x0-y1))(not (connected loc-x0-y4 loc-x0-y2))(not (connected loc-x0-y4 loc-x0-y4))(not (connected loc-x0-y4 loc-x1-y0))(not (connected loc-x0-y4 loc-x1-y1))(not (connected loc-x0-y4 loc-x1-y2))(not (connected loc-x0-y4 loc-x1-y3))(not (connected loc-x0-y4 loc-x2-y0))(not (connected loc-x0-y4 loc-x2-y1))(not (connected loc-x0-y4 loc-x2-y2))(not (connected loc-x0-y4 loc-x2-y3))(not (connected loc-x0-y4 loc-x2-y4))(not (connected loc-x0-y4 loc-x3-y0))(not (connected loc-x0-y4 loc-x3-y1))(not (connected loc-x0-y4 loc-x3-y2))(not (connected loc-x0-y4 loc-x3-y3))(not (connected loc-x0-y4 loc-x3-y4))(not (connected loc-x0-y4 loc-x4-y0))(not (connected loc-x0-y4 loc-x4-y1))(not (connected loc-x0-y4 loc-x4-y2))(not (connected loc-x0-y4 loc-x4-y3))(not (connected loc-x0-y4 loc-x4-y4))(not (connected loc-x1-y0 loc-x0-y1))(not (connected loc-x1-y0 loc-x0-y2))(not (connected loc-x1-y0 loc-x0-y3))(not (connected loc-x1-y0 loc-x0-y4))(not (connected loc-x1-y0 loc-x1-y0))(not (connected loc-x1-y0 loc-x1-y2))(not (connected loc-x1-y0 loc-x1-y3))(not (connected loc-x1-y0 loc-x1-y4))(not (connected loc-x1-y0 loc-x2-y1))(not (connected loc-x1-y0 loc-x2-y2))(not (connected loc-x1-y0 loc-x2-y3))(not (connected loc-x1-y0 loc-x2-y4))(not (connected loc-x1-y0 loc-x3-y0))(not (connected loc-x1-y0 loc-x3-y1))(not (connected loc-x1-y0 loc-x3-y2))(not (connected loc-x1-y0 loc-x3-y3))(not (connected loc-x1-y0 loc-x3-y4))(not (connected loc-x1-y0 loc-x4-y0))(not (connected loc-x1-y0 loc-x4-y1))(not (connected loc-x1-y0 loc-x4-y2))(not (connected loc-x1-y0 loc-x4-y3))(not (connected loc-x1-y0 loc-x4-y4))(not (connected loc-x1-y1 loc-x0-y0))(not (connected loc-x1-y1 loc-x0-y2))(not (connected loc-x1-y1 loc-x0-y3))(not (connected loc-x1-y1 loc-x0-y4))(not (connected loc-x1-y1 loc-x1-y1))(not (connected loc-x1-y1 loc-x1-y3))(not (connected loc-x1-y1 loc-x1-y4))(not (connected loc-x1-y1 loc-x2-y0))(not (connected loc-x1-y1 loc-x2-y2))(not (connected loc-x1-y1 loc-x2-y3))(not (connected loc-x1-y1 loc-x2-y4))(not (connected loc-x1-y1 loc-x3-y0))(not (connected loc-x1-y1 loc-x3-y1))(not (connected loc-x1-y1 loc-x3-y2))(not (connected loc-x1-y1 loc-x3-y3))(not (connected loc-x1-y1 loc-x3-y4))(not (connected loc-x1-y1 loc-x4-y0))(not (connected loc-x1-y1 loc-x4-y1))(not (connected loc-x1-y1 loc-x4-y2))(not (connected loc-x1-y1 loc-x4-y3))(not (connected loc-x1-y1 loc-x4-y4))(not (connected loc-x1-y2 loc-x0-y0))(not (connected loc-x1-y2 loc-x0-y1))(not (connected loc-x1-y2 loc-x0-y3))(not (connected loc-x1-y2 loc-x0-y4))(not (connected loc-x1-y2 loc-x1-y0))(not (connected loc-x1-y2 loc-x1-y2))(not (connected loc-x1-y2 loc-x1-y4))(not (connected loc-x1-y2 loc-x2-y0))(not (connected loc-x1-y2 loc-x2-y1))(not (connected loc-x1-y2 loc-x2-y3))(not (connected loc-x1-y2 loc-x2-y4))(not (connected loc-x1-y2 loc-x3-y0))(not (connected loc-x1-y2 loc-x3-y1))(not (connected loc-x1-y2 loc-x3-y2))(not (connected loc-x1-y2 loc-x3-y3))(not (connected loc-x1-y2 loc-x3-y4))(not (connected loc-x1-y2 loc-x4-y0))(not (connected loc-x1-y2 loc-x4-y1))(not (connected loc-x1-y2 loc-x4-y2))(not (connected loc-x1-y2 loc-x4-y3))(not (connected loc-x1-y2 loc-x4-y4))(not (connected loc-x1-y3 loc-x0-y0))(not (connected loc-x1-y3 loc-x0-y1))(not (connected loc-x1-y3 loc-x0-y2))(not (connected loc-x1-y3 loc-x0-y4))(not (connected loc-x1-y3 loc-x1-y0))(not (connected loc-x1-y3 loc-x1-y1))(not (connected loc-x1-y3 loc-x1-y3))(not (connected loc-x1-y3 loc-x2-y0))(not (connected loc-x1-y3 loc-x2-y1))(not (connected loc-x1-y3 loc-x2-y2))(not (connected loc-x1-y3 loc-x2-y4))(not (connected loc-x1-y3 loc-x3-y0))(not (connected loc-x1-y3 loc-x3-y1))(not (connected loc-x1-y3 loc-x3-y2))(not (connected loc-x1-y3 loc-x3-y3))(not (connected loc-x1-y3 loc-x3-y4))(not (connected loc-x1-y3 loc-x4-y0))(not (connected loc-x1-y3 loc-x4-y1))(not (connected loc-x1-y3 loc-x4-y2))(not (connected loc-x1-y3 loc-x4-y3))(not (connected loc-x1-y3 loc-x4-y4))(not (connected loc-x1-y4 loc-x0-y0))(not (connected loc-x1-y4 loc-x0-y1))(not (connected loc-x1-y4 loc-x0-y2))(not (connected loc-x1-y4 loc-x0-y3))(not (connected loc-x1-y4 loc-x1-y0))(not (connected loc-x1-y4 loc-x1-y1))(not (connected loc-x1-y4 loc-x1-y2))(not (connected loc-x1-y4 loc-x1-y4))(not (connected loc-x1-y4 loc-x2-y0))(not (connected loc-x1-y4 loc-x2-y1))(not (connected loc-x1-y4 loc-x2-y2))(not (connected loc-x1-y4 loc-x2-y3))(not (connected loc-x1-y4 loc-x3-y0))(not (connected loc-x1-y4 loc-x3-y1))(not (connected loc-x1-y4 loc-x3-y2))(not (connected loc-x1-y4 loc-x3-y3))(not (connected loc-x1-y4 loc-x3-y4))(not (connected loc-x1-y4 loc-x4-y0))(not (connected loc-x1-y4 loc-x4-y1))(not (connected loc-x1-y4 loc-x4-y2))(not (connected loc-x1-y4 loc-x4-y3))(not (connected loc-x1-y4 loc-x4-y4))(not (connected loc-x2-y0 loc-x0-y0))(not (connected loc-x2-y0 loc-x0-y1))(not (connected loc-x2-y0 loc-x0-y2))(not (connected loc-x2-y0 loc-x0-y3))(not (connected loc-x2-y0 loc-x0-y4))(not (connected loc-x2-y0 loc-x1-y1))(not (connected loc-x2-y0 loc-x1-y2))(not (connected loc-x2-y0 loc-x1-y3))(not (connected loc-x2-y0 loc-x1-y4))(not (connected loc-x2-y0 loc-x2-y0))(not (connected loc-x2-y0 loc-x2-y2))(not (connected loc-x2-y0 loc-x2-y3))(not (connected loc-x2-y0 loc-x2-y4))(not (connected loc-x2-y0 loc-x3-y1))(not (connected loc-x2-y0 loc-x3-y2))(not (connected loc-x2-y0 loc-x3-y3))(not (connected loc-x2-y0 loc-x3-y4))(not (connected loc-x2-y0 loc-x4-y0))(not (connected loc-x2-y0 loc-x4-y1))(not (connected loc-x2-y0 loc-x4-y2))(not (connected loc-x2-y0 loc-x4-y3))(not (connected loc-x2-y0 loc-x4-y4))(not (connected loc-x2-y1 loc-x0-y0))(not (connected loc-x2-y1 loc-x0-y1))(not (connected loc-x2-y1 loc-x0-y2))(not (connected loc-x2-y1 loc-x0-y3))(not (connected loc-x2-y1 loc-x0-y4))(not (connected loc-x2-y1 loc-x1-y0))(not (connected loc-x2-y1 loc-x1-y2))(not (connected loc-x2-y1 loc-x1-y3))(not (connected loc-x2-y1 loc-x1-y4))(not (connected loc-x2-y1 loc-x2-y1))(not (connected loc-x2-y1 loc-x2-y3))(not (connected loc-x2-y1 loc-x2-y4))(not (connected loc-x2-y1 loc-x3-y0))(not (connected loc-x2-y1 loc-x3-y2))(not (connected loc-x2-y1 loc-x3-y3))(not (connected loc-x2-y1 loc-x3-y4))(not (connected loc-x2-y1 loc-x4-y0))(not (connected loc-x2-y1 loc-x4-y1))(not (connected loc-x2-y1 loc-x4-y2))(not (connected loc-x2-y1 loc-x4-y3))(not (connected loc-x2-y1 loc-x4-y4))(not (connected loc-x2-y2 loc-x0-y0))(not (connected loc-x2-y2 loc-x0-y1))(not (connected loc-x2-y2 loc-x0-y2))(not (connected loc-x2-y2 loc-x0-y3))(not (connected loc-x2-y2 loc-x0-y4))(not (connected loc-x2-y2 loc-x1-y0))(not (connected loc-x2-y2 loc-x1-y1))(not (connected loc-x2-y2 loc-x1-y3))(not (connected loc-x2-y2 loc-x1-y4))(not (connected loc-x2-y2 loc-x2-y0))(not (connected loc-x2-y2 loc-x2-y2))(not (connected loc-x2-y2 loc-x2-y4))(not (connected loc-x2-y2 loc-x3-y0))(not (connected loc-x2-y2 loc-x3-y1))(not (connected loc-x2-y2 loc-x3-y3))(not (connected loc-x2-y2 loc-x3-y4))(not (connected loc-x2-y2 loc-x4-y0))(not (connected loc-x2-y2 loc-x4-y1))(not (connected loc-x2-y2 loc-x4-y2))(not (connected loc-x2-y2 loc-x4-y3))(not (connected loc-x2-y2 loc-x4-y4))(not (connected loc-x2-y3 loc-x0-y0))(not (connected loc-x2-y3 loc-x0-y1))(not (connected loc-x2-y3 loc-x0-y2))(not (connected loc-x2-y3 loc-x0-y3))(not (connected loc-x2-y3 loc-x0-y4))(not (connected loc-x2-y3 loc-x1-y0))(not (connected loc-x2-y3 loc-x1-y1))(not (connected loc-x2-y3 loc-x1-y2))(not (connected loc-x2-y3 loc-x1-y4))(not (connected loc-x2-y3 loc-x2-y0))(not (connected loc-x2-y3 loc-x2-y1))(not (connected loc-x2-y3 loc-x2-y3))(not (connected loc-x2-y3 loc-x3-y0))(not (connected loc-x2-y3 loc-x3-y1))(not (connected loc-x2-y3 loc-x3-y2))(not (connected loc-x2-y3 loc-x3-y4))(not (connected loc-x2-y3 loc-x4-y0))(not (connected loc-x2-y3 loc-x4-y1))(not (connected loc-x2-y3 loc-x4-y2))(not (connected loc-x2-y3 loc-x4-y3))(not (connected loc-x2-y3 loc-x4-y4))(not (connected loc-x2-y4 loc-x0-y0))(not (connected loc-x2-y4 loc-x0-y1))(not (connected loc-x2-y4 loc-x0-y2))(not (connected loc-x2-y4 loc-x0-y3))(not (connected loc-x2-y4 loc-x0-y4))(not (connected loc-x2-y4 loc-x1-y0))(not (connected loc-x2-y4 loc-x1-y1))(not (connected loc-x2-y4 loc-x1-y2))(not (connected loc-x2-y4 loc-x1-y3))(not (connected loc-x2-y4 loc-x2-y0))(not (connected loc-x2-y4 loc-x2-y1))(not (connected loc-x2-y4 loc-x2-y2))(not (connected loc-x2-y4 loc-x2-y4))(not (connected loc-x2-y4 loc-x3-y0))(not (connected loc-x2-y4 loc-x3-y1))(not (connected loc-x2-y4 loc-x3-y2))(not (connected loc-x2-y4 loc-x3-y3))(not (connected loc-x2-y4 loc-x4-y0))(not (connected loc-x2-y4 loc-x4-y1))(not (connected loc-x2-y4 loc-x4-y2))(not (connected loc-x2-y4 loc-x4-y3))(not (connected loc-x2-y4 loc-x4-y4))(not (connected loc-x3-y0 loc-x0-y0))(not (connected loc-x3-y0 loc-x0-y1))(not (connected loc-x3-y0 loc-x0-y2))(not (connected loc-x3-y0 loc-x0-y3))(not (connected loc-x3-y0 loc-x0-y4))(not (connected loc-x3-y0 loc-x1-y0))(not (connected loc-x3-y0 loc-x1-y1))(not (connected loc-x3-y0 loc-x1-y2))(not (connected loc-x3-y0 loc-x1-y3))(not (connected loc-x3-y0 loc-x1-y4))(not (connected loc-x3-y0 loc-x2-y1))(not (connected loc-x3-y0 loc-x2-y2))(not (connected loc-x3-y0 loc-x2-y3))(not (connected loc-x3-y0 loc-x2-y4))(not (connected loc-x3-y0 loc-x3-y0))(not (connected loc-x3-y0 loc-x3-y2))(not (connected loc-x3-y0 loc-x3-y3))(not (connected loc-x3-y0 loc-x3-y4))(not (connected loc-x3-y0 loc-x4-y1))(not (connected loc-x3-y0 loc-x4-y2))(not (connected loc-x3-y0 loc-x4-y3))(not (connected loc-x3-y0 loc-x4-y4))(not (connected loc-x3-y1 loc-x0-y0))(not (connected loc-x3-y1 loc-x0-y1))(not (connected loc-x3-y1 loc-x0-y2))(not (connected loc-x3-y1 loc-x0-y3))(not (connected loc-x3-y1 loc-x0-y4))(not (connected loc-x3-y1 loc-x1-y0))(not (connected loc-x3-y1 loc-x1-y1))(not (connected loc-x3-y1 loc-x1-y2))(not (connected loc-x3-y1 loc-x1-y3))(not (connected loc-x3-y1 loc-x1-y4))(not (connected loc-x3-y1 loc-x2-y0))(not (connected loc-x3-y1 loc-x2-y2))(not (connected loc-x3-y1 loc-x2-y3))(not (connected loc-x3-y1 loc-x2-y4))(not (connected loc-x3-y1 loc-x3-y1))(not (connected loc-x3-y1 loc-x3-y3))(not (connected loc-x3-y1 loc-x3-y4))(not (connected loc-x3-y1 loc-x4-y0))(not (connected loc-x3-y1 loc-x4-y2))(not (connected loc-x3-y1 loc-x4-y3))(not (connected loc-x3-y1 loc-x4-y4))(not (connected loc-x3-y2 loc-x0-y0))(not (connected loc-x3-y2 loc-x0-y1))(not (connected loc-x3-y2 loc-x0-y2))(not (connected loc-x3-y2 loc-x0-y3))(not (connected loc-x3-y2 loc-x0-y4))(not (connected loc-x3-y2 loc-x1-y0))(not (connected loc-x3-y2 loc-x1-y1))(not (connected loc-x3-y2 loc-x1-y2))(not (connected loc-x3-y2 loc-x1-y3))(not (connected loc-x3-y2 loc-x1-y4))(not (connected loc-x3-y2 loc-x2-y0))(not (connected loc-x3-y2 loc-x2-y1))(not (connected loc-x3-y2 loc-x2-y3))(not (connected loc-x3-y2 loc-x2-y4))(not (connected loc-x3-y2 loc-x3-y0))(not (connected loc-x3-y2 loc-x3-y2))(not (connected loc-x3-y2 loc-x3-y4))(not (connected loc-x3-y2 loc-x4-y0))(not (connected loc-x3-y2 loc-x4-y1))(not (connected loc-x3-y2 loc-x4-y3))(not (connected loc-x3-y2 loc-x4-y4))(not (connected loc-x3-y3 loc-x0-y0))(not (connected loc-x3-y3 loc-x0-y1))(not (connected loc-x3-y3 loc-x0-y2))(not (connected loc-x3-y3 loc-x0-y3))(not (connected loc-x3-y3 loc-x0-y4))(not (connected loc-x3-y3 loc-x1-y0))(not (connected loc-x3-y3 loc-x1-y1))(not (connected loc-x3-y3 loc-x1-y2))(not (connected loc-x3-y3 loc-x1-y3))(not (connected loc-x3-y3 loc-x1-y4))(not (connected loc-x3-y3 loc-x2-y0))(not (connected loc-x3-y3 loc-x2-y1))(not (connected loc-x3-y3 loc-x2-y2))(not (connected loc-x3-y3 loc-x2-y4))(not (connected loc-x3-y3 loc-x3-y0))(not (connected loc-x3-y3 loc-x3-y1))(not (connected loc-x3-y3 loc-x3-y3))(not (connected loc-x3-y3 loc-x4-y0))(not (connected loc-x3-y3 loc-x4-y1))(not (connected loc-x3-y3 loc-x4-y2))(not (connected loc-x3-y3 loc-x4-y4))(not (connected loc-x3-y4 loc-x0-y0))(not (connected loc-x3-y4 loc-x0-y1))(not (connected loc-x3-y4 loc-x0-y2))(not (connected loc-x3-y4 loc-x0-y3))(not (connected loc-x3-y4 loc-x0-y4))(not (connected loc-x3-y4 loc-x1-y0))(not (connected loc-x3-y4 loc-x1-y1))(not (connected loc-x3-y4 loc-x1-y2))(not (connected loc-x3-y4 loc-x1-y3))(not (connected loc-x3-y4 loc-x1-y4))(not (connected loc-x3-y4 loc-x2-y0))(not (connected loc-x3-y4 loc-x2-y1))(not (connected loc-x3-y4 loc-x2-y2))(not (connected loc-x3-y4 loc-x2-y3))(not (connected loc-x3-y4 loc-x3-y0))(not (connected loc-x3-y4 loc-x3-y1))(not (connected loc-x3-y4 loc-x3-y2))(not (connected loc-x3-y4 loc-x3-y4))(not (connected loc-x3-y4 loc-x4-y0))(not (connected loc-x3-y4 loc-x4-y1))(not (connected loc-x3-y4 loc-x4-y2))(not (connected loc-x3-y4 loc-x4-y3))(not (connected loc-x4-y0 loc-x0-y0))(not (connected loc-x4-y0 loc-x0-y1))(not (connected loc-x4-y0 loc-x0-y2))(not (connected loc-x4-y0 loc-x0-y3))(not (connected loc-x4-y0 loc-x0-y4))(not (connected loc-x4-y0 loc-x1-y0))(not (connected loc-x4-y0 loc-x1-y1))(not (connected loc-x4-y0 loc-x1-y2))(not (connected loc-x4-y0 loc-x1-y3))(not (connected loc-x4-y0 loc-x1-y4))(not (connected loc-x4-y0 loc-x2-y0))(not (connected loc-x4-y0 loc-x2-y1))(not (connected loc-x4-y0 loc-x2-y2))(not (connected loc-x4-y0 loc-x2-y3))(not (connected loc-x4-y0 loc-x2-y4))(not (connected loc-x4-y0 loc-x3-y1))(not (connected loc-x4-y0 loc-x3-y2))(not (connected loc-x4-y0 loc-x3-y3))(not (connected loc-x4-y0 loc-x3-y4))(not (connected loc-x4-y0 loc-x4-y0))(not (connected loc-x4-y0 loc-x4-y2))(not (connected loc-x4-y0 loc-x4-y3))(not (connected loc-x4-y0 loc-x4-y4))(not (connected loc-x4-y1 loc-x0-y0))(not (connected loc-x4-y1 loc-x0-y1))(not (connected loc-x4-y1 loc-x0-y2))(not (connected loc-x4-y1 loc-x0-y3))(not (connected loc-x4-y1 loc-x0-y4))(not (connected loc-x4-y1 loc-x1-y0))(not (connected loc-x4-y1 loc-x1-y1))(not (connected loc-x4-y1 loc-x1-y2))(not (connected loc-x4-y1 loc-x1-y3))(not (connected loc-x4-y1 loc-x1-y4))(not (connected loc-x4-y1 loc-x2-y0))(not (connected loc-x4-y1 loc-x2-y1))(not (connected loc-x4-y1 loc-x2-y2))(not (connected loc-x4-y1 loc-x2-y3))(not (connected loc-x4-y1 loc-x2-y4))(not (connected loc-x4-y1 loc-x3-y0))(not (connected loc-x4-y1 loc-x3-y2))(not (connected loc-x4-y1 loc-x3-y3))(not (connected loc-x4-y1 loc-x3-y4))(not (connected loc-x4-y1 loc-x4-y1))(not (connected loc-x4-y1 loc-x4-y3))(not (connected loc-x4-y1 loc-x4-y4))(not (connected loc-x4-y2 loc-x0-y0))(not (connected loc-x4-y2 loc-x0-y1))(not (connected loc-x4-y2 loc-x0-y2))(not (connected loc-x4-y2 loc-x0-y3))(not (connected loc-x4-y2 loc-x0-y4))(not (connected loc-x4-y2 loc-x1-y0))(not (connected loc-x4-y2 loc-x1-y1))(not (connected loc-x4-y2 loc-x1-y2))(not (connected loc-x4-y2 loc-x1-y3))(not (connected loc-x4-y2 loc-x1-y4))(not (connected loc-x4-y2 loc-x2-y0))(not (connected loc-x4-y2 loc-x2-y1))(not (connected loc-x4-y2 loc-x2-y2))(not (connected loc-x4-y2 loc-x2-y3))(not (connected loc-x4-y2 loc-x2-y4))(not (connected loc-x4-y2 loc-x3-y0))(not (connected loc-x4-y2 loc-x3-y1))(not (connected loc-x4-y2 loc-x3-y3))(not (connected loc-x4-y2 loc-x3-y4))(not (connected loc-x4-y2 loc-x4-y0))(not (connected loc-x4-y2 loc-x4-y2))(not (connected loc-x4-y2 loc-x4-y4))(not (connected loc-x4-y3 loc-x0-y0))(not (connected loc-x4-y3 loc-x0-y1))(not (connected loc-x4-y3 loc-x0-y2))(not (connected loc-x4-y3 loc-x0-y3))(not (connected loc-x4-y3 loc-x0-y4))(not (connected loc-x4-y3 loc-x1-y0))(not (connected loc-x4-y3 loc-x1-y1))(not (connected loc-x4-y3 loc-x1-y2))(not (connected loc-x4-y3 loc-x1-y3))(not (connected loc-x4-y3 loc-x1-y4))(not (connected loc-x4-y3 loc-x2-y0))(not (connected loc-x4-y3 loc-x2-y1))(not (connected loc-x4-y3 loc-x2-y2))(not (connected loc-x4-y3 loc-x2-y3))(not (connected loc-x4-y3 loc-x2-y4))(not (connected loc-x4-y3 loc-x3-y0))(not (connected loc-x4-y3 loc-x3-y1))(not (connected loc-x4-y3 loc-x3-y2))(not (connected loc-x4-y3 loc-x3-y4))(not (connected loc-x4-y3 loc-x4-y0))(not (connected loc-x4-y3 loc-x4-y1))(not (connected loc-x4-y3 loc-x4-y3))(not (connected loc-x4-y4 loc-x0-y0))(not (connected loc-x4-y4 loc-x0-y1))(not (connected loc-x4-y4 loc-x0-y2))(not (connected loc-x4-y4 loc-x0-y3))(not (connected loc-x4-y4 loc-x0-y4))(not (connected loc-x4-y4 loc-x1-y0))(not (connected loc-x4-y4 loc-x1-y1))(not (connected loc-x4-y4 loc-x1-y2))(not (connected loc-x4-y4 loc-x1-y3))(not (connected loc-x4-y4 loc-x1-y4))(not (connected loc-x4-y4 loc-x2-y0))(not (connected loc-x4-y4 loc-x2-y1))(not (connected loc-x4-y4 loc-x2-y2))(not (connected loc-x4-y4 loc-x2-y3))(not (connected loc-x4-y4 loc-x2-y4))(not (connected loc-x4-y4 loc-x3-y0))(not (connected loc-x4-y4 loc-x3-y1))(not (connected loc-x4-y4 loc-x3-y2))(not (connected loc-x4-y4 loc-x3-y3))(not (connected loc-x4-y4 loc-x4-y0))(not (connected loc-x4-y4 loc-x4-y1))(not (connected loc-x4-y4 loc-x4-y2))(not (connected loc-x4-y4 loc-x4-y4))(not (at-robot loc-x0-y0))(not (at-robot loc-x0-y1))(not (at-robot loc-x0-y2))(not (at-robot loc-x0-y3))(not (at-robot loc-x0-y4))(not (at-robot loc-x1-y0))(not (at-robot loc-x1-y1))(not (at-robot loc-x1-y2))(not (at-robot loc-x1-y3))(not (at-robot loc-x1-y4))(not (at-robot loc-x2-y0))(not (at-robot loc-x2-y1))(not (at-robot loc-x2-y2))(not (at-robot loc-x2-y3))(not (at-robot loc-x2-y4))(not (at-robot loc-x3-y0))(not (at-robot loc-x3-y1))(not (at-robot loc-x3-y2))(not (at-robot loc-x3-y4))(not (at-robot loc-x4-y0))(not (at-robot loc-x4-y1))(not (at-robot loc-x4-y2))(not (at-robot loc-x4-y3))(not (at-robot loc-x4-y4))(not (visited loc-x1-y0))(not (visited loc-x1-y1))(not (visited loc-x1-y2))(not (visited loc-x1-y3))(not (visited loc-x2-y0))(not (visited loc-x2-y1))(not (visited loc-x2-y2))(not (visited loc-x2-y3))(not (visited loc-x3-y0))(not (visited loc-x3-y1))(not (visited loc-x3-y2))(not (visited loc-x4-y0))(not (visited loc-x4-y1))(not (visited loc-x4-y2))(not (visited loc-x4-y3))(not (visited loc-x4-y4)))))