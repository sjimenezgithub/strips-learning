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
               (chips ?x)
               (dip ?x)
               (pop ?x)
               (cheese ?x)
               (crackers ?x))
  
  (:action rewind-movie-2
           :parameters ()
	   :precondition (counter-at-two-hours)
           :effect (movie-rewound))
  
  (:action rewind-movie
           :parameters ()
	   :precondition (counter-at-other-than-two-hours)
           :effect (and (movie-rewound)
                        ;; Let's assume that the movie is 2 hours long
                        (not (counter-at-zero))))

  (:action reset-counter
           :parameters ()
           :precondition (and)
           :effect (counter-at-zero))


  ;;; Get the food and snacks for the movie
  (:action get-chips
           :parameters (?o1)
           :precondition (chips ?o1)
           :effect (have-chips))
  
  (:action get-dip
           :parameters (?o1)
           :precondition (dip ?o1)
           :effect (have-dip))

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