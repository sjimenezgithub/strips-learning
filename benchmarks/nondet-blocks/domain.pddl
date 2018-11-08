;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Non-deterministic blocks world 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain BLOCKS)
  (:requirements :strips)
  (:predicates (on ?x ?y)
	       (ontable ?x)
	       (clear ?x)
	       (handempty)
	       (holding ?x))


;;; Original Actions

  (:action pick-up
	     :parameters (?x)
	     :precondition (and (clear ?x) (ontable ?x) (handempty))
	     :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))

  (:action put-down
	     :parameters (?x)
	     :precondition (holding ?x)
	     :effect (and (not (holding ?x)) (clear ?x) (handempty) (ontable ?x)))

  (:action stack-ok
	     :parameters (?x ?y)
	     :precondition (and (holding ?x) (clear ?y))
	     :effect (and (not (holding ?x)) (not (clear ?y)) (clear ?x) (handempty) (on ?x ?y)))

  (:action unstack-ok
	     :parameters (?x ?y)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty))
	     :effect (and (holding ?x) (clear ?y) (not (clear ?x)) (not (handempty)) (not (on ?x ?y))))


;;; Actions corresponding to failures (non-deterministic effects) 
  (:action stack-fail0
	     :parameters (?x ?y)
	     :precondition (and (holding ?x) (clear ?y))
	     :effect (and ))

  (:action stack-fail1
	     :parameters (?x ?y)
	     :precondition (and (holding ?x) (clear ?y))
	     :effect (and (not (holding ?x)) (clear ?x) (handempty) (ontable ?x)))

  (:action unstack-fail0
	     :parameters (?x ?y)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty))
	     :effect (and ))

  (:action unstack-fail1
	     :parameters (?x ?y)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty))
	     :effect (and (clear ?y) (ontable ?x) (not (on ?x ?y))))
	     
)
	     