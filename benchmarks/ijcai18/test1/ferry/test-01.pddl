(define (problem ferry-l10-c9)
  (:domain ferry)
  (:objects l1 -  location l0 -  location l2 -  location l4 -  location l3 -  location l5 -  location l6 -  location l7 -  location l8 -  location l9 -  location c0 -  car c1 -  car c2 -  car c3 -  car c4 -  car c5 -  car c6 -  car c7 -  car c8 -  car )
  (:init (not-eq l5 l4) (not-eq l7 l9) (not-eq l2 l5) (not-eq l0 l2) (not-eq l8 l5) (not-eq l3 l9) (not-eq l0 l9) (not-eq l5 l1) (not-eq l8 l9) (not-eq l6 l5) (not-eq l9 l6) (not-eq l8 l2) (not-eq l3 l8) (at c4 l2) (not-eq l8 l0) (not-eq l4 l1) (not-eq l1 l5) (at-ferry l3) (at c2 l3) (not-eq l1 l9) (not-eq l2 l4) (not-eq l3 l1) (not-eq l8 l3) (not-eq l7 l5) (not-eq l7 l6) (not-eq l5 l8) (not-eq l9 l5) (at c6 l1) (not-eq l4 l8) (not-eq l2 l6) (at c8 l1) (not-eq l6 l2) (not-eq l0 l5) (not-eq l3 l2) (not-eq l5 l6) (not-eq l1 l3) (not-eq l2 l0) (not-eq l3 l7) (not-eq l6 l3) (at c1 l5) (not-eq l9 l4) (not-eq l7 l3) (not-eq l4 l3) (not-eq l7 l8) (not-eq l6 l8) (not-eq l9 l3) (not-eq l7 l1) (not-eq l1 l2) (not-eq l2 l3) (at c0 l5) (not-eq l5 l0) (not-eq l6 l9) (not-eq l8 l6) (not-eq l8 l1) (not-eq l0 l8) (not-eq l6 l1) (not-eq l1 l8) (not-eq l6 l4) (not-eq l3 l0) (not-eq l7 l4) (not-eq l4 l9) (not-eq l1 l0) (not-eq l4 l5) (at c3 l3) (empty-ferry ) (not-eq l9 l1) (not-eq l0 l3) (not-eq l2 l8) (not-eq l5 l3) (not-eq l7 l2) (not-eq l2 l1) (not-eq l0 l1) (not-eq l3 l6) (not-eq l5 l9) (not-eq l9 l2) (not-eq l0 l4) (not-eq l2 l9) (not-eq l5 l2) (not-eq l6 l0) (not-eq l1 l7) (not-eq l1 l4) (not-eq l8 l4) (not-eq l4 l7) (not-eq l4 l2) (not-eq l9 l7) (not-eq l8 l7) (not-eq l1 l6) (not-eq l2 l7) (at c7 l1) (not-eq l4 l0) (not-eq l0 l6) (not-eq l3 l5) (at c5 l2) (not-eq l6 l7) (not-eq l9 l0) (not-eq l0 l7) (not-eq l3 l4) (not-eq l5 l7) (not-eq l7 l0) (not-eq l4 l6) (not-eq l9 l8) )
  (:goal (and (not-eq l5 l4)(not-eq l7 l9)(not-eq l2 l5)(not-eq l0 l2)(not-eq l8 l5)(not-eq l3 l9)(not-eq l0 l9)(not-eq l5 l1)(not-eq l8 l9)(not-eq l6 l5)(not-eq l9 l6)(not-eq l8 l2)(not-eq l3 l8)(at c4 l2)(not-eq l8 l0)(not-eq l4 l1)(not-eq l1 l5)(at-ferry l3)(not-eq l1 l9)(not-eq l2 l4)(not-eq l3 l1)(not-eq l8 l3)(not-eq l7 l5)(not-eq l7 l6)(not-eq l5 l8)(not-eq l9 l5)(at c6 l1)(not-eq l4 l8)(not-eq l2 l6)(at c8 l1)(not-eq l6 l2)(not-eq l0 l5)(not-eq l3 l2)(not-eq l5 l6)(not-eq l1 l3)(not-eq l2 l0)(not-eq l3 l7)(not-eq l6 l3)(at c1 l5)(not-eq l9 l4)(not-eq l7 l3)(not-eq l4 l3)(not-eq l7 l8)(not-eq l6 l8)(not-eq l9 l3)(not-eq l7 l1)(not-eq l1 l2)(not-eq l2 l3)(at c0 l5)(not-eq l5 l0)(not-eq l6 l9)(not-eq l8 l6)(not-eq l8 l1)(not-eq l0 l8)(not-eq l6 l1)(not-eq l1 l8)(not-eq l6 l4)(not-eq l3 l0)(not-eq l7 l4)(not-eq l4 l9)(not-eq l1 l0)(not-eq l4 l5)(at c3 l3)(not-eq l9 l1)(not-eq l0 l3)(not-eq l2 l8)(not-eq l5 l3)(not-eq l7 l2)(not-eq l2 l1)(not-eq l0 l1)(not-eq l3 l6)(not-eq l5 l9)(not-eq l9 l2)(not-eq l0 l4)(not-eq l2 l9)(not-eq l5 l2)(not-eq l6 l0)(not-eq l1 l7)(not-eq l1 l4)(not-eq l8 l4)(not-eq l4 l7)(not-eq l4 l2)(not-eq l9 l7)(not-eq l8 l7)(not-eq l1 l6)(not-eq l2 l7)(at c7 l1)(not-eq l4 l0)(not-eq l0 l6)(not-eq l3 l5)(at c5 l2)(not-eq l6 l7)(not-eq l9 l0)(not-eq l0 l7)(not-eq l3 l4)(not-eq l5 l7)(not-eq l7 l0)(not-eq l4 l6)(not-eq l9 l8)(on c2)(not (at-ferry l0))(not (at-ferry l1))(not (at-ferry l2))(not (at-ferry l4))(not (at-ferry l5))(not (at-ferry l6))(not (at-ferry l7))(not (at-ferry l8))(not (at-ferry l9))(not (at c0 l0))(not (at c0 l1))(not (at c0 l2))(not (at c0 l3))(not (at c0 l4))(not (at c0 l6))(not (at c0 l7))(not (at c0 l8))(not (at c0 l9))(not (at c1 l0))(not (at c1 l1))(not (at c1 l2))(not (at c1 l3))(not (at c1 l4))(not (at c1 l6))(not (at c1 l7))(not (at c1 l8))(not (at c1 l9))(not (at c2 l0))(not (at c2 l1))(not (at c2 l2))(not (at c2 l3))(not (at c2 l4))(not (at c2 l5))(not (at c2 l6))(not (at c2 l7))(not (at c2 l8))(not (at c2 l9))(not (at c3 l0))(not (at c3 l1))(not (at c3 l2))(not (at c3 l4))(not (at c3 l5))(not (at c3 l6))(not (at c3 l7))(not (at c3 l8))(not (at c3 l9))(not (at c4 l0))(not (at c4 l1))(not (at c4 l3))(not (at c4 l4))(not (at c4 l5))(not (at c4 l6))(not (at c4 l7))(not (at c4 l8))(not (at c4 l9))(not (at c5 l0))(not (at c5 l1))(not (at c5 l3))(not (at c5 l4))(not (at c5 l5))(not (at c5 l6))(not (at c5 l7))(not (at c5 l8))(not (at c5 l9))(not (at c6 l0))(not (at c6 l2))(not (at c6 l3))(not (at c6 l4))(not (at c6 l5))(not (at c6 l6))(not (at c6 l7))(not (at c6 l8))(not (at c6 l9))(not (at c7 l0))(not (at c7 l2))(not (at c7 l3))(not (at c7 l4))(not (at c7 l5))(not (at c7 l6))(not (at c7 l7))(not (at c7 l8))(not (at c7 l9))(not (at c8 l0))(not (at c8 l2))(not (at c8 l3))(not (at c8 l4))(not (at c8 l5))(not (at c8 l6))(not (at c8 l7))(not (at c8 l8))(not (at c8 l9))(not (empty-ferry ))(not (on c0))(not (on c1))(not (on c3))(not (on c4))(not (on c5))(not (on c6))(not (on c7))(not (on c8)))))