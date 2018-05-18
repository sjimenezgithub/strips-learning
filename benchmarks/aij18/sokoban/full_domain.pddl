(define (domain sokoban-sequential)
  (:requirements :typing )
  (:types player stone - thing
  	  thing location direction - object
          )
  (:predicates (clear ?l - location)
	       (at ?t - thing ?l - location)
	       (at-goal ?s - stone)
	       (IS-GOAL ?l - location)
	       (IS-NONGOAL ?l - location)
               (MOVE-DIR ?from ?to - location ?dir - direction))
  

  (:action move
   :parameters (?o1 - player ?o2 ?o3 - location ?o4 - direction)
   :precondition (and (at ?o1 ?o2)
                      (clear ?o3)
                      (MOVE-DIR ?o2 ?o3 ?o4)
                      )
   :effect       (and (not (at ?o1 ?o2))
                      (not (clear ?o3))
                      (at ?o1 ?o3)
                      (clear ?o2)
                      )
   )

  (:action push-to-nongoal
   :parameters (?o1 - player ?o2 - stone
                ?o3 ?o4 ?o5 - location
                ?o6 - direction)
   :precondition (and (at ?o1 ?o3)
                      (at ?o2 ?o4)
                      (clear ?o5)
                      (MOVE-DIR ?o3 ?o4 ?o6)
                      (MOVE-DIR ?o4 ?o5 ?o6)
                      (IS-NONGOAL ?o5)
                      )
   :effect       (and (not (at ?o1 ?o3))
                      (not (at ?o2 ?o4))
                      (not (clear ?o5))
                      (at ?o1 ?o4)
                      (at ?o2 ?o5)
                      (clear ?o3)
                      (not (at-goal ?o2))                      
                      )
   )

  (:action push-to-goal
   :parameters (?o1 - player ?o2 - stone
                ?o3 ?o4 ?o5 - location
                ?o6 - direction)
   :precondition (and (at ?o1 ?o3)
                      (at ?o2 ?o4)
                      (clear ?o5)
                      (MOVE-DIR ?o3 ?o4 ?o6)
                      (MOVE-DIR ?o4 ?o5 ?o6)
                      (IS-GOAL ?o5)
                      )
   :effect       (and (not (at ?o1 ?o3))
                      (not (at ?o2 ?o4))
                      (not (clear ?o5))
                      (at ?o1 ?o4)
                      (at ?o2 ?o5)
                      (clear ?o3)
                      (at-goal ?o2)                      
                      )
   )
)
