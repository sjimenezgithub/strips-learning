(define (domain ferry)
(:types car location - object)
   (:predicates (not-eq ?x ?y - object)
		(at-ferry ?l - location)
		(at ?c - car ?l - location)
		(empty-ferry)
		(on ?c - car))

   (:action sail
       :parameters  (?o1 - location ?o2 - location)
       :precondition (and (not-eq ?o1 ?o2) (at-ferry ?o1))
       :effect (and  (at-ferry ?o2)
		     (not (at-ferry ?o1))))

   (:action board
       :parameters (?o1 - car ?o2 - location)
       :precondition  (and  (at ?o1 ?o2) (at-ferry ?o2) (empty-ferry))
       :effect (and (on ?o1)
		    (not (at ?o1 ?o2)) 
		    (not (empty-ferry))))

   (:action debark
       :parameters  (?o1 - car ?o2 - location)
       :precondition  (and  (on ?o1) (at-ferry ?o2))
       :effect (and (at ?o1 ?o2)
		    (empty-ferry)
		    (not (on ?o1)))))
