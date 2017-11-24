(define (domain movie-strips)
  (:predicates (movie-rewound)
               (counter-at-two-hours)
	       (counter-at-other-than-two-hours)
               (counter-at-zero)
               (have-chips)
               (have-dip)
               (have-pop)
               (have-cheese)
               (have-crackers)
               (chips ?o1)
               (dip ?o1)
               (pop ?o1)
               (cheese ?o1)
               (crackers ?o1))
  
  (:action rewind-movie-2
           :parameters ()
	   :precondition (counter-at-two-hours)
           :effect (movie-rewound))
  
  (:action get-pop
           :parameters (?o1)
           :precondition (pop ?o1)
           :effect (have-pop))
  
  (:action get-cheese
           :parameters (?o1)
           :precondition (cheese ?o1)
           :effect (have-cheese))
  
  (:action get-crackers
           :parameters (?o1)
           :precondition (crackers ?o1)
           :effect (have-crackers)))