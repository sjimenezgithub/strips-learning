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

(:action unlock
  :parameters (?o1 - place ?o2 - place ?o3 - key ?o4 - shape)
  :precondition (and (conn ?o1 ?o2)
  		     (key-shape ?o3 ?o4)
		     (lock-shape ?o2 ?o4)
		     (at-robot ?o1)
		     (locked ?o2)
		     (holding ?o3))
  :effect (and  (open ?o2)
  	  	(not (locked ?o2))))

(:action move
  :parameters (?o1 - place ?o2 - place)
  :precondition (and (at-robot ?o1)
  		     (conn ?o1 ?o2)
		     (open ?o2))
  :effect (and (at-robot ?o2)
  	       (not (at-robot ?o1))))

(:action pickup
  :parameters (?o1 - place ?o2 - key)
  :precondition (and (at-robot ?o1)
  		     (at ?o2 ?o1)
		     (arm-empty))
  :effect (and (holding ?o2)
  	       (not (at ?o2 ?o1))
	       (not (arm-empty))))


(:action pickup-and-loose
  :parameters (?o1 - place ?o2 - key ?o3 - key)
  :precondition (and (at-robot ?o1)
  		     (holding ?o3)
		     (at ?o2 ?o1))
  :effect (and (holding ?o2)
  	       (at ?o3 ?o1)
               (not (holding ?o3))
	       (not (at ?o2 ?o1))))

(:action putdown
  :parameters (?o1 - place ?o2 - key)
  :precondition (and (at-robot ?o1)
  		     (holding ?o2))
  :effect (and (arm-empty)
  	       (at ?o2 ?o1)
	       (not (holding ?o2)))))


	
