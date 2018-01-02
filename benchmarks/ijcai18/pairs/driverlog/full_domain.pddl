(define (domain driverlog)
  (:requirements :strips)
  (:types location locatable - object
  	  truck driver package - locatable)

  (:predicates 	(at ?lt - locatable ?loc - location)
		(in ?p - package ?t - truck)
		(driving ?d - driver ?v - truck)
		(link ?x ?y - location) (path ?x ?y - location)
		(empty ?v - truck))


(:action LOAD-TRUCK
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at ?o2 ?o3) (at ?o1 ?o3))
  :effect (and (not (at ?o1 ?o3)) (in ?o1 ?o2)))

(:action UNLOAD-TRUCK
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at ?o2 ?o3) (in ?o1 ?o2))
  :effect (and (not (in ?o1 ?o2)) (at ?o1 ?o3)))


(:action BOARD-TRUCK
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at ?o2 ?o3) (at ?o1 ?o3) (empty ?o2))
  :effect (and (not (at ?o1 ?o3)) (driving ?o1 ?o2) (not (empty ?o2))))

(:action DISEMBARK-TRUCK
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at ?o2 ?o3) (driving ?o1 ?o2))
  :effect (and (not (driving ?o1 ?o2)) (at ?o1 ?o3) (empty ?o2)))


(:action DRIVE-TRUCK
  :parameters (?o1 ?o2 ?o3 ?o4)
  :precondition (and (at ?o1 ?o2) (driving ?o4 ?o1) (link ?o2 ?o3))
  :effect (and (not (at ?o1 ?o2)) (at ?o1 ?o3)))

(:action WALK
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at ?o3 ?o1) (path ?o1 ?o2))
  :effect (and (not (at ?o3 ?o1)) (at ?o3 ?o2)))

)
