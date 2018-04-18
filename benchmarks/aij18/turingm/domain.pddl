;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Wolfram's 2-state_3-symbol_Turing_Machine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain 2_3_TM)
  (:requirements :strips)
  (:predicates (head ?x)
  	       (next ?x1 ?x2)
	       (symbol0 ?x)
	       (symbol1 ?x)
	       (symbol2 ?x)	       
	       (stateA)
	       (stateB)
	       )

(:action update-rule1 ;;; 0,A/1,R,B
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol0 ?x) (stateA))
    :effect (and (not (head ?x)) (not (symbol0 ?x)) (not (stateA))
                 (symbol1 ?x) (head ?xr) (stateB)))

(:action update-rule2 ;;; Update 0,B/2,L,A
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol0 ?x) (stateB))
    :effect (and (not (head ?x)) (not (symbol0 ?x)) (not (stateB))
                 (symbol2 ?x) (head ?xl) (stateA)))


(:action update-rule3 ;;; Update 1,A/2,L,A
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol1 ?x) (stateA))
    :effect (and (not (head ?x)) (not (symbol1 ?x)) (not (stateA))
                 (symbol2 ?x) (head ?xl)  (stateA)))


(:action update-rule4 ;;; Update 1,B/2,R,B
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol1 ?x) (stateB))
    :effect (and (not (head ?x)) (not (symbol1 ?x)) (not (stateB))
    	    	 (symbol2 ?x) (head ?xr) (stateB)))


(:action update-rule5 ;;; Update 2,A/1,L,A
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol2 ?x) (stateA))
    :effect (and (not (head ?x)) (not (symbol2 ?x)) (not (stateA))
                 (symbol1 ?x) (head ?xl) (stateA)))


(:action update-rule6 ;;; Update 2,B/0,R,A
    :parameters (?xl ?x ?xr)
    :precondition (and (head ?x) (next ?xl ?x) (next ?x ?xr) (symbol2 ?x) (stateB))
    :effect (and (not (head ?x)) (not (symbol2 ?x)) (not (stateB))
                 (symbol0 ?x) (head ?xr) (stateA)))
)