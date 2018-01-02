(define (domain parking)
 (:requirements :strips :typing)
 (:types car curb)
 (:predicates 
    (at-curb ?car - car) 
    (at-curb-num ?car - car ?curb - curb)
    (behind-car ?car ?front-car - car)
    (car-clear ?car - car) 
    (curb-clear ?curb - curb)
 )


)
