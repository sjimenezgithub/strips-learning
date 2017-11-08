(define (domain miconic)
  (:requirements :strips)
  (:types floor person)

(:predicates
  (origin ?p - person ?f - floor)
  (destin ?p - person ?f - floor)  
  (above ?f1 ?f2 - floor)
  (boarded ?p - person)
  (served ?p - person)
  (lift-at ?f - floor)
)
)