(define (domain satellite)
 (:requirements :equality :strips)
 (:types object - None satellite - object direction - object instrument - object mode - object )
 (:predicates (on-board ?i - instrument ?s - satellite)(supports ?i - instrument ?m - mode)(pointing ?s - satellite ?d - direction)(power-avail ?s - satellite)(power-on ?i - instrument)(calibrated ?i - instrument)(have-image ?d - direction ?m - mode)(calibration-target ?i - instrument ?d - direction))

 (:action switch-off
   :parameters (?o1 - instrument ?o2 - satellite)
   :precondition (and (on-board ?o1 ?o2)(power-on ?o1))
   :effect (and (not (power-on ?o1))(power-avail ?o2)))

 (:action take-image
   :parameters (?o1 - satellite ?o2 - direction ?o3 - instrument ?o4 - mode)
   :precondition (and (on-board ?o3 ?o1)(supports ?o3 ?o4))
   :effect (and (have-image ?o2 ?o4)))

 (:action calibrate
   :parameters (?o1 - satellite ?o2 - instrument ?o3 - direction)
   :precondition (and (on-board ?o2 ?o1)(calibration-target ?o2 ?o3)(calibrated ?o1)(calibrated ?o3)(calibrated ?o1))
   :effect (and (calibrated ?o2)))

 (:action turn-to
   :parameters (?o1 - satellite ?o2 - direction ?o3 - direction)
   :precondition (and (pointing ?o1 ?o3))
   :effect (and (not (pointing ?o1 ?o3))(pointing ?o1 ?o2)))

 (:action switch-on
   :parameters (?o1 - instrument ?o2 - satellite)
   :precondition (and (on-board ?o1 ?o2)(power-avail ?o2))
   :effect (and (not (power-avail ?o2))(power-on ?o1)))

)