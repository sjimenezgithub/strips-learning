(define (problem transport-city-sequential-9nodes-1000size-3degree-100mindistance-2trucks-4packages-2008seed)
  (:domain transport)
  (:objects city-loc-6 -  location city-loc-2 -  location city-loc-4 -  location city-loc-3 -  location city-loc-5 -  location city-loc-1 -  location truck-1 -  vehicle package-1 -  package package-2 -  package package-3 -  package package-4 -  package package-5 -  package capacity-0 -  capacity-number capacity-1 -  capacity-number capacity-2 -  capacity-number )
  (:init (road city-loc-4 city-loc-1) (road city-loc-1 city-loc-3) (capacity-predecessor capacity-0 capacity-1) (road city-loc-5 city-loc-4) (road city-loc-1 city-loc-5) (at package-4 city-loc-1) (at package-1 city-loc-3) (road city-loc-4 city-loc-5) (road city-loc-3 city-loc-1) (road city-loc-5 city-loc-1) (road city-loc-1 city-loc-4) (road city-loc-6 city-loc-2) (capacity-predecessor capacity-1 capacity-2) (road city-loc-6 city-loc-3) (road city-loc-2 city-loc-6) (road city-loc-3 city-loc-6) (at package-3 city-loc-6) (in package-5 truck-1) (at package-2 city-loc-2) (capacity truck-1 capacity-1) (at truck-1 city-loc-6) )
  (:goal (and (road city-loc-4 city-loc-1)(road city-loc-1 city-loc-3)(capacity-predecessor capacity-0 capacity-1)(road city-loc-5 city-loc-4)(road city-loc-1 city-loc-5)(at package-4 city-loc-1)(at package-1 city-loc-3)(road city-loc-4 city-loc-5)(road city-loc-3 city-loc-1)(road city-loc-5 city-loc-1)(road city-loc-1 city-loc-4)(road city-loc-6 city-loc-2)(capacity-predecessor capacity-1 capacity-2)(road city-loc-6 city-loc-3)(road city-loc-2 city-loc-6)(road city-loc-3 city-loc-6)(at package-3 city-loc-6)(at package-2 city-loc-2)(at truck-1 city-loc-6)(at package-5 city-loc-6)(capacity truck-1 capacity-2)(not (road city-loc-1 city-loc-1))(not (road city-loc-1 city-loc-2))(not (road city-loc-1 city-loc-6))(not (road city-loc-2 city-loc-1))(not (road city-loc-2 city-loc-2))(not (road city-loc-2 city-loc-3))(not (road city-loc-2 city-loc-4))(not (road city-loc-2 city-loc-5))(not (road city-loc-3 city-loc-2))(not (road city-loc-3 city-loc-3))(not (road city-loc-3 city-loc-4))(not (road city-loc-3 city-loc-5))(not (road city-loc-4 city-loc-2))(not (road city-loc-4 city-loc-3))(not (road city-loc-4 city-loc-4))(not (road city-loc-4 city-loc-6))(not (road city-loc-5 city-loc-2))(not (road city-loc-5 city-loc-3))(not (road city-loc-5 city-loc-5))(not (road city-loc-5 city-loc-6))(not (road city-loc-6 city-loc-1))(not (road city-loc-6 city-loc-4))(not (road city-loc-6 city-loc-5))(not (road city-loc-6 city-loc-6))(not (in package-1 truck-1))(not (in package-2 truck-1))(not (in package-3 truck-1))(not (in package-4 truck-1))(not (in package-5 truck-1))(not (capacity truck-1 capacity-0))(not (capacity truck-1 capacity-1))(not (capacity-predecessor capacity-0 capacity-0))(not (capacity-predecessor capacity-0 capacity-2))(not (capacity-predecessor capacity-1 capacity-0))(not (capacity-predecessor capacity-1 capacity-1))(not (capacity-predecessor capacity-2 capacity-0))(not (capacity-predecessor capacity-2 capacity-1))(not (capacity-predecessor capacity-2 capacity-2)))))