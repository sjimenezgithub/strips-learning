(define (domain grid)
(:requirements :strips)
(:types place key shape)
(:predicates (conn ?x ?y - place)
             (key-shape ?k - key ?s - shape)
             (lock-shape ?p - place ?s - shape)
             (at ?k - key ?p - place)
	     (at-robot ?p - place)
             (locked ?p - place)
	     (open ?p - place)
             (holding ?k - key)             
             (arm-empty))


(:action pickup-and-loose
  :parameters (?o1 ?o2 ?o3)
  :precondition (and (at-robot ?o1)
  		     (holding ?o3)
		     (at ?o2 ?o1))
  :effect (and (holding ?o2)
  	       (at ?o3 ?o1)
               (not (holding ?o3))
	       (not (at ?o2 ?o1))))

(:action putdown
  :parameters (?o1 ?o2)
  :precondition (and (at-robot ?o1)
  		     (holding ?o2))
  :effect (and (arm-empty)
  	       (at ?o2 ?o1)
	       (not (holding ?o2)))))


	
