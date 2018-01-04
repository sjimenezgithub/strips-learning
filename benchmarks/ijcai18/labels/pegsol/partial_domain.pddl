;; Peg Solitaire sequential domain

(define (domain pegsolitaire-sequential)
    (:requirements)
    (:predicates
        (IN-LINE ?x ?y ?z)
        (occupied ?l)
        (free ?l)
        (move-ended)
        (last-visited ?l)
    )

    (:action jump-new-move
     :parameters (?o1 ?o2 ?o3)
     :precondition (and 
                       (move-ended)
                       (IN-LINE ?o1 ?o2 ?o3)
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
)