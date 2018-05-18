(solution 
(:objects city-loc-5 -  location truck-1 -  vehicle capacity-0 -  capacity-number package-3 -  package package-4 -  package city-loc-4 -  location package-5 -  package package-1 -  package city-loc-1 -  location city-loc-6 -  location city-loc-3 -  location package-2 -  package city-loc-2 -  location capacity-2 -  capacity-number capacity-1 -  capacity-number )
(:init (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-1) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at package-4 city-loc-6) )
(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-1) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at package-4 city-loc-6) )

(pick-up truck-1 city-loc-6 package-4 capacity-1 capacity-2)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (road city-loc-5 city-loc-1) )

(drive truck-1 city-loc-6 city-loc-3)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at truck-1 city-loc-3) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (road city-loc-5 city-loc-1) )

(drop truck-1 city-loc-3 package-4 capacity-1 capacity-2)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at truck-1 city-loc-3) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (road city-loc-5 city-loc-1) )

(drive truck-1 city-loc-3 city-loc-1)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (at package-3 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at truck-1 city-loc-1) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (road city-loc-5 city-loc-1) )

(pick-up truck-1 city-loc-1 package-3 capacity-1 capacity-2)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (capacity truck-1 capacity-1) (in package-3 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at truck-1 city-loc-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-1 city-loc-3)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (in package-3 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(pick-up truck-1 city-loc-3 package-4 capacity-0 capacity-1)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (in package-3 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (capacity truck-1 capacity-0) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(drive truck-1 city-loc-3 city-loc-6)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (in package-3 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (capacity truck-1 capacity-0) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drop truck-1 city-loc-6 package-3 capacity-0 capacity-1)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (at package-3 city-loc-6) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-6 city-loc-3)

(:observations (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (in package-4 truck-1) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (at package-3 city-loc-6) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(drop truck-1 city-loc-3 package-4 capacity-1 capacity-2)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (at package-3 city-loc-6) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(drive truck-1 city-loc-3 city-loc-1)

(:observations (at package-4 city-loc-3) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-3) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (at package-3 city-loc-6) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at truck-1 city-loc-1) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (at package-1 city-loc-1) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(pick-up truck-1 city-loc-1 package-1 capacity-1 capacity-2)

(:observations (at package-4 city-loc-3) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-5) (capacity truck-1 capacity-1) (road city-loc-5 city-loc-4) (in package-1 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at truck-1 city-loc-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-1 city-loc-3)

(:observations (at package-4 city-loc-3) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (in package-1 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(drive truck-1 city-loc-3 city-loc-6)

(:observations (at package-4 city-loc-3) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (road city-loc-1 city-loc-5) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (in package-1 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drop truck-1 city-loc-6 package-1 capacity-1 capacity-2)

(:observations (at package-4 city-loc-3) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (at truck-1 city-loc-6) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-6 city-loc-3)

(:observations (at package-4 city-loc-3) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-2) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(pick-up truck-1 city-loc-3 package-4 capacity-1 capacity-2)

(:observations (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (in package-4 truck-1) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) (at truck-1 city-loc-3) )

(drive truck-1 city-loc-3 city-loc-1)

(:observations (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (in package-4 truck-1) (road city-loc-5 city-loc-4) (at truck-1 city-loc-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-1 city-loc-4)

(:observations (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (in package-4 truck-1) (at truck-1 city-loc-4) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at package-5 city-loc-4) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(pick-up truck-1 city-loc-4 package-5 capacity-0 capacity-1)

(:observations (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (in package-4 truck-1) (at truck-1 city-loc-4) (road city-loc-5 city-loc-4) (in package-5 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-0) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drop truck-1 city-loc-4 package-4 capacity-0 capacity-1)

(:observations (at package-4 city-loc-4) (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (at truck-1 city-loc-4) (road city-loc-5 city-loc-4) (in package-5 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-4 city-loc-1)

(:observations (at package-3 city-loc-6) (road city-loc-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (at package-4 city-loc-4) (road city-loc-5 city-loc-4) (in package-5 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (at package-2 city-loc-1) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (capacity truck-1 capacity-1) (at truck-1 city-loc-1) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(pick-up truck-1 city-loc-1 package-2 capacity-0 capacity-1)

(:observations (in package-2 truck-1) (at package-3 city-loc-6) (at package-1 city-loc-6) (road city-loc-1 city-loc-5) (at package-4 city-loc-4) (road city-loc-5 city-loc-4) (in package-5 truck-1) (road city-loc-1 city-loc-4) (road city-loc-5 city-loc-1) (road city-loc-3 city-loc-6) (road city-loc-2 city-loc-6) (capacity-predecessor capacity-1 capacity-2) (road city-loc-4 city-loc-5) (at truck-1 city-loc-1) (road city-loc-6 city-loc-3) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-0 capacity-1) (capacity truck-1 capacity-0) (road city-loc-1 city-loc-3) (road city-loc-3 city-loc-1) (road city-loc-4 city-loc-1) )

(drive truck-1 city-loc-1 city-loc-3)

(:goal (and (road city-loc-1 city-loc-4)(capacity-predecessor capacity-0 capacity-1)(capacity-predecessor capacity-1 capacity-2)(road city-loc-6 city-loc-3)(road city-loc-2 city-loc-6)(road city-loc-4 city-loc-1)(road city-loc-1 city-loc-3)(road city-loc-6 city-loc-2)(road city-loc-5 city-loc-4)(road city-loc-1 city-loc-5)(road city-loc-3 city-loc-6)(road city-loc-4 city-loc-5)(road city-loc-3 city-loc-1)(road city-loc-5 city-loc-1)(at package-3 city-loc-6)(at package-1 city-loc-6)(in package-5 truck-1)(at package-4 city-loc-4)(in package-2 truck-1)(capacity truck-1 capacity-0)(at truck-1 city-loc-3)(not (road city-loc-1 city-loc-1))(not (road city-loc-1 city-loc-2))(not (road city-loc-1 city-loc-6))(not (road city-loc-2 city-loc-1))(not (road city-loc-2 city-loc-2))(not (road city-loc-2 city-loc-3))(not (road city-loc-2 city-loc-4))(not (road city-loc-2 city-loc-5))(not (road city-loc-3 city-loc-2))(not (road city-loc-3 city-loc-3))(not (road city-loc-3 city-loc-4))(not (road city-loc-3 city-loc-5))(not (road city-loc-4 city-loc-2))(not (road city-loc-4 city-loc-3))(not (road city-loc-4 city-loc-4))(not (road city-loc-4 city-loc-6))(not (road city-loc-5 city-loc-2))(not (road city-loc-5 city-loc-3))(not (road city-loc-5 city-loc-5))(not (road city-loc-5 city-loc-6))(not (road city-loc-6 city-loc-1))(not (road city-loc-6 city-loc-4))(not (road city-loc-6 city-loc-5))(not (road city-loc-6 city-loc-6))(not (in package-1 truck-1))(not (in package-3 truck-1))(not (in package-4 truck-1))(not (capacity truck-1 capacity-1))(not (capacity truck-1 capacity-2))(not (capacity-predecessor capacity-0 capacity-0))(not (capacity-predecessor capacity-0 capacity-2))(not (capacity-predecessor capacity-1 capacity-0))(not (capacity-predecessor capacity-1 capacity-1))(not (capacity-predecessor capacity-2 capacity-0))(not (capacity-predecessor capacity-2 capacity-1))(not (capacity-predecessor capacity-2 capacity-2)))))