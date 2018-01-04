; Transport city-sequential-9nodes-1000size-3degree-100mindistance-2trucks-4packages-2008seed

(define (problem transport-city-sequential-9nodes-1000size-3degree-100mindistance-2trucks-4packages-2008seed)
 (:domain transport)
 (:objects
  city-loc-1 - location
  city-loc-2 - location
  city-loc-3 - location
  city-loc-4 - location
  city-loc-5 - location
  city-loc-6 - location
  city-loc-7 - location
  city-loc-8 - location
  city-loc-9 - location
  truck-1 - vehicle
  truck-2 - vehicle
  package-1 - package
  package-2 - package
  package-3 - package
  package-4 - package
  capacity-0 - capacity-number
  capacity-1 - capacity-number
  capacity-2 - capacity-number
  capacity-3 - capacity-number
  capacity-4 - capacity-number
 )
 (:init  
  (capacity-predecessor capacity-0 capacity-1)
  (capacity-predecessor capacity-1 capacity-2)
  (capacity-predecessor capacity-2 capacity-3)
  (capacity-predecessor capacity-3 capacity-4)
  (road city-loc-3 city-loc-1)
  (road city-loc-1 city-loc-3)
  (road city-loc-4 city-loc-1)
  (road city-loc-1 city-loc-4)
  (road city-loc-5 city-loc-1)
  (road city-loc-1 city-loc-5)
  (road city-loc-5 city-loc-4)
  (road city-loc-4 city-loc-5)
  (road city-loc-6 city-loc-2)
  (road city-loc-2 city-loc-6)
  (road city-loc-6 city-loc-3)
  (road city-loc-3 city-loc-6)
  (road city-loc-7 city-loc-1)
  (road city-loc-1 city-loc-7)
  (road city-loc-7 city-loc-3)
  (road city-loc-3 city-loc-7)
  (road city-loc-7 city-loc-4)
  (road city-loc-4 city-loc-7)
  (road city-loc-8 city-loc-4)
  (road city-loc-4 city-loc-8)
  (road city-loc-8 city-loc-7)
  (road city-loc-7 city-loc-8)
  (road city-loc-9 city-loc-2)
  (road city-loc-2 city-loc-9)
  (road city-loc-9 city-loc-6)
  (road city-loc-6 city-loc-9)
  (at package-1 city-loc-6)
  (at package-2 city-loc-5)
  (at package-3 city-loc-6)
  (at package-4 city-loc-6)
  (at truck-1 city-loc-6)
  (capacity truck-1 capacity-2)
  (at truck-2 city-loc-9)
  (capacity truck-2 capacity-4)
 )
 (:goal (and
  (at package-1 city-loc-9)
  (at package-2 city-loc-3)
  (at package-3 city-loc-1)
  (at package-4 city-loc-8)
 ))
 
)
