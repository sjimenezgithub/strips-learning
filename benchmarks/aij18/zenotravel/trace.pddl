(solution 
(:objects person1 -  person person4 -  person fl1 -  flevel fl2 -  flevel plane2 -  aircraft city2 -  city fl3 -  flevel person5 -  person person3 -  person fl0 -  flevel fl4 -  flevel plane1 -  aircraft city0 -  city city1 -  city person2 -  person )
(:init (fuel-level plane2 fl0) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (fuel-level plane1 fl0) (next fl2 fl3) (at plane2 city1) (at person3 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (at person4 city1) )
(:observations (fuel-level plane2 fl0) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (fuel-level plane1 fl0) (next fl2 fl3) (at plane2 city1) (at person3 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (at person4 city1) )

(board person3 plane1 city1)

(:observations (in person3 plane1) (fuel-level plane2 fl0) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (fuel-level plane1 fl0) (next fl2 fl3) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (at person4 city1) )

(board person4 plane1 city1)

(:observations (in person3 plane1) (fuel-level plane2 fl0) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (fuel-level plane1 fl0) (next fl2 fl3) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (in person4 plane1) )

(refuel plane1 city1 fl0 fl1)

(:observations (in person3 plane1) (fuel-level plane2 fl0) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) (in person4 plane1) )

(refuel plane2 city1 fl0 fl1)

(:observations (in person3 plane1) (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl1) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) )

(debark person3 plane1 city1)

(:observations (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (at person3 city1) (next fl2 fl3) (fuel-level plane2 fl1) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) )

(refuel plane1 city1 fl1 fl2)

(:observations (fuel-level plane1 fl2) (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (at person3 city1) (next fl2 fl3) (fuel-level plane2 fl1) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) )

(refuel plane2 city1 fl1 fl2)

(:observations (fuel-level plane1 fl2) (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (at person3 city1) (next fl2 fl3) (fuel-level plane2 fl2) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) )

(board person3 plane2 city1)

(:observations (fuel-level plane1 fl2) (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl2) (at plane2 city1) (next fl3 fl4) (at person2 city0) (at plane1 city1) (in person3 plane2) )

(refuel plane1 city1 fl2 fl3)

(:observations (in person4 plane1) (at person1 city0) (at person5 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl2) (at plane2 city1) (next fl3 fl4) (at person2 city0) (fuel-level plane1 fl3) (at plane1 city1) (in person3 plane2) )

(fly plane2 city1 city2 fl2 fl1)

(:observations (in person4 plane1) (at person1 city0) (at person5 city2) (at plane2 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl1) (next fl3 fl4) (at person2 city0) (fuel-level plane1 fl3) (at plane1 city1) (in person3 plane2) )

(debark person4 plane1 city1)

(:observations (at person1 city0) (at person5 city2) (at plane2 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl1) (at person4 city1) (next fl3 fl4) (at person2 city0) (fuel-level plane1 fl3) (at plane1 city1) (in person3 plane2) )

(refuel plane2 city2 fl1 fl2)

(:observations (at person1 city0) (at person5 city2) (at plane2 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl2) (at person4 city1) (next fl3 fl4) (at person2 city0) (fuel-level plane1 fl3) (at plane1 city1) (in person3 plane2) )

(fly plane1 city1 city0 fl3 fl2)

(:observations (fuel-level plane1 fl2) (at person1 city0) (at person5 city2) (at plane2 city2) (next fl1 fl2) (next fl0 fl1) (next fl2 fl3) (fuel-level plane2 fl2) (at person4 city1) (next fl3 fl4) (at person2 city0) (at plane1 city0) (in person3 plane2) )

(board person1 plane1 city0)

(:observations (fuel-level plane1 fl2) (next fl1 fl2) (in person1 plane1) (in person3 plane2) (at person5 city2) (at plane2 city2) (next fl0 fl1) (fuel-level plane2 fl2) (next fl2 fl3) (at person4 city1) (next fl3 fl4) (at person2 city0) (at plane1 city0) )

(debark person3 plane2 city2)

(:observations (fuel-level plane1 fl2) (at person3 city2) (next fl1 fl2) (in person1 plane1) (at person5 city2) (at plane2 city2) (next fl0 fl1) (fuel-level plane2 fl2) (next fl2 fl3) (at person4 city1) (next fl3 fl4) (at person2 city0) (at plane1 city0) )

(refuel plane2 city2 fl2 fl3)

(:observations (fuel-level plane1 fl2) (next fl1 fl2) (in person1 plane1) (at person5 city2) (at plane2 city2) (next fl0 fl1) (at person3 city2) (next fl2 fl3) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city0) )

