(solution 
(:objects driver1 -  driver p2-1 -  location truck1 -  truck package1 -  package driver2 -  driver p0-2 -  location package3 -  package package2 -  package p1-0 -  location truck2 -  truck s2 -  location s0 -  location s1 -  location p0-1 -  location )
(:init (link s0 s1) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (at package1 s2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (path p0-1 s1) )
(:observations (link s0 s1) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (at package1 s2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (path p0-1 s1) )

(load-truck package1 truck2 s2)

(:observations (link s0 s1) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(walk s0 p0-2 driver1)

(:observations (link s0 s1) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (at driver1 p0-2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(walk s0 p0-2 driver2)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (at driver1 p0-2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (at driver2 p0-2) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(walk p0-2 s2 driver1)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (at driver1 s2) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (at driver2 p0-2) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(walk p0-2 s2 driver2)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (at driver1 s2) (at driver2 s2) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(board-truck driver1 truck1 s2)

(:observations (link s0 s1) (driving driver1 truck1) (empty truck2) (path p0-2 s2) (link s2 s0) (at driver2 s2) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(board-truck driver2 truck2 s2)

(:observations (link s0 s1) (driving driver1 truck1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (driving driver2 truck2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (path p0-1 s1) )

(unload-truck package1 truck2 s2)

(:observations (link s0 s1) (driving driver1 truck1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (driving driver2 truck2) (at package1 s2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (at truck1 s2) (at truck2 s2) (path p0-1 s0) (path p0-1 s1) )

(drive-truck truck1 s2 s0 driver1)

(:observations (link s0 s1) (path s2 p2-1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (driving driver2 truck2) (at package1 s2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (driving driver1 truck1) (link s1 s0) (at truck2 s2) (path p0-1 s0) (at truck1 s0) (path p0-1 s1) )

(load-truck package1 truck2 s2)

(:observations (link s0 s1) (path s2 p2-1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (path p0-2 s0) (driving driver2 truck2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (driving driver1 truck1) (link s1 s0) (at truck2 s2) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(drive-truck truck2 s2 s1 driver2)

(:observations (link s0 s1) (driving driver1 truck1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (driving driver2 truck2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (at truck2 s1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(disembark-truck driver1 truck1 s0)

(:observations (link s0 s1) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (driving driver2 truck2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (at truck2 s1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s1) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(load-truck package2 truck2 s1)

(:observations (link s0 s1) (in package2 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (driving driver2 truck2) (path s0 p0-1) (at package3 s1) (path s1 p0-1) (at truck2 s1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(load-truck package3 truck2 s1)

(:observations (link s0 s1) (in package2 truck2) (in package3 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (driving driver2 truck2) (path s0 p0-1) (path s1 p0-1) (at truck2 s1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(drive-truck truck2 s1 s2 driver2)

(:observations (link s0 s1) (in package2 truck2) (in package3 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (at truck2 s2) (driving driver2 truck2) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(unload-truck package2 truck2 s2)

(:observations (link s0 s1) (in package3 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (at driver1 s0) (path s0 p0-2) (path p2-1 s2) (at truck2 s2) (driving driver2 truck2) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(walk s0 p0-1 driver1)

(:observations (link s0 s1) (in package3 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at truck2 s2) (driving driver2 truck2) (at driver1 p0-1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(drive-truck truck2 s2 s0 driver2)

(:observations (link s0 s1) (in package3 truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (driving driver2 truck2) (at driver1 p0-1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(disembark-truck driver2 truck2 s0)

(:observations (link s0 s1) (in package3 truck2) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at driver1 p0-1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(walk p0-1 s1 driver1)

(:observations (link s0 s1) (in package3 truck2) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at driver1 s1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(unload-truck package3 truck2 s0)

(:observations (link s0 s1) (at driver2 s0) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at driver1 s1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (at package3 s0) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) )

(walk s0 p0-1 driver2)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at driver1 s1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (at package3 s0) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) (at driver2 p0-1) )

(walk s1 p2-1 driver1)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at driver1 p2-1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (at package3 s0) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (in package1 truck2) (at truck1 s0) (path p0-1 s1) (at driver2 p0-1) )

(unload-truck package1 truck2 s0)

(:observations (link s0 s1) (empty truck2) (path p0-2 s2) (link s2 s0) (link s2 s1) (path s2 p0-2) (path s0 p0-2) (path p2-1 s2) (at package1 s0) (at driver1 p2-1) (path s0 p0-1) (path s1 p0-1) (empty truck1) (at package3 s0) (path s1 p2-1) (at truck2 s0) (link s0 s2) (link s1 s2) (path p2-1 s1) (at package2 s2) (path s2 p2-1) (link s1 s0) (path p0-2 s0) (path p0-1 s0) (at truck1 s0) (path p0-1 s1) (at driver2 p0-1) )

(walk p0-1 s1 driver2)

(:goal (and (link s1 s2)(path s1 p0-1)(path p0-1 s1)(link s0 s2)(path s0 p0-1)(path s0 p0-2)(path p2-1 s1)(path s2 p0-2)(path s2 p2-1)(path p2-1 s2)(link s2 s0)(path p0-2 s2)(link s0 s1)(link s1 s0)(link s2 s1)(path s1 p2-1)(path p0-2 s0)(path p0-1 s0)(at truck1 s0)(empty truck1)(at package2 s2)(at truck2 s0)(empty truck2)(at package3 s0)(at driver1 p2-1)(at package1 s0)(at driver2 s1)(not (in package1 truck1))(not (in package1 truck2))(not (in package2 truck1))(not (in package2 truck2))(not (in package3 truck1))(not (in package3 truck2))(not (driving driver1 truck1))(not (driving driver1 truck2))(not (driving driver2 truck1))(not (driving driver2 truck2))(not (link s0 s0))(not (link s0 p0-1))(not (link s0 p0-2))(not (link s0 p1-0))(not (link s0 p2-1))(not (link s1 s1))(not (link s1 p0-1))(not (link s1 p0-2))(not (link s1 p1-0))(not (link s1 p2-1))(not (link s2 s2))(not (link s2 p0-1))(not (link s2 p0-2))(not (link s2 p1-0))(not (link s2 p2-1))(not (link p0-1 s0))(not (link p0-1 s1))(not (link p0-1 s2))(not (link p0-1 p0-1))(not (link p0-1 p0-2))(not (link p0-1 p1-0))(not (link p0-1 p2-1))(not (link p0-2 s0))(not (link p0-2 s1))(not (link p0-2 s2))(not (link p0-2 p0-1))(not (link p0-2 p0-2))(not (link p0-2 p1-0))(not (link p0-2 p2-1))(not (link p1-0 s0))(not (link p1-0 s1))(not (link p1-0 s2))(not (link p1-0 p0-1))(not (link p1-0 p0-2))(not (link p1-0 p1-0))(not (link p1-0 p2-1))(not (link p2-1 s0))(not (link p2-1 s1))(not (link p2-1 s2))(not (link p2-1 p0-1))(not (link p2-1 p0-2))(not (link p2-1 p1-0))(not (link p2-1 p2-1))(not (path s0 s0))(not (path s0 s1))(not (path s0 s2))(not (path s0 p1-0))(not (path s0 p2-1))(not (path s1 s0))(not (path s1 s1))(not (path s1 s2))(not (path s1 p0-2))(not (path s1 p1-0))(not (path s2 s0))(not (path s2 s1))(not (path s2 s2))(not (path s2 p0-1))(not (path s2 p1-0))(not (path p0-1 s2))(not (path p0-1 p0-1))(not (path p0-1 p0-2))(not (path p0-1 p1-0))(not (path p0-1 p2-1))(not (path p0-2 s1))(not (path p0-2 p0-1))(not (path p0-2 p0-2))(not (path p0-2 p1-0))(not (path p0-2 p2-1))(not (path p1-0 s0))(not (path p1-0 s1))(not (path p1-0 s2))(not (path p1-0 p0-1))(not (path p1-0 p0-2))(not (path p1-0 p1-0))(not (path p1-0 p2-1))(not (path p2-1 s0))(not (path p2-1 p0-1))(not (path p2-1 p0-2))(not (path p2-1 p1-0))(not (path p2-1 p2-1)))))