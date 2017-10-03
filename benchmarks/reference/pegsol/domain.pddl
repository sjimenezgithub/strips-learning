;; Peg Solitaire sequential domain

(define (domain pegsolitaire-sequential)
    (:requirements :typing )
    (:types location - object)
    (:predicates
        (in-line ?x ?y ?z - location)
        (occupied ?l - location)
        (free ?l - location)
        (move-ended)
        (last-visited ?l - location)
    )
    

    (:action jump-new-move
     :parameters (?o1 - location ?o2 - location ?o3 - location)
     :precondition (and 
                       (move-ended)
                       (in-line ?o1 ?o2 ?o3)
                       (occupied ?o1)
                       (occupied ?o2)
                       (free ?o3)
                   )
     :effect (and
                 (not (move-ended))
                 (not (occupied ?o1))
                 (not (occupied ?o2))
                 (not (free ?o3))
                 (free ?o1)
                 (free ?o2)
                 (occupied ?o3)
                 (last-visited ?o3)
                 
             )
    )

    (:action jump-continue-move
     :parameters (?o1 - location ?o2 - location ?o3 - location)
     :precondition (and 
                       (last-visited ?o1)
                       (in-line ?o1 ?o2 ?o3)
                       (occupied ?o1)
                       (occupied ?o2)
                       (free ?o3)
                   )
     :effect (and
                 (not (occupied ?o1))
                 (not (occupied ?o2))
                 (not (free ?o3))
                 (free ?o1)
                 (free ?o2)
                 (occupied ?o3)
                 (not (last-visited ?o1))
                 (last-visited ?o3)
             )
    )

    (:action end-move
     :parameters (?o1 - location)
     :precondition (last-visited ?o1)
     :effect (and
                 (move-ended)
                 (not (last-visited ?o1))
             )
    )
)
