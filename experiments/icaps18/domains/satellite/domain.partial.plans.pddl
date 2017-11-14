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

 (:action turn-to
   :parameters (?o1 - object ?o2 - object ?o3 - object)
   :precondition (pointing ?o1 ?o3)
   :effect (and (pointing ?o1 ?o2)(not (pointing ?o1 ?o3))))

 (:action switch-on
   :parameters (?o1 - object ?o2 - object)
   :precondition (and (on-board ?o1 ?o2)(power-avail ?o2))
   :effect (and (power-on ?o1)(not (calibrated ?o1))(not (power-avail ?o2))))

 (:action calibrate
   :parameters (?o1 - object ?o2 - object ?o3 - object)
   :precondition (and (on-board ?o2 ?o1)(calibration-target ?o2 ?o3)(pointing ?o1 ?o3)(power-on ?o2))
   :effect (and (calibrated ?o2)))

)