(fly plane1 city0 city1 fl2 fl1)

(:observations (next fl1 fl2) (in person1 plane1) (at person5 city2) (at plane2 city2) (next fl0 fl1) (at person3 city2) (next fl2 fl3) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) )

(board person3 plane2 city2)

(:observations (next fl1 fl2) (in person1 plane1) (in person3 plane2) (at person5 city2) (at plane2 city2) (next fl0 fl1) (next fl2 fl3) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) )

(board person5 plane2 city2)

(:observations (next fl1 fl2) (in person1 plane1) (in person3 plane2) (at plane2 city2) (next fl0 fl1) (next fl2 fl3) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) (in person5 plane2) )

(debark person1 plane1 city1)

(:observations (next fl1 fl2) (in person3 plane2) (at plane2 city2) (next fl0 fl1) (next fl2 fl3) (at person1 city1) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city1) (fuel-level plane1 fl1) (in person5 plane2) )

(fly plane1 city1 city2 fl1 fl0)

(:observations (next fl1 fl2) (in person3 plane2) (at plane2 city2) (next fl0 fl1) (fuel-level plane1 fl0) (next fl2 fl3) (at person1 city1) (at person4 city1) (fuel-level plane2 fl3) (next fl3 fl4) (at person2 city0) (at plane1 city2) (in person5 plane2) )

(fly plane2 city2 city0 fl3 fl2)

(:observations (next fl1 fl2) (in person3 plane2) (next fl0 fl1) (fuel-level plane2 fl2) (fuel-level plane1 fl0) (next fl2 fl3) (at person1 city1) (at person4 city1) (next fl3 fl4) (at person2 city0) (at plane1 city2) (at plane2 city0) (in person5 plane2) )

(debark person3 plane2 city0)

(:observations (next fl1 fl2) (next fl0 fl1) (fuel-level plane2 fl2) (fuel-level plane1 fl0) (next fl2 fl3) (at person1 city1) (at person4 city1) (at person3 city0) (next fl3 fl4) (at person2 city0) (at plane1 city2) (at plane2 city0) (in person5 plane2) )

(debark person5 plane2 city0)

(:observations (next fl1 fl2) (next fl0 fl1) (fuel-level plane2 fl2) (fuel-level plane1 fl0) (next fl2 fl3) (at person1 city1) (at person5 city0) (at person4 city1) (at person3 city0) (next fl3 fl4) (at person2 city0) (at plane1 city2) (at plane2 city0) )

(refuel plane1 city2 fl0 fl1)

(:goal (and (next fl1 fl2)(next fl3 fl4)(at person2 city0)(next fl2 fl3)(next fl0 fl1)(at person4 city1)(at person1 city1)(at plane1 city2)(at plane2 city0)(fuel-level plane2 fl2)(at person3 city0)(at person5 city0)(fuel-level plane1 fl1)(not (in person1 plane1))(not (in person1 plane2))(not (in person2 plane1))(not (in person2 plane2))(not (in person3 plane1))(not (in person3 plane2))(not (in person4 plane1))(not (in person4 plane2))(not (in person5 plane1))(not (in person5 plane2))(not (fuel-level plane1 fl0))(not (fuel-level plane1 fl2))(not (fuel-level plane1 fl3))(not (fuel-level plane1 fl4))(not (fuel-level plane2 fl0))(not (fuel-level plane2 fl1))(not (fuel-level plane2 fl3))(not (fuel-level plane2 fl4))(not (next fl0 fl0))(not (next fl0 fl2))(not (next fl0 fl3))(not (next fl0 fl4))(not (next fl1 fl0))(not (next fl1 fl1))(not (next fl1 fl3))(not (next fl1 fl4))(not (next fl2 fl0))(not (next fl2 fl1))(not (next fl2 fl2))(not (next fl2 fl4))(not (next fl3 fl0))(not (next fl3 fl1))(not (next fl3 fl2))(not (next fl3 fl3))(not (next fl4 fl0))(not (next fl4 fl1))(not (next fl4 fl2))(not (next fl4 fl3))(not (next fl4 fl4)))))