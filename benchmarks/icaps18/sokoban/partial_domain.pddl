(define (domain sokoban-sequential)
  (:requirements :typing )
  (:types thing location direction - object
          player stone - thing)
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
)
