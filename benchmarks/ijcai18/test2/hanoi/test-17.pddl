(define (problem hanoi-5)
  (:domain hanoi)
  (:objects d2 -  object peg1 -  object peg2 -  object peg3 -  object d1 -  object d3 -  object d4 -  object d5 -  object )
  (:init (smaller d4 d3) (smaller peg3 d4) (smaller peg3 d2) (smaller d4 d2) (smaller peg3 d3) (clear d1) (smaller d2 d1) (smaller peg3 d1) (smaller d5 d3) (smaller peg1 d2) (smaller peg2 d2) (smaller d2 d2) (smaller peg2 d1) (smaller d1 d1) (smaller peg2 d3) (smaller peg2 d5) (smaller d5 d4) (smaller peg2 d4) (on d5 peg3) (smaller d5 d1) (smaller d3 d2) (smaller peg1 d4) (smaller peg1 d3) (smaller d5 d2) (smaller d3 d3) (smaller peg1 d5) (smaller peg3 d5) (smaller peg1 d1) (smaller d4 d4) (smaller d4 d1) (smaller d3 d1) (on d4 peg2) (on d2 d5) (on d3 d4) (clear d3) (clear d2) (on d1 peg1) )
  (:goal (and (smaller d4 d3)(smaller peg3 d4)(smaller peg3 d2)(smaller d4 d2)(smaller peg3 d3)(clear d1)(smaller d2 d1)(smaller peg3 d1)(smaller d5 d3)(smaller peg1 d2)(smaller peg2 d2)(smaller d2 d2)(smaller peg2 d1)(smaller d1 d1)(smaller peg2 d3)(smaller peg2 d5)(smaller d5 d4)(smaller peg2 d4)(on d5 peg3)(smaller d5 d1)(smaller d3 d2)(smaller peg1 d4)(smaller peg1 d3)(smaller d5 d2)(smaller d3 d3)(smaller peg1 d5)(smaller peg3 d5)(smaller peg1 d1)(smaller d4 d4)(smaller d4 d1)(smaller d3 d1)(on d4 peg2)(on d3 d4)(clear d2)(on d1 peg1)(clear d5)(on d2 d3)(not (clear peg1))(not (clear peg2))(not (clear peg3))(not (clear d3))(not (clear d4))(not (on peg1 peg1))(not (on peg1 peg2))(not (on peg1 peg3))(not (on peg1 d1))(not (on peg1 d2))(not (on peg1 d3))(not (on peg1 d4))(not (on peg1 d5))(not (on peg2 peg1))(not (on peg2 peg2))(not (on peg2 peg3))(not (on peg2 d1))(not (on peg2 d2))(not (on peg2 d3))(not (on peg2 d4))(not (on peg2 d5))(not (on peg3 peg1))(not (on peg3 peg2))(not (on peg3 peg3))(not (on peg3 d1))(not (on peg3 d2))(not (on peg3 d3))(not (on peg3 d4))(not (on peg3 d5))(not (on d1 peg2))(not (on d1 peg3))(not (on d1 d1))(not (on d1 d2))(not (on d1 d3))(not (on d1 d4))(not (on d1 d5))(not (on d2 peg1))(not (on d2 peg2))(not (on d2 peg3))(not (on d2 d1))(not (on d2 d2))(not (on d2 d4))(not (on d2 d5))(not (on d3 peg1))(not (on d3 peg2))(not (on d3 peg3))(not (on d3 d1))(not (on d3 d2))(not (on d3 d3))(not (on d3 d5))(not (on d4 peg1))(not (on d4 peg3))(not (on d4 d1))(not (on d4 d2))(not (on d4 d3))(not (on d4 d4))(not (on d4 d5))(not (on d5 peg1))(not (on d5 peg2))(not (on d5 d1))(not (on d5 d2))(not (on d5 d3))(not (on d5 d4))(not (on d5 d5))(not (smaller peg1 peg1))(not (smaller peg1 peg2))(not (smaller peg1 peg3))(not (smaller peg2 peg1))(not (smaller peg2 peg2))(not (smaller peg2 peg3))(not (smaller peg3 peg1))(not (smaller peg3 peg2))(not (smaller peg3 peg3))(not (smaller d1 peg1))(not (smaller d1 peg2))(not (smaller d1 peg3))(not (smaller d1 d2))(not (smaller d1 d3))(not (smaller d1 d4))(not (smaller d1 d5))(not (smaller d2 peg1))(not (smaller d2 peg2))(not (smaller d2 peg3))(not (smaller d2 d3))(not (smaller d2 d4))(not (smaller d2 d5))(not (smaller d3 peg1))(not (smaller d3 peg2))(not (smaller d3 peg3))(not (smaller d3 d4))(not (smaller d3 d5))(not (smaller d4 peg1))(not (smaller d4 peg2))(not (smaller d4 peg3))(not (smaller d4 d5))(not (smaller d5 peg1))(not (smaller d5 peg2))(not (smaller d5 peg3))(not (smaller d5 d5)))))