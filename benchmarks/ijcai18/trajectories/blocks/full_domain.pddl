;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4 Op-blocks world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain BLOCKS)
  (:requirements :strips)
  (:predicates (on ?o1 ?o2)
	       (ontable ?o1)
	       (clear ?o1)
	       (handempty)
	       (holding ?o1)
	       )

  (:action pick-up
	     :parameters (?o1)
	     :precondition (and (clear ?o1) (ontable ?o1) (handempty))
	     :effect
	     (and (not (ontable ?o1))
		   (not (clear ?o1))
		   (not (handempty))
		   (holding ?o1)))

  (:action put-down
	     :parameters (?o1)
	     :precondition (and (holding ?o1))
	     :effect
	     (and (not (holding ?o1))
		   (clear ?o1)
		   (handempty)
		   (ontable ?o1)))
  (:action stack
	     :parameters (?o1 ?o2)
	     :precondition (and (holding ?o1) (clear ?o2))
	     :effect
	     (and (not (holding ?o1))
		   (not (clear ?o2))
		   (clear ?o1)
		   (handempty)
		   (on ?o1 ?o2)))
  (:action unstack
	     :parameters (?o1 ?o2)
	     :precondition (and (on ?o1 ?o2) (clear ?o1) (handempty))
	     :effect
	     (and (holding ?o1)
		   (clear ?o2)
		   (not (clear ?o1))
		   (not (handempty))
		   (not (on ?o1 ?o2)))))
