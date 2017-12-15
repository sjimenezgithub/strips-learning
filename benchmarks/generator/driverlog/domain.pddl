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
  :parameters (?p  - package ?t - truck ?l - location)
  :precondition (and (at ?t ?l) (at ?p ?l))
  :effect (and (not (at ?p ?l)) (in ?p ?t)))

(:action UNLOAD-TRUCK
  :parameters (?p  - package ?t - truck ?l - location)
  :precondition (and (at ?t ?l) (in ?p ?t))
  :effect (and (not (in ?p ?t)) (at ?p ?l)))


(:action BOARD-TRUCK
  :parameters (?d - driver ?t - truck ?l - location)
  :precondition (and (at ?t ?l) (at ?d ?l) (empty ?t))
  :effect (and (not (at ?d ?l)) (driving ?d ?t) (not (empty ?t))))

(:action DISEMBARK-TRUCK
  :parameters (?d - driver ?t - truck ?l - location)
  :precondition (and (at ?t ?l) (driving ?d ?t))
  :effect (and (not (driving ?d ?t)) (at ?d ?l) (empty ?t)))


(:action DRIVE-TRUCK
  :parameters (?t - truck ?from ?to - location ?d - driver)
  :precondition (and (at ?t ?from) (driving ?d ?t) (link ?from ?to))
  :effect (and (not (at ?t ?from)) (at ?t ?to)))

(:action WALK
  :parameters (?from ?to - location ?d - driver)
  :precondition (and (at ?d ?from) (path ?from ?to))
  :effect (and (not (at ?d ?from)) (at ?d ?to)))

)
