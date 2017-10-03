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
)
