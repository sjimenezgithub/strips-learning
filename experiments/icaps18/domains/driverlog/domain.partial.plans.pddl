(define (domain driverlog)
 (:requirements :strips)
 (:types object - None location - object locatable - object truck - locatable driver - locatable package - locatable )
 (:predicates (at ?lt - locatable ?loc - location)(in ?p - package ?t - truck)(driving ?d - driver ?v - truck)(link ?x - location ?y - location)(path ?x - location ?y - location)(empty ?v - truck))

 (:action unload-truck
   :parameters (?o1 - package ?o2 - truck ?o3 - location)
   :precondition (and (in ?o1 ?o2))
   :effect (and (not (in ?o1 ?o2))(at ?o1 ?o3)))

 (:action board-truck
   :parameters (?o1 - driver ?o2 - truck ?o3 - location)
   :precondition (and (at ?o1 ?o3)(empty ?o2))
   :effect (and (not (at ?o1 ?o3))(not (empty ?o2))(driving ?o1 ?o2)))

 (:action walk
   :parameters (?o1 - location ?o2 - location ?o3 - driver)
   :precondition (and (path ?o1 ?o2)(at ?o3 ?o1))
   :effect (and (not (at ?o3 ?o1))(at ?o3 ?o2)))

 (:action load-truck
   :parameters (?o1 - object ?o2 - object ?o3 - object)
   :precondition (and (at ?o2 ?o3)(at ?o1 ?o3))
   :effect (and (not (at ?o1 ?o3))(in ?o1 ?o2)))

 (:action disembark-truck
   :parameters (?o1 - object ?o2 - object ?o3 - object)
   :precondition (and (at ?o2 ?o3)(driving ?o1 ?o2))
   :effect (and (not (driving ?o1 ?o2))(at ?o1 ?o3)(empty ?o2)))

 (:action drive-truck
   :parameters (?o1 - object ?o2 - object ?o3 - object ?o4 - object)
   :precondition (and (at ?o1 ?o2)(driving ?o4 ?o1)(link ?o2 ?o3))
   :effect (and (not (at ?o1 ?o2))(at ?o1 ?o3)))

)