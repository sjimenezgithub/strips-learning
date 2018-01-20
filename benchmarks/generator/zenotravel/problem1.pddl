(define (problem ZTRAVEL-2-5)
(:domain zeno-travel)
(:objects
	plane1 plane2 - aircraft
	person1
	person2
	person3
	person4	
	person5 - person
	city0
	city1
	city2 - city
	fl0
	fl1
	fl2
	fl3
	fl4 - flevel
	)
(:init
	(at plane1 city1)
	(fuel-level plane1 fl0)
	(at plane2 city1)
	(fuel-level plane2 fl0)
	(at person1 city0)	
	(at person2 city0)
	(at person3 city1)
	(at person4 city1)
	(at person5 city2)
	(next fl0 fl1)
	(next fl1 fl2)
	(next fl2 fl3)
	(next fl3 fl4)
)
(:goal (and
	(at plane1 city2)
	(at plane2 city2)
	(fuel-level plane1 fl2)
	(fuel-level plane2 fl2)
	(at person1 city1)
	(at person2 city0)
	(at person3 city0)
	(at person4 city1)
	(at person5 city0)
	))

)
