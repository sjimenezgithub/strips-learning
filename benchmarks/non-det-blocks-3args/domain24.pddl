;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Non-deterministic blocks world 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain BLOCKS)
  (:requirements :strips)
  (:predicates (on ?x ?y)
	       (ontable ?x)
	       (clear ?x)
	       (handempty)
	       (holding ?x)
	       )


;;; Deterministic actions, stack y unstack require now (ontable ?y)

  (:action pick-up
	     :parameters (?x)
	     :precondition (and (clear ?x) (ontable ?x) (handempty))
	     :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))

  (:action put-down
	     :parameters (?x)
	     :precondition (holding ?x)
	     :effect (and (not (holding ?x)) (clear ?x) (handempty) (ontable ?x)))
	     
  (:action stack
	     :parameters (?x ?y)
	     :precondition (and (holding ?x) (clear ?y) (ontable ?y))
	     :effect (and (not (holding ?x)) (not (clear ?y)) (clear ?x) (handempty) (on ?x ?y)))
	     
  (:action unstack
	     :parameters (?x ?y)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty) (ontable ?y))
	     :effect (and (holding ?x) (clear ?y) (not (clear ?x)) (not (handempty)) (not (on ?x ?y))))

;;; Actions corresponding to non-deterministic effects

  (:action stack-ok
	     :parameters (?x ?y ?z)
	     :precondition (and (holding ?x) (clear ?y) (on ?y ?z))
	     :effect (and (not (holding ?x)) (not (clear ?y)) (clear ?x) (handempty) (on ?x ?y)))

  (:action unstack-ok
	     :parameters (?x ?y ?z)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty) (on ?y ?z))
	     :effect (and (holding ?x) (clear ?y) (not (clear ?x)) (not (handempty)) (not (on ?x ?y))))

  (:action stack-fail2
	     :parameters (?x ?y ?z)
	     :precondition (and (holding ?x) (clear ?y) (on ?y ?z))
	     :effect (and (not (on ?y ?z)) (clear ?z) (ontable ?y)))

  (:action unstack-fail4
	     :parameters (?x ?y ?z)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty) (on ?y ?z))
	     :effect (and (not (on ?x ?y)) (ontable ?x) (not (on ?y ?z)) (clear ?y) (ontable ?y) (clear ?z)))


)