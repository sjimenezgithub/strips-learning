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
)