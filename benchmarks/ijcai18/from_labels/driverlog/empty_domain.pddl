(define (domain driverlog)
  (:requirements :strips)
  (:types location locatable - object
  	  truck driver package - locatable)

  (:predicates 	(at ?lt - locatable ?loc - location)
		(in ?p - package ?t - truck)
		(driving ?d - driver ?v - truck)
		(link ?x ?y - location) (path ?x ?y - location)
		(empty ?v - truck))
)
