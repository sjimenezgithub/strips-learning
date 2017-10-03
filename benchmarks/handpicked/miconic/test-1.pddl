(define (problem mixed-f10-p5-u0-v0-g0-a0-n0-A0-B0-N0-F0-r4)
   (:domain miconic)
   (:objects p0 p1 p2 p3 p4 - person
             f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 - floor)

(:init
(above f0 f1)
(above f0 f2)
(above f0 f3)
(above f0 f4)
(above f0 f5)
(above f0 f6)
(above f0 f7)
(above f0 f8)
(above f0 f9)

(above f1 f2)
(above f1 f3)
(above f1 f4)
(above f1 f5)
(above f1 f6)
(above f1 f7)
(above f1 f8)
(above f1 f9)

(above f2 f3)
(above f2 f4)
(above f2 f5)
(above f2 f6)
(above f2 f7)
(above f2 f8)
(above f2 f9)

(above f3 f4)
(above f3 f5)
(above f3 f6)
(above f3 f7)
(above f3 f8)
(above f3 f9)

(above f4 f5)
(above f4 f6)
(above f4 f7)
(above f4 f8)
(above f4 f9)

(above f5 f6)
(above f5 f7)
(above f5 f8)
(above f5 f9)

(above f6 f7)
(above f6 f8)
(above f6 f9)

(above f7 f8)
(above f7 f9)

(above f8 f9)

(origin p0 f5)
(destin p0 f1)

(origin p1 f2)
(destin p1 f0)

(origin p2 f2)
(destin p2 f8)

(origin p3 f7)
(destin p3 f5)

(origin p4 f9)
(destin p4 f4)

(lift-at f0)
)


(:goal (and

(above f0 f1)
(above f0 f2)
(above f0 f3)
(above f0 f4)
(above f0 f5)
(above f0 f6)
(above f0 f7)
(above f0 f8)
(above f0 f9)

(above f1 f2)
(above f1 f3)
(above f1 f4)
(above f1 f5)
(above f1 f6)
(above f1 f7)
(above f1 f8)
(above f1 f9)

(above f2 f3)
(above f2 f4)
(above f2 f5)
(above f2 f6)
(above f2 f7)
(above f2 f8)
(above f2 f9)

(above f3 f4)
(above f3 f5)
(above f3 f6)
(above f3 f7)
(above f3 f8)
(above f3 f9)

(above f4 f5)
(above f4 f6)
(above f4 f7)
(above f4 f8)
(above f4 f9)

(above f5 f6)
(above f5 f7)
(above f5 f8)
(above f5 f9)

(above f6 f7)
(above f6 f8)
(above f6 f9)

(above f7 f8)
(above f7 f9)

(above f8 f9)

(not (above p0 p0)) (not (above p0 p1)) (not (above p0 p2)) (not (above p0 p3)) (not (above p0 p4)) (not (above p0 f0)) (not (above p0 f1)) (not (above p0 f2)) (not (above p0 f3)) (not (above p0 f4)) (not (above p0 f5)) (not (above p0 f6)) (not (above p0 f7)) (not (above p0 f8)) (not (above p0 f9)) (not (above p1 p0)) (not (above p1 p1)) (not (above p1 p2)) (not (above p1 p3)) (not (above p1 p4)) (not (above p1 f0)) (not (above p1 f1)) (not (above p1 f2)) (not (above p1 f3)) (not (above p1 f4)) (not (above p1 f5)) (not (above p1 f6)) (not (above p1 f7)) (not (above p1 f8)) (not (above p1 f9)) (not (above p2 p0)) (not (above p2 p1)) (not (above p2 p2)) (not (above p2 p3)) (not (above p2 p4)) (not (above p2 f0)) (not (above p2 f1)) (not (above p2 f2)) (not (above p2 f3)) (not (above p2 f4)) (not (above p2 f5)) (not (above p2 f6)) (not (above p2 f7)) (not (above p2 f8)) (not (above p2 f9)) (not (above p3 p0)) (not (above p3 p1)) (not (above p3 p2)) (not (above p3 p3)) (not (above p3 p4)) (not (above p3 f0)) (not (above p3 f1)) (not (above p3 f2)) (not (above p3 f3)) (not (above p3 f4)) (not (above p3 f5)) (not (above p3 f6)) (not (above p3 f7)) (not (above p3 f8)) (not (above p3 f9)) (not (above p4 p0)) (not (above p4 p1)) (not (above p4 p2)) (not (above p4 p3)) (not (above p4 p4)) (not (above p4 f0)) (not (above p4 f1)) (not (above p4 f2)) (not (above p4 f3)) (not (above p4 f4)) (not (above p4 f5)) (not (above p4 f6)) (not (above p4 f7)) (not (above p4 f8)) (not (above p4 f9)) (not (above f0 p0)) (not (above f0 p1)) (not (above f0 p2)) (not (above f0 p3)) (not (above f0 p4)) (not (above f0 f0)) (not (above f1 p0)) (not (above f1 p1)) (not (above f1 p2)) (not (above f1 p3)) (not (above f1 p4)) (not (above f1 f0)) (not (above f1 f1)) (not (above f2 p0)) (not (above f2 p1)) (not (above f2 p2)) (not (above f2 p3)) (not (above f2 p4)) (not (above f2 f0)) (not (above f2 f1)) (not (above f2 f2)) (not (above f3 p0)) (not (above f3 p1)) (not (above f3 p2)) (not (above f3 p3)) (not (above f3 p4)) (not (above f3 f0)) (not (above f3 f1)) (not (above f3 f2)) (not (above f3 f3)) (not (above f4 p0)) (not (above f4 p1)) (not (above f4 p2)) (not (above f4 p3)) (not (above f4 p4)) (not (above f4 f0)) (not (above f4 f1)) (not (above f4 f2)) (not (above f4 f3)) (not (above f4 f4)) (not (above f5 p0)) (not (above f5 p1)) (not (above f5 p2)) (not (above f5 p3)) (not (above f5 p4)) (not (above f5 f0)) (not (above f5 f1)) (not (above f5 f2)) (not (above f5 f3)) (not (above f5 f4)) (not (above f5 f5)) (not (above f6 p0)) (not (above f6 p1)) (not (above f6 p2)) (not (above f6 p3)) (not (above f6 p4)) (not (above f6 f0)) (not (above f6 f1)) (not (above f6 f2)) (not (above f6 f3)) (not (above f6 f4)) (not (above f6 f5)) (not (above f6 f6)) (not (above f7 p0)) (not (above f7 p1)) (not (above f7 p2)) (not (above f7 p3)) (not (above f7 p4)) (not (above f7 f0)) (not (above f7 f1)) (not (above f7 f2)) (not (above f7 f3)) (not (above f7 f4)) (not (above f7 f5)) (not (above f7 f6)) (not (above f7 f7)) (not (above f8 p0)) (not (above f8 p1)) (not (above f8 p2)) (not (above f8 p3)) (not (above f8 p4)) (not (above f8 f0)) (not (above f8 f1)) (not (above f8 f2)) (not (above f8 f3)) (not (above f8 f4)) (not (above f8 f5)) (not (above f8 f6)) (not (above f8 f7)) (not (above f8 f8)) (not (above f9 p0)) (not (above f9 p1)) (not (above f9 p2)) (not (above f9 p3)) (not (above f9 p4)) (not (above f9 f0)) (not (above f9 f1)) (not (above f9 f2)) (not (above f9 f3)) (not (above f9 f4)) (not (above f9 f5)) (not (above f9 f6)) (not (above f9 f7)) (not (above f9 f8)) (not (above f9 f9))


(origin p0 f5)
(destin p0 f1)

(origin p1 f2)
(destin p1 f0)

(origin p2 f2)
(destin p2 f8)

(origin p3 f7)
(destin p3 f5)

(origin p4 f9)
(destin p4 f4)

(not (boarded p0))
(not (boarded p1))
(not (boarded p2))
(not (boarded p3))
(not (boarded p4))

(not (served p0))
(not (served p1))
(not (served p2))
(not (served p3))
(not (served p4))

(not (lift-at f0))
(not (lift-at f1))
(not (lift-at f2))
(not (lift-at f3))
(not (lift-at f4))
(not (lift-at f5))
(lift-at f6)
(not (lift-at f7))
(not (lift-at f8))
(not (lift-at f9))
)))


