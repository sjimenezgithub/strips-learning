;  (c) 2001 Copyright (c) University of Huddersfield
;  Automatically produced from GIPO from the domain hiking
;  All rights reserved. Use of this software is permitted for non-commercial
;  research purposes, and it may be copied only for that use.  All copies must
;  include this copyright message.  This software is made available AS IS, and
;  neither the GIPO team nor the University of Huddersfield make any warranty about
;  the software or its performance.

(define (domain hiking)
  (:requirements :strips :equality :typing)
  (:types car tent person couple place )
  (:predicates 
              (at-tent ?o1 - tent ?o2 - place)
              (at-person ?o1 - person ?o2 - place)
              (at-car ?o1 - car ?o2 - place)
              (partners ?o1 - couple ?o2 - person ?o3 - person)
              (up ?o1 - tent)
              (down ?o1 - tent)
              (walked ?o1 - couple ?o2 - place)
              (next ?o1 - place ?o2 - place))

  (:action put-down
         :parameters ( ?o1 - person ?o2 - place ?o3 - tent)
         :precondition (and (at-person ?o1 ?o2)(at-tent ?o3 ?o2)(up ?o3))
         :effect (and (down ?o3)(not (up ?o3))))
	 
  (:action put-up
         :parameters ( ?o1 - person ?o2 - place ?o3 - tent)
         :precondition (and (at-person ?o1 ?o2)(at-tent ?o3 ?o2)(down ?o3))
         :effect (and (up ?o3)(not (down ?o3))))
	 
  (:action drive-passenger
         :parameters ( ?o1 - person ?o2 - place ?o3 - place ?o4 - car ?o5 - person)
         :precondition (and (at-person ?o1 ?o2)(at-car ?o4 ?o2)(at-person ?o5 ?o2)(not (= ?o1 ?o5)))
         :effect (and (at-person ?o1 ?o3)(not (at-person ?o1 ?o2))(at-car ?o4 ?o3)(not (at-car ?o4 ?o2))(at-person ?o5 ?o3)(not (at-person ?o5 ?o2))))
)

