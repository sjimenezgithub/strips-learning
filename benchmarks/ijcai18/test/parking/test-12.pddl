(define (problem parking1)
  (:domain parking)
  (:objects car_2 -  car car_1 -  car car_3 -  car car_4 -  car car_0 -  car curb_0 -  curb car_5 -  car curb_1 -  curb curb_2 -  curb curb_3 -  curb )
  (:init (at-curb car_2) (at-curb car_1) (at-curb-num car_1 curb_1) (at-curb-num car_2 curb_0) (car-clear car_4) (car-clear car_0) (at-curb-num car_3 curb_3) (at-curb car_3) (at-curb-num car_5 curb_2) (at-curb car_5) (car-clear car_1) (behind-car car_0 car_2) (car-clear car_5) (behind-car car_4 car_3) )
  (:goal (and (at-curb car_2)(at-curb car_1)(at-curb-num car_1 curb_1)(at-curb-num car_2 curb_0)(car-clear car_4)(car-clear car_0)(at-curb-num car_3 curb_3)(at-curb car_3)(behind-car car_0 car_2)(car-clear car_5)(behind-car car_4 car_3)(curb-clear curb_2)(behind-car car_5 car_1)(not (at-curb car_0))(not (at-curb car_4))(not (at-curb car_5))(not (at-curb-num car_0 curb_0))(not (at-curb-num car_0 curb_1))(not (at-curb-num car_0 curb_2))(not (at-curb-num car_0 curb_3))(not (at-curb-num car_1 curb_0))(not (at-curb-num car_1 curb_2))(not (at-curb-num car_1 curb_3))(not (at-curb-num car_2 curb_1))(not (at-curb-num car_2 curb_2))(not (at-curb-num car_2 curb_3))(not (at-curb-num car_3 curb_0))(not (at-curb-num car_3 curb_1))(not (at-curb-num car_3 curb_2))(not (at-curb-num car_4 curb_0))(not (at-curb-num car_4 curb_1))(not (at-curb-num car_4 curb_2))(not (at-curb-num car_4 curb_3))(not (at-curb-num car_5 curb_0))(not (at-curb-num car_5 curb_1))(not (at-curb-num car_5 curb_2))(not (at-curb-num car_5 curb_3))(not (behind-car car_0 car_0))(not (behind-car car_0 car_1))(not (behind-car car_0 car_3))(not (behind-car car_0 car_4))(not (behind-car car_0 car_5))(not (behind-car car_1 car_0))(not (behind-car car_1 car_1))(not (behind-car car_1 car_2))(not (behind-car car_1 car_3))(not (behind-car car_1 car_4))(not (behind-car car_1 car_5))(not (behind-car car_2 car_0))(not (behind-car car_2 car_1))(not (behind-car car_2 car_2))(not (behind-car car_2 car_3))(not (behind-car car_2 car_4))(not (behind-car car_2 car_5))(not (behind-car car_3 car_0))(not (behind-car car_3 car_1))(not (behind-car car_3 car_2))(not (behind-car car_3 car_3))(not (behind-car car_3 car_4))(not (behind-car car_3 car_5))(not (behind-car car_4 car_0))(not (behind-car car_4 car_1))(not (behind-car car_4 car_2))(not (behind-car car_4 car_4))(not (behind-car car_4 car_5))(not (behind-car car_5 car_0))(not (behind-car car_5 car_2))(not (behind-car car_5 car_3))(not (behind-car car_5 car_4))(not (behind-car car_5 car_5))(not (car-clear car_1))(not (car-clear car_2))(not (car-clear car_3))(not (curb-clear curb_0))(not (curb-clear curb_1))(not (curb-clear curb_3)))))