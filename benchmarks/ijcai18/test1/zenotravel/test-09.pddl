(define (problem ztravel-2-5)
  (:domain zeno-travel)
  (:objects person1 -  person plane2 -  aircraft plane1 -  aircraft person2 -  person person4 -  person person3 -  person person5 -  person city0 -  city city1 -  city city2 -  city fl0 -  flevel fl1 -  flevel fl2 -  flevel fl3 -  flevel fl4 -  flevel )
  (:init (at plane1 city1) (next fl0 fl1) (at person2 city0) (next fl3 fl4) (at plane2 city1) (at person5 city2) (at person1 city0) (next fl2 fl3) (next fl1 fl2) (in person4 plane1) (fuel-level plane1 fl2) (fuel-level plane2 fl2) (in person3 plane2) )
  (:goal (and (at plane1 city1)(next fl0 fl1)(at person2 city0)(next fl3 fl4)(at plane2 city1)(at person5 city2)(at person1 city0)(next fl2 fl3)(next fl1 fl2)(in person4 plane1)(fuel-level plane2 fl2)(in person3 plane2)(fuel-level plane1 fl3)(not (in person1 plane1))(not (in person1 plane2))(not (in person2 plane1))(not (in person2 plane2))(not (in person3 plane1))(not (in person4 plane2))(not (in person5 plane1))(not (in person5 plane2))(not (fuel-level plane1 fl0))(not (fuel-level plane1 fl1))(not (fuel-level plane1 fl2))(not (fuel-level plane1 fl4))(not (fuel-level plane2 fl0))(not (fuel-level plane2 fl1))(not (fuel-level plane2 fl3))(not (fuel-level plane2 fl4))(not (next fl0 fl0))(not (next fl0 fl2))(not (next fl0 fl3))(not (next fl0 fl4))(not (next fl1 fl0))(not (next fl1 fl1))(not (next fl1 fl3))(not (next fl1 fl4))(not (next fl2 fl0))(not (next fl2 fl1))(not (next fl2 fl2))(not (next fl2 fl4))(not (next fl3 fl0))(not (next fl3 fl1))(not (next fl3 fl2))(not (next fl3 fl3))(not (next fl4 fl0))(not (next fl4 fl1))(not (next fl4 fl2))(not (next fl4 fl3))(not (next fl4 fl4)))))