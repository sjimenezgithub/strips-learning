(define (domain S5-O3)    ;;; S5-O3-REGULAR-DET-0
  (:requirements :strips)
  (:predicates (head ?x)
               (next ?x1 ?x2)
               (stateS0) (stateS1) (stateS2) (stateS3) (stateS4)
               (symbolO0 ?x) (symbolO1 ?x) (symbolO2 ?x))

(:action update-rule-S0-O0
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS0) (symbolO0 ?x1))
  :effect (and (not (head ?x1)) (not (stateS0))
               (head ?x2) (stateS0)))

(:action update-rule-S0-O1
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS0) (symbolO1 ?x1))
  :effect (and (not (head ?x1)) (not (stateS0))
               (head ?x2) (stateS0)))

(:action update-rule-S0-O2
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS0) (symbolO2 ?x1))
  :effect (and (not (head ?x1)) (not (stateS0))
               (head ?x2) (stateS0)))

(:action update-rule-S1-O0
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS1) (symbolO0 ?x1))
  :effect (and (not (head ?x1)) (not (stateS1))
               (head ?x2) (stateS0)))

(:action update-rule-S1-O1
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS1) (symbolO1 ?x1))
  :effect (and (not (head ?x1)) (not (stateS1))
               (head ?x2) (stateS0)))

(:action update-rule-S1-O2
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS1) (symbolO2 ?x1))
  :effect (and (not (head ?x1)) (not (stateS1))
               (head ?x2) (stateS0)))

(:action update-rule-S2-O0
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS2) (symbolO0 ?x1))
  :effect (and (not (head ?x1)) (not (stateS2))
               (head ?x2) (stateS0)))

(:action update-rule-S2-O1
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS2) (symbolO1 ?x1))
  :effect (and (not (head ?x1)) (not (stateS2))
               (head ?x2) (stateS0)))

(:action update-rule-S2-O2
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS2) (symbolO2 ?x1))
  :effect (and (not (head ?x1)) (not (stateS2))
               (head ?x2) (stateS0)))

(:action update-rule-S3-O0
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS3) (symbolO0 ?x1))
  :effect (and (not (head ?x1)) (not (stateS3))
               (head ?x2) (stateS0)))

(:action update-rule-S3-O1
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS3) (symbolO1 ?x1))
  :effect (and (not (head ?x1)) (not (stateS3))
               (head ?x2) (stateS0)))

(:action update-rule-S3-O2
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS3) (symbolO2 ?x1))
  :effect (and (not (head ?x1)) (not (stateS3))
               (head ?x2) (stateS0)))

(:action update-rule-S4-O0
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS4) (symbolO0 ?x1))
  :effect (and (not (head ?x1)) (not (stateS4))
               (head ?x2) (stateS0)))

(:action update-rule-S4-O1
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS4) (symbolO1 ?x1))
  :effect (and (not (head ?x1)) (not (stateS4))
               (head ?x2) (stateS0)))

(:action update-rule-S4-O2
  :parameters (?x1 ?x2)
  :precondition (and (head ?x1) (next ?x1 ?x2) (stateS4) (symbolO2 ?x1))
  :effect (and (not (head ?x1)) (not (stateS4))
               (head ?x2) (stateS0)))

)
