(define (problem prob004)
  (:domain floor-tile)
  (:objects tile_0-3 -  tile tile_0-2 -  tile tile_1-1 -  tile tile_0-1 -  tile tile_1-3 -  tile tile_1-2 -  tile tile_2-1 -  tile tile_2-2 -  tile tile_2-3 -  tile tile_3-1 -  tile tile_3-2 -  tile tile_3-3 -  tile tile_4-1 -  tile tile_4-2 -  tile tile_4-3 -  tile robot1 -  robot robot2 -  robot white -  color black -  color )
  (:init (clear tile_1-3) (down tile_2-2 tile_3-2) (up tile_1-2 tile_0-2) (clear tile_0-3) (up tile_4-3 tile_3-3) (up tile_2-1 tile_1-1) (up tile_4-1 tile_3-1) (down tile_0-1 tile_1-1) (available-color white) (clear tile_1-2) (down tile_2-3 tile_3-3) (up tile_3-2 tile_2-2) (left tile_3-2 tile_3-3) (down tile_1-3 tile_2-3) (up tile_1-1 tile_0-1) (right tile_1-3 tile_1-2) (left tile_4-2 tile_4-3) (right tile_3-2 tile_3-1) (left tile_2-1 tile_2-2) (down tile_2-1 tile_3-1) (left tile_1-2 tile_1-3) (left tile_0-2 tile_0-3) (right tile_4-2 tile_4-1) (available-color black) (right tile_4-3 tile_4-2) (up tile_4-2 tile_3-2) (up tile_3-1 tile_2-1) (left tile_3-1 tile_3-2) (right tile_0-3 tile_0-2) (down tile_1-2 tile_2-2) (down tile_0-3 tile_1-3) (left tile_4-1 tile_4-2) (left tile_1-1 tile_1-2) (down tile_3-1 tile_4-1) (down tile_3-3 tile_4-3) (right tile_2-2 tile_2-1) (up tile_2-3 tile_1-3) (left tile_2-2 tile_2-3) (right tile_1-2 tile_1-1) (right tile_2-3 tile_2-2) (up tile_1-3 tile_0-3) (up tile_2-2 tile_1-2) (down tile_3-2 tile_4-2) (right tile_0-2 tile_0-1) (clear tile_2-3) (clear tile_0-2) (down tile_1-1 tile_2-1) (left tile_0-1 tile_0-2) (right tile_3-3 tile_3-2) (down tile_0-2 tile_1-2) (up tile_3-3 tile_2-3) (clear tile_4-3) (clear tile_0-1) (painted tile_4-1 black) (clear tile_1-1) (painted tile_3-1 white) (painted tile_4-2 white) (robot-has robot1 black) (robot-has robot2 black) (robot-at robot1 tile_2-2) (clear tile_2-1) (robot-at robot2 tile_3-3) (painted tile_3-2 black) )
  (:goal (and (clear tile_1-3)(down tile_2-2 tile_3-2)(up tile_1-2 tile_0-2)(clear tile_0-3)(up tile_4-3 tile_3-3)(up tile_2-1 tile_1-1)(up tile_4-1 tile_3-1)(down tile_0-1 tile_1-1)(available-color white)(down tile_2-3 tile_3-3)(up tile_3-2 tile_2-2)(left tile_3-2 tile_3-3)(down tile_1-3 tile_2-3)(up tile_1-1 tile_0-1)(right tile_1-3 tile_1-2)(left tile_4-2 tile_4-3)(right tile_3-2 tile_3-1)(left tile_2-1 tile_2-2)(down tile_2-1 tile_3-1)(left tile_1-2 tile_1-3)(left tile_0-2 tile_0-3)(right tile_4-2 tile_4-1)(available-color black)(right tile_4-3 tile_4-2)(up tile_4-2 tile_3-2)(up tile_3-1 tile_2-1)(left tile_3-1 tile_3-2)(right tile_0-3 tile_0-2)(down tile_1-2 tile_2-2)(down tile_0-3 tile_1-3)(left tile_4-1 tile_4-2)(left tile_1-1 tile_1-2)(down tile_3-1 tile_4-1)(down tile_3-3 tile_4-3)(right tile_2-2 tile_2-1)(up tile_2-3 tile_1-3)(left tile_2-2 tile_2-3)(right tile_1-2 tile_1-1)(right tile_2-3 tile_2-2)(up tile_1-3 tile_0-3)(up tile_2-2 tile_1-2)(down tile_3-2 tile_4-2)(right tile_0-2 tile_0-1)(clear tile_0-2)(down tile_1-1 tile_2-1)(left tile_0-1 tile_0-2)(right tile_3-3 tile_3-2)(down tile_0-2 tile_1-2)(up tile_3-3 tile_2-3)(clear tile_0-1)(painted tile_4-1 black)(clear tile_1-1)(painted tile_3-1 white)(painted tile_4-2 white)(clear tile_2-1)(painted tile_3-2 black)(painted tile_4-3 black)(robot-has robot1 white)(robot-has robot2 white)(robot-at robot1 tile_1-2)(clear tile_2-2)(robot-at robot2 tile_2-3)(clear tile_3-3)(not (robot-at robot1 tile_0-1))(not (robot-at robot1 tile_0-2))(not (robot-at robot1 tile_0-3))(not (robot-at robot1 tile_1-1))(not (robot-at robot1 tile_1-3))(not (robot-at robot1 tile_2-1))(not (robot-at robot1 tile_2-2))(not (robot-at robot1 tile_2-3))(not (robot-at robot1 tile_3-1))(not (robot-at robot1 tile_3-2))(not (robot-at robot1 tile_3-3))(not (robot-at robot1 tile_4-1))(not (robot-at robot1 tile_4-2))(not (robot-at robot1 tile_4-3))(not (robot-at robot2 tile_0-1))(not (robot-at robot2 tile_0-2))(not (robot-at robot2 tile_0-3))(not (robot-at robot2 tile_1-1))(not (robot-at robot2 tile_1-2))(not (robot-at robot2 tile_1-3))(not (robot-at robot2 tile_2-1))(not (robot-at robot2 tile_2-2))(not (robot-at robot2 tile_3-1))(not (robot-at robot2 tile_3-2))(not (robot-at robot2 tile_3-3))(not (robot-at robot2 tile_4-1))(not (robot-at robot2 tile_4-2))(not (robot-at robot2 tile_4-3))(not (up tile_0-1 tile_0-1))(not (up tile_0-1 tile_0-2))(not (up tile_0-1 tile_0-3))(not (up tile_0-1 tile_1-1))(not (up tile_0-1 tile_1-2))(not (up tile_0-1 tile_1-3))(not (up tile_0-1 tile_2-1))(not (up tile_0-1 tile_2-2))(not (up tile_0-1 tile_2-3))(not (up tile_0-1 tile_3-1))(not (up tile_0-1 tile_3-2))(not (up tile_0-1 tile_3-3))(not (up tile_0-1 tile_4-1))(not (up tile_0-1 tile_4-2))(not (up tile_0-1 tile_4-3))(not (up tile_0-2 tile_0-1))(not (up tile_0-2 tile_0-2))(not (up tile_0-2 tile_0-3))(not (up tile_0-2 tile_1-1))(not (up tile_0-2 tile_1-2))(not (up tile_0-2 tile_1-3))(not (up tile_0-2 tile_2-1))(not (up tile_0-2 tile_2-2))(not (up tile_0-2 tile_2-3))(not (up tile_0-2 tile_3-1))(not (up tile_0-2 tile_3-2))(not (up tile_0-2 tile_3-3))(not (up tile_0-2 tile_4-1))(not (up tile_0-2 tile_4-2))(not (up tile_0-2 tile_4-3))(not (up tile_0-3 tile_0-1))(not (up tile_0-3 tile_0-2))(not (up tile_0-3 tile_0-3))(not (up tile_0-3 tile_1-1))(not (up tile_0-3 tile_1-2))(not (up tile_0-3 tile_1-3))(not (up tile_0-3 tile_2-1))(not (up tile_0-3 tile_2-2))(not (up tile_0-3 tile_2-3))(not (up tile_0-3 tile_3-1))(not (up tile_0-3 tile_3-2))(not (up tile_0-3 tile_3-3))(not (up tile_0-3 tile_4-1))(not (up tile_0-3 tile_4-2))(not (up tile_0-3 tile_4-3))(not (up tile_1-1 tile_0-2))(not (up tile_1-1 tile_0-3))(not (up tile_1-1 tile_1-1))(not (up tile_1-1 tile_1-2))(not (up tile_1-1 tile_1-3))(not (up tile_1-1 tile_2-1))(not (up tile_1-1 tile_2-2))(not (up tile_1-1 tile_2-3))(not (up tile_1-1 tile_3-1))(not (up tile_1-1 tile_3-2))(not (up tile_1-1 tile_3-3))(not (up tile_1-1 tile_4-1))(not (up tile_1-1 tile_4-2))(not (up tile_1-1 tile_4-3))(not (up tile_1-2 tile_0-1))(not (up tile_1-2 tile_0-3))(not (up tile_1-2 tile_1-1))(not (up tile_1-2 tile_1-2))(not (up tile_1-2 tile_1-3))(not (up tile_1-2 tile_2-1))(not (up tile_1-2 tile_2-2))(not (up tile_1-2 tile_2-3))(not (up tile_1-2 tile_3-1))(not (up tile_1-2 tile_3-2))(not (up tile_1-2 tile_3-3))(not (up tile_1-2 tile_4-1))(not (up tile_1-2 tile_4-2))(not (up tile_1-2 tile_4-3))(not (up tile_1-3 tile_0-1))(not (up tile_1-3 tile_0-2))(not (up tile_1-3 tile_1-1))(not (up tile_1-3 tile_1-2))(not (up tile_1-3 tile_1-3))(not (up tile_1-3 tile_2-1))(not (up tile_1-3 tile_2-2))(not (up tile_1-3 tile_2-3))(not (up tile_1-3 tile_3-1))(not (up tile_1-3 tile_3-2))(not (up tile_1-3 tile_3-3))(not (up tile_1-3 tile_4-1))(not (up tile_1-3 tile_4-2))(not (up tile_1-3 tile_4-3))(not (up tile_2-1 tile_0-1))(not (up tile_2-1 tile_0-2))(not (up tile_2-1 tile_0-3))(not (up tile_2-1 tile_1-2))(not (up tile_2-1 tile_1-3))(not (up tile_2-1 tile_2-1))(not (up tile_2-1 tile_2-2))(not (up tile_2-1 tile_2-3))(not (up tile_2-1 tile_3-1))(not (up tile_2-1 tile_3-2))(not (up tile_2-1 tile_3-3))(not (up tile_2-1 tile_4-1))(not (up tile_2-1 tile_4-2))(not (up tile_2-1 tile_4-3))(not (up tile_2-2 tile_0-1))(not (up tile_2-2 tile_0-2))(not (up tile_2-2 tile_0-3))(not (up tile_2-2 tile_1-1))(not (up tile_2-2 tile_1-3))(not (up tile_2-2 tile_2-1))(not (up tile_2-2 tile_2-2))(not (up tile_2-2 tile_2-3))(not (up tile_2-2 tile_3-1))(not (up tile_2-2 tile_3-2))(not (up tile_2-2 tile_3-3))(not (up tile_2-2 tile_4-1))(not (up tile_2-2 tile_4-2))(not (up tile_2-2 tile_4-3))(not (up tile_2-3 tile_0-1))(not (up tile_2-3 tile_0-2))(not (up tile_2-3 tile_0-3))(not (up tile_2-3 tile_1-1))(not (up tile_2-3 tile_1-2))(not (up tile_2-3 tile_2-1))(not (up tile_2-3 tile_2-2))(not (up tile_2-3 tile_2-3))(not (up tile_2-3 tile_3-1))(not (up tile_2-3 tile_3-2))(not (up tile_2-3 tile_3-3))(not (up tile_2-3 tile_4-1))(not (up tile_2-3 tile_4-2))(not (up tile_2-3 tile_4-3))(not (up tile_3-1 tile_0-1))(not (up tile_3-1 tile_0-2))(not (up tile_3-1 tile_0-3))(not (up tile_3-1 tile_1-1))(not (up tile_3-1 tile_1-2))(not (up tile_3-1 tile_1-3))(not (up tile_3-1 tile_2-2))(not (up tile_3-1 tile_2-3))(not (up tile_3-1 tile_3-1))(not (up tile_3-1 tile_3-2))(not (up tile_3-1 tile_3-3))(not (up tile_3-1 tile_4-1))(not (up tile_3-1 tile_4-2))(not (up tile_3-1 tile_4-3))(not (up tile_3-2 tile_0-1))(not (up tile_3-2 tile_0-2))(not (up tile_3-2 tile_0-3))(not (up tile_3-2 tile_1-1))(not (up tile_3-2 tile_1-2))(not (up tile_3-2 tile_1-3))(not (up tile_3-2 tile_2-1))(not (up tile_3-2 tile_2-3))(not (up tile_3-2 tile_3-1))(not (up tile_3-2 tile_3-2))(not (up tile_3-2 tile_3-3))(not (up tile_3-2 tile_4-1))(not (up tile_3-2 tile_4-2))(not (up tile_3-2 tile_4-3))(not (up tile_3-3 tile_0-1))(not (up tile_3-3 tile_0-2))(not (up tile_3-3 tile_0-3))(not (up tile_3-3 tile_1-1))(not (up tile_3-3 tile_1-2))(not (up tile_3-3 tile_1-3))(not (up tile_3-3 tile_2-1))(not (up tile_3-3 tile_2-2))(not (up tile_3-3 tile_3-1))(not (up tile_3-3 tile_3-2))(not (up tile_3-3 tile_3-3))(not (up tile_3-3 tile_4-1))(not (up tile_3-3 tile_4-2))(not (up tile_3-3 tile_4-3))(not (up tile_4-1 tile_0-1))(not (up tile_4-1 tile_0-2))(not (up tile_4-1 tile_0-3))(not (up tile_4-1 tile_1-1))(not (up tile_4-1 tile_1-2))(not (up tile_4-1 tile_1-3))(not (up tile_4-1 tile_2-1))(not (up tile_4-1 tile_2-2))(not (up tile_4-1 tile_2-3))(not (up tile_4-1 tile_3-2))(not (up tile_4-1 tile_3-3))(not (up tile_4-1 tile_4-1))(not (up tile_4-1 tile_4-2))(not (up tile_4-1 tile_4-3))(not (up tile_4-2 tile_0-1))(not (up tile_4-2 tile_0-2))(not (up tile_4-2 tile_0-3))(not (up tile_4-2 tile_1-1))(not (up tile_4-2 tile_1-2))(not (up tile_4-2 tile_1-3))(not (up tile_4-2 tile_2-1))(not (up tile_4-2 tile_2-2))(not (up tile_4-2 tile_2-3))(not (up tile_4-2 tile_3-1))(not (up tile_4-2 tile_3-3))(not (up tile_4-2 tile_4-1))(not (up tile_4-2 tile_4-2))(not (up tile_4-2 tile_4-3))(not (up tile_4-3 tile_0-1))(not (up tile_4-3 tile_0-2))(not (up tile_4-3 tile_0-3))(not (up tile_4-3 tile_1-1))(not (up tile_4-3 tile_1-2))(not (up tile_4-3 tile_1-3))(not (up tile_4-3 tile_2-1))(not (up tile_4-3 tile_2-2))(not (up tile_4-3 tile_2-3))(not (up tile_4-3 tile_3-1))(not (up tile_4-3 tile_3-2))(not (up tile_4-3 tile_4-1))(not (up tile_4-3 tile_4-2))(not (up tile_4-3 tile_4-3))(not (down tile_0-1 tile_0-1))(not (down tile_0-1 tile_0-2))(not (down tile_0-1 tile_0-3))(not (down tile_0-1 tile_1-2))(not (down tile_0-1 tile_1-3))(not (down tile_0-1 tile_2-1))(not (down tile_0-1 tile_2-2))(not (down tile_0-1 tile_2-3))(not (down tile_0-1 tile_3-1))(not (down tile_0-1 tile_3-2))(not (down tile_0-1 tile_3-3))(not (down tile_0-1 tile_4-1))(not (down tile_0-1 tile_4-2))(not (down tile_0-1 tile_4-3))(not (down tile_0-2 tile_0-1))(not (down tile_0-2 tile_0-2))(not (down tile_0-2 tile_0-3))(not (down tile_0-2 tile_1-1))(not (down tile_0-2 tile_1-3))(not (down tile_0-2 tile_2-1))(not (down tile_0-2 tile_2-2))(not (down tile_0-2 tile_2-3))(not (down tile_0-2 tile_3-1))(not (down tile_0-2 tile_3-2))(not (down tile_0-2 tile_3-3))(not (down tile_0-2 tile_4-1))(not (down tile_0-2 tile_4-2))(not (down tile_0-2 tile_4-3))(not (down tile_0-3 tile_0-1))(not (down tile_0-3 tile_0-2))(not (down tile_0-3 tile_0-3))(not (down tile_0-3 tile_1-1))(not (down tile_0-3 tile_1-2))(not (down tile_0-3 tile_2-1))(not (down tile_0-3 tile_2-2))(not (down tile_0-3 tile_2-3))(not (down tile_0-3 tile_3-1))(not (down tile_0-3 tile_3-2))(not (down tile_0-3 tile_3-3))(not (down tile_0-3 tile_4-1))(not (down tile_0-3 tile_4-2))(not (down tile_0-3 tile_4-3))(not (down tile_1-1 tile_0-1))(not (down tile_1-1 tile_0-2))(not (down tile_1-1 tile_0-3))(not (down tile_1-1 tile_1-1))(not (down tile_1-1 tile_1-2))(not (down tile_1-1 tile_1-3))(not (down tile_1-1 tile_2-2))(not (down tile_1-1 tile_2-3))(not (down tile_1-1 tile_3-1))(not (down tile_1-1 tile_3-2))(not (down tile_1-1 tile_3-3))(not (down tile_1-1 tile_4-1))(not (down tile_1-1 tile_4-2))(not (down tile_1-1 tile_4-3))(not (down tile_1-2 tile_0-1))(not (down tile_1-2 tile_0-2))(not (down tile_1-2 tile_0-3))(not (down tile_1-2 tile_1-1))(not (down tile_1-2 tile_1-2))(not (down tile_1-2 tile_1-3))(not (down tile_1-2 tile_2-1))(not (down tile_1-2 tile_2-3))(not (down tile_1-2 tile_3-1))(not (down tile_1-2 tile_3-2))(not (down tile_1-2 tile_3-3))(not (down tile_1-2 tile_4-1))(not (down tile_1-2 tile_4-2))(not (down tile_1-2 tile_4-3))(not (down tile_1-3 tile_0-1))(not (down tile_1-3 tile_0-2))(not (down tile_1-3 tile_0-3))(not (down tile_1-3 tile_1-1))(not (down tile_1-3 tile_1-2))(not (down tile_1-3 tile_1-3))(not (down tile_1-3 tile_2-1))(not (down tile_1-3 tile_2-2))(not (down tile_1-3 tile_3-1))(not (down tile_1-3 tile_3-2))(not (down tile_1-3 tile_3-3))(not (down tile_1-3 tile_4-1))(not (down tile_1-3 tile_4-2))(not (down tile_1-3 tile_4-3))(not (down tile_2-1 tile_0-1))(not (down tile_2-1 tile_0-2))(not (down tile_2-1 tile_0-3))(not (down tile_2-1 tile_1-1))(not (down tile_2-1 tile_1-2))(not (down tile_2-1 tile_1-3))(not (down tile_2-1 tile_2-1))(not (down tile_2-1 tile_2-2))(not (down tile_2-1 tile_2-3))(not (down tile_2-1 tile_3-2))(not (down tile_2-1 tile_3-3))(not (down tile_2-1 tile_4-1))(not (down tile_2-1 tile_4-2))(not (down tile_2-1 tile_4-3))(not (down tile_2-2 tile_0-1))(not (down tile_2-2 tile_0-2))(not (down tile_2-2 tile_0-3))(not (down tile_2-2 tile_1-1))(not (down tile_2-2 tile_1-2))(not (down tile_2-2 tile_1-3))(not (down tile_2-2 tile_2-1))(not (down tile_2-2 tile_2-2))(not (down tile_2-2 tile_2-3))(not (down tile_2-2 tile_3-1))(not (down tile_2-2 tile_3-3))(not (down tile_2-2 tile_4-1))(not (down tile_2-2 tile_4-2))(not (down tile_2-2 tile_4-3))(not (down tile_2-3 tile_0-1))(not (down tile_2-3 tile_0-2))(not (down tile_2-3 tile_0-3))(not (down tile_2-3 tile_1-1))(not (down tile_2-3 tile_1-2))(not (down tile_2-3 tile_1-3))(not (down tile_2-3 tile_2-1))(not (down tile_2-3 tile_2-2))(not (down tile_2-3 tile_2-3))(not (down tile_2-3 tile_3-1))(not (down tile_2-3 tile_3-2))(not (down tile_2-3 tile_4-1))(not (down tile_2-3 tile_4-2))(not (down tile_2-3 tile_4-3))(not (down tile_3-1 tile_0-1))(not (down tile_3-1 tile_0-2))(not (down tile_3-1 tile_0-3))(not (down tile_3-1 tile_1-1))(not (down tile_3-1 tile_1-2))(not (down tile_3-1 tile_1-3))(not (down tile_3-1 tile_2-1))(not (down tile_3-1 tile_2-2))(not (down tile_3-1 tile_2-3))(not (down tile_3-1 tile_3-1))(not (down tile_3-1 tile_3-2))(not (down tile_3-1 tile_3-3))(not (down tile_3-1 tile_4-2))(not (down tile_3-1 tile_4-3))(not (down tile_3-2 tile_0-1))(not (down tile_3-2 tile_0-2))(not (down tile_3-2 tile_0-3))(not (down tile_3-2 tile_1-1))(not (down tile_3-2 tile_1-2))(not (down tile_3-2 tile_1-3))(not (down tile_3-2 tile_2-1))(not (down tile_3-2 tile_2-2))(not (down tile_3-2 tile_2-3))(not (down tile_3-2 tile_3-1))(not (down tile_3-2 tile_3-2))(not (down tile_3-2 tile_3-3))(not (down tile_3-2 tile_4-1))(not (down tile_3-2 tile_4-3))(not (down tile_3-3 tile_0-1))(not (down tile_3-3 tile_0-2))(not (down tile_3-3 tile_0-3))(not (down tile_3-3 tile_1-1))(not (down tile_3-3 tile_1-2))(not (down tile_3-3 tile_1-3))(not (down tile_3-3 tile_2-1))(not (down tile_3-3 tile_2-2))(not (down tile_3-3 tile_2-3))(not (down tile_3-3 tile_3-1))(not (down tile_3-3 tile_3-2))(not (down tile_3-3 tile_3-3))(not (down tile_3-3 tile_4-1))(not (down tile_3-3 tile_4-2))(not (down tile_4-1 tile_0-1))(not (down tile_4-1 tile_0-2))(not (down tile_4-1 tile_0-3))(not (down tile_4-1 tile_1-1))(not (down tile_4-1 tile_1-2))(not (down tile_4-1 tile_1-3))(not (down tile_4-1 tile_2-1))(not (down tile_4-1 tile_2-2))(not (down tile_4-1 tile_2-3))(not (down tile_4-1 tile_3-1))(not (down tile_4-1 tile_3-2))(not (down tile_4-1 tile_3-3))(not (down tile_4-1 tile_4-1))(not (down tile_4-1 tile_4-2))(not (down tile_4-1 tile_4-3))(not (down tile_4-2 tile_0-1))(not (down tile_4-2 tile_0-2))(not (down tile_4-2 tile_0-3))(not (down tile_4-2 tile_1-1))(not (down tile_4-2 tile_1-2))(not (down tile_4-2 tile_1-3))(not (down tile_4-2 tile_2-1))(not (down tile_4-2 tile_2-2))(not (down tile_4-2 tile_2-3))(not (down tile_4-2 tile_3-1))(not (down tile_4-2 tile_3-2))(not (down tile_4-2 tile_3-3))(not (down tile_4-2 tile_4-1))(not (down tile_4-2 tile_4-2))(not (down tile_4-2 tile_4-3))(not (down tile_4-3 tile_0-1))(not (down tile_4-3 tile_0-2))(not (down tile_4-3 tile_0-3))(not (down tile_4-3 tile_1-1))(not (down tile_4-3 tile_1-2))(not (down tile_4-3 tile_1-3))(not (down tile_4-3 tile_2-1))(not (down tile_4-3 tile_2-2))(not (down tile_4-3 tile_2-3))(not (down tile_4-3 tile_3-1))(not (down tile_4-3 tile_3-2))(not (down tile_4-3 tile_3-3))(not (down tile_4-3 tile_4-1))(not (down tile_4-3 tile_4-2))(not (down tile_4-3 tile_4-3))(not (right tile_0-1 tile_0-1))(not (right tile_0-1 tile_0-2))(not (right tile_0-1 tile_0-3))(not (right tile_0-1 tile_1-1))(not (right tile_0-1 tile_1-2))(not (right tile_0-1 tile_1-3))(not (right tile_0-1 tile_2-1))(not (right tile_0-1 tile_2-2))(not (right tile_0-1 tile_2-3))(not (right tile_0-1 tile_3-1))(not (right tile_0-1 tile_3-2))(not (right tile_0-1 tile_3-3))(not (right tile_0-1 tile_4-1))(not (right tile_0-1 tile_4-2))(not (right tile_0-1 tile_4-3))(not (right tile_0-2 tile_0-2))(not (right tile_0-2 tile_0-3))(not (right tile_0-2 tile_1-1))(not (right tile_0-2 tile_1-2))(not (right tile_0-2 tile_1-3))(not (right tile_0-2 tile_2-1))(not (right tile_0-2 tile_2-2))(not (right tile_0-2 tile_2-3))(not (right tile_0-2 tile_3-1))(not (right tile_0-2 tile_3-2))(not (right tile_0-2 tile_3-3))(not (right tile_0-2 tile_4-1))(not (right tile_0-2 tile_4-2))(not (right tile_0-2 tile_4-3))(not (right tile_0-3 tile_0-1))(not (right tile_0-3 tile_0-3))(not (right tile_0-3 tile_1-1))(not (right tile_0-3 tile_1-2))(not (right tile_0-3 tile_1-3))(not (right tile_0-3 tile_2-1))(not (right tile_0-3 tile_2-2))(not (right tile_0-3 tile_2-3))(not (right tile_0-3 tile_3-1))(not (right tile_0-3 tile_3-2))(not (right tile_0-3 tile_3-3))(not (right tile_0-3 tile_4-1))(not (right tile_0-3 tile_4-2))(not (right tile_0-3 tile_4-3))(not (right tile_1-1 tile_0-1))(not (right tile_1-1 tile_0-2))(not (right tile_1-1 tile_0-3))(not (right tile_1-1 tile_1-1))(not (right tile_1-1 tile_1-2))(not (right tile_1-1 tile_1-3))(not (right tile_1-1 tile_2-1))(not (right tile_1-1 tile_2-2))(not (right tile_1-1 tile_2-3))(not (right tile_1-1 tile_3-1))(not (right tile_1-1 tile_3-2))(not (right tile_1-1 tile_3-3))(not (right tile_1-1 tile_4-1))(not (right tile_1-1 tile_4-2))(not (right tile_1-1 tile_4-3))(not (right tile_1-2 tile_0-1))(not (right tile_1-2 tile_0-2))(not (right tile_1-2 tile_0-3))(not (right tile_1-2 tile_1-2))(not (right tile_1-2 tile_1-3))(not (right tile_1-2 tile_2-1))(not (right tile_1-2 tile_2-2))(not (right tile_1-2 tile_2-3))(not (right tile_1-2 tile_3-1))(not (right tile_1-2 tile_3-2))(not (right tile_1-2 tile_3-3))(not (right tile_1-2 tile_4-1))(not (right tile_1-2 tile_4-2))(not (right tile_1-2 tile_4-3))(not (right tile_1-3 tile_0-1))(not (right tile_1-3 tile_0-2))(not (right tile_1-3 tile_0-3))(not (right tile_1-3 tile_1-1))(not (right tile_1-3 tile_1-3))(not (right tile_1-3 tile_2-1))(not (right tile_1-3 tile_2-2))(not (right tile_1-3 tile_2-3))(not (right tile_1-3 tile_3-1))(not (right tile_1-3 tile_3-2))(not (right tile_1-3 tile_3-3))(not (right tile_1-3 tile_4-1))(not (right tile_1-3 tile_4-2))(not (right tile_1-3 tile_4-3))(not (right tile_2-1 tile_0-1))(not (right tile_2-1 tile_0-2))(not (right tile_2-1 tile_0-3))(not (right tile_2-1 tile_1-1))(not (right tile_2-1 tile_1-2))(not (right tile_2-1 tile_1-3))(not (right tile_2-1 tile_2-1))(not (right tile_2-1 tile_2-2))(not (right tile_2-1 tile_2-3))(not (right tile_2-1 tile_3-1))(not (right tile_2-1 tile_3-2))(not (right tile_2-1 tile_3-3))(not (right tile_2-1 tile_4-1))(not (right tile_2-1 tile_4-2))(not (right tile_2-1 tile_4-3))(not (right tile_2-2 tile_0-1))(not (right tile_2-2 tile_0-2))(not (right tile_2-2 tile_0-3))(not (right tile_2-2 tile_1-1))(not (right tile_2-2 tile_1-2))(not (right tile_2-2 tile_1-3))(not (right tile_2-2 tile_2-2))(not (right tile_2-2 tile_2-3))(not (right tile_2-2 tile_3-1))(not (right tile_2-2 tile_3-2))(not (right tile_2-2 tile_3-3))(not (right tile_2-2 tile_4-1))(not (right tile_2-2 tile_4-2))(not (right tile_2-2 tile_4-3))(not (right tile_2-3 tile_0-1))(not (right tile_2-3 tile_0-2))(not (right tile_2-3 tile_0-3))(not (right tile_2-3 tile_1-1))(not (right tile_2-3 tile_1-2))(not (right tile_2-3 tile_1-3))(not (right tile_2-3 tile_2-1))(not (right tile_2-3 tile_2-3))(not (right tile_2-3 tile_3-1))(not (right tile_2-3 tile_3-2))(not (right tile_2-3 tile_3-3))(not (right tile_2-3 tile_4-1))(not (right tile_2-3 tile_4-2))(not (right tile_2-3 tile_4-3))(not (right tile_3-1 tile_0-1))(not (right tile_3-1 tile_0-2))(not (right tile_3-1 tile_0-3))(not (right tile_3-1 tile_1-1))(not (right tile_3-1 tile_1-2))(not (right tile_3-1 tile_1-3))(not (right tile_3-1 tile_2-1))(not (right tile_3-1 tile_2-2))(not (right tile_3-1 tile_2-3))(not (right tile_3-1 tile_3-1))(not (right tile_3-1 tile_3-2))(not (right tile_3-1 tile_3-3))(not (right tile_3-1 tile_4-1))(not (right tile_3-1 tile_4-2))(not (right tile_3-1 tile_4-3))(not (right tile_3-2 tile_0-1))(not (right tile_3-2 tile_0-2))(not (right tile_3-2 tile_0-3))(not (right tile_3-2 tile_1-1))(not (right tile_3-2 tile_1-2))(not (right tile_3-2 tile_1-3))(not (right tile_3-2 tile_2-1))(not (right tile_3-2 tile_2-2))(not (right tile_3-2 tile_2-3))(not (right tile_3-2 tile_3-2))(not (right tile_3-2 tile_3-3))(not (right tile_3-2 tile_4-1))(not (right tile_3-2 tile_4-2))(not (right tile_3-2 tile_4-3))(not (right tile_3-3 tile_0-1))(not (right tile_3-3 tile_0-2))(not (right tile_3-3 tile_0-3))(not (right tile_3-3 tile_1-1))(not (right tile_3-3 tile_1-2))(not (right tile_3-3 tile_1-3))(not (right tile_3-3 tile_2-1))(not (right tile_3-3 tile_2-2))(not (right tile_3-3 tile_2-3))(not (right tile_3-3 tile_3-1))(not (right tile_3-3 tile_3-3))(not (right tile_3-3 tile_4-1))(not (right tile_3-3 tile_4-2))(not (right tile_3-3 tile_4-3))(not (right tile_4-1 tile_0-1))(not (right tile_4-1 tile_0-2))(not (right tile_4-1 tile_0-3))(not (right tile_4-1 tile_1-1))(not (right tile_4-1 tile_1-2))(not (right tile_4-1 tile_1-3))(not (right tile_4-1 tile_2-1))(not (right tile_4-1 tile_2-2))(not (right tile_4-1 tile_2-3))(not (right tile_4-1 tile_3-1))(not (right tile_4-1 tile_3-2))(not (right tile_4-1 tile_3-3))(not (right tile_4-1 tile_4-1))(not (right tile_4-1 tile_4-2))(not (right tile_4-1 tile_4-3))(not (right tile_4-2 tile_0-1))(not (right tile_4-2 tile_0-2))(not (right tile_4-2 tile_0-3))(not (right tile_4-2 tile_1-1))(not (right tile_4-2 tile_1-2))(not (right tile_4-2 tile_1-3))(not (right tile_4-2 tile_2-1))(not (right tile_4-2 tile_2-2))(not (right tile_4-2 tile_2-3))(not (right tile_4-2 tile_3-1))(not (right tile_4-2 tile_3-2))(not (right tile_4-2 tile_3-3))(not (right tile_4-2 tile_4-2))(not (right tile_4-2 tile_4-3))(not (right tile_4-3 tile_0-1))(not (right tile_4-3 tile_0-2))(not (right tile_4-3 tile_0-3))(not (right tile_4-3 tile_1-1))(not (right tile_4-3 tile_1-2))(not (right tile_4-3 tile_1-3))(not (right tile_4-3 tile_2-1))(not (right tile_4-3 tile_2-2))(not (right tile_4-3 tile_2-3))(not (right tile_4-3 tile_3-1))(not (right tile_4-3 tile_3-2))(not (right tile_4-3 tile_3-3))(not (right tile_4-3 tile_4-1))(not (right tile_4-3 tile_4-3))(not (left tile_0-1 tile_0-1))(not (left tile_0-1 tile_0-3))(not (left tile_0-1 tile_1-1))(not (left tile_0-1 tile_1-2))(not (left tile_0-1 tile_1-3))(not (left tile_0-1 tile_2-1))(not (left tile_0-1 tile_2-2))(not (left tile_0-1 tile_2-3))(not (left tile_0-1 tile_3-1))(not (left tile_0-1 tile_3-2))(not (left tile_0-1 tile_3-3))(not (left tile_0-1 tile_4-1))(not (left tile_0-1 tile_4-2))(not (left tile_0-1 tile_4-3))(not (left tile_0-2 tile_0-1))(not (left tile_0-2 tile_0-2))(not (left tile_0-2 tile_1-1))(not (left tile_0-2 tile_1-2))(not (left tile_0-2 tile_1-3))(not (left tile_0-2 tile_2-1))(not (left tile_0-2 tile_2-2))(not (left tile_0-2 tile_2-3))(not (left tile_0-2 tile_3-1))(not (left tile_0-2 tile_3-2))(not (left tile_0-2 tile_3-3))(not (left tile_0-2 tile_4-1))(not (left tile_0-2 tile_4-2))(not (left tile_0-2 tile_4-3))(not (left tile_0-3 tile_0-1))(not (left tile_0-3 tile_0-2))(not (left tile_0-3 tile_0-3))(not (left tile_0-3 tile_1-1))(not (left tile_0-3 tile_1-2))(not (left tile_0-3 tile_1-3))(not (left tile_0-3 tile_2-1))(not (left tile_0-3 tile_2-2))(not (left tile_0-3 tile_2-3))(not (left tile_0-3 tile_3-1))(not (left tile_0-3 tile_3-2))(not (left tile_0-3 tile_3-3))(not (left tile_0-3 tile_4-1))(not (left tile_0-3 tile_4-2))(not (left tile_0-3 tile_4-3))(not (left tile_1-1 tile_0-1))(not (left tile_1-1 tile_0-2))(not (left tile_1-1 tile_0-3))(not (left tile_1-1 tile_1-1))(not (left tile_1-1 tile_1-3))(not (left tile_1-1 tile_2-1))(not (left tile_1-1 tile_2-2))(not (left tile_1-1 tile_2-3))(not (left tile_1-1 tile_3-1))(not (left tile_1-1 tile_3-2))(not (left tile_1-1 tile_3-3))(not (left tile_1-1 tile_4-1))(not (left tile_1-1 tile_4-2))(not (left tile_1-1 tile_4-3))(not (left tile_1-2 tile_0-1))(not (left tile_1-2 tile_0-2))(not (left tile_1-2 tile_0-3))(not (left tile_1-2 tile_1-1))(not (left tile_1-2 tile_1-2))(not (left tile_1-2 tile_2-1))(not (left tile_1-2 tile_2-2))(not (left tile_1-2 tile_2-3))(not (left tile_1-2 tile_3-1))(not (left tile_1-2 tile_3-2))(not (left tile_1-2 tile_3-3))(not (left tile_1-2 tile_4-1))(not (left tile_1-2 tile_4-2))(not (left tile_1-2 tile_4-3))(not (left tile_1-3 tile_0-1))(not (left tile_1-3 tile_0-2))(not (left tile_1-3 tile_0-3))(not (left tile_1-3 tile_1-1))(not (left tile_1-3 tile_1-2))(not (left tile_1-3 tile_1-3))(not (left tile_1-3 tile_2-1))(not (left tile_1-3 tile_2-2))(not (left tile_1-3 tile_2-3))(not (left tile_1-3 tile_3-1))(not (left tile_1-3 tile_3-2))(not (left tile_1-3 tile_3-3))(not (left tile_1-3 tile_4-1))(not (left tile_1-3 tile_4-2))(not (left tile_1-3 tile_4-3))(not (left tile_2-1 tile_0-1))(not (left tile_2-1 tile_0-2))(not (left tile_2-1 tile_0-3))(not (left tile_2-1 tile_1-1))(not (left tile_2-1 tile_1-2))(not (left tile_2-1 tile_1-3))(not (left tile_2-1 tile_2-1))(not (left tile_2-1 tile_2-3))(not (left tile_2-1 tile_3-1))(not (left tile_2-1 tile_3-2))(not (left tile_2-1 tile_3-3))(not (left tile_2-1 tile_4-1))(not (left tile_2-1 tile_4-2))(not (left tile_2-1 tile_4-3))(not (left tile_2-2 tile_0-1))(not (left tile_2-2 tile_0-2))(not (left tile_2-2 tile_0-3))(not (left tile_2-2 tile_1-1))(not (left tile_2-2 tile_1-2))(not (left tile_2-2 tile_1-3))(not (left tile_2-2 tile_2-1))(not (left tile_2-2 tile_2-2))(not (left tile_2-2 tile_3-1))(not (left tile_2-2 tile_3-2))(not (left tile_2-2 tile_3-3))(not (left tile_2-2 tile_4-1))(not (left tile_2-2 tile_4-2))(not (left tile_2-2 tile_4-3))(not (left tile_2-3 tile_0-1))(not (left tile_2-3 tile_0-2))(not (left tile_2-3 tile_0-3))(not (left tile_2-3 tile_1-1))(not (left tile_2-3 tile_1-2))(not (left tile_2-3 tile_1-3))(not (left tile_2-3 tile_2-1))(not (left tile_2-3 tile_2-2))(not (left tile_2-3 tile_2-3))(not (left tile_2-3 tile_3-1))(not (left tile_2-3 tile_3-2))(not (left tile_2-3 tile_3-3))(not (left tile_2-3 tile_4-1))(not (left tile_2-3 tile_4-2))(not (left tile_2-3 tile_4-3))(not (left tile_3-1 tile_0-1))(not (left tile_3-1 tile_0-2))(not (left tile_3-1 tile_0-3))(not (left tile_3-1 tile_1-1))(not (left tile_3-1 tile_1-2))(not (left tile_3-1 tile_1-3))(not (left tile_3-1 tile_2-1))(not (left tile_3-1 tile_2-2))(not (left tile_3-1 tile_2-3))(not (left tile_3-1 tile_3-1))(not (left tile_3-1 tile_3-3))(not (left tile_3-1 tile_4-1))(not (left tile_3-1 tile_4-2))(not (left tile_3-1 tile_4-3))(not (left tile_3-2 tile_0-1))(not (left tile_3-2 tile_0-2))(not (left tile_3-2 tile_0-3))(not (left tile_3-2 tile_1-1))(not (left tile_3-2 tile_1-2))(not (left tile_3-2 tile_1-3))(not (left tile_3-2 tile_2-1))(not (left tile_3-2 tile_2-2))(not (left tile_3-2 tile_2-3))(not (left tile_3-2 tile_3-1))(not (left tile_3-2 tile_3-2))(not (left tile_3-2 tile_4-1))(not (left tile_3-2 tile_4-2))(not (left tile_3-2 tile_4-3))(not (left tile_3-3 tile_0-1))(not (left tile_3-3 tile_0-2))(not (left tile_3-3 tile_0-3))(not (left tile_3-3 tile_1-1))(not (left tile_3-3 tile_1-2))(not (left tile_3-3 tile_1-3))(not (left tile_3-3 tile_2-1))(not (left tile_3-3 tile_2-2))(not (left tile_3-3 tile_2-3))(not (left tile_3-3 tile_3-1))(not (left tile_3-3 tile_3-2))(not (left tile_3-3 tile_3-3))(not (left tile_3-3 tile_4-1))(not (left tile_3-3 tile_4-2))(not (left tile_3-3 tile_4-3))(not (left tile_4-1 tile_0-1))(not (left tile_4-1 tile_0-2))(not (left tile_4-1 tile_0-3))(not (left tile_4-1 tile_1-1))(not (left tile_4-1 tile_1-2))(not (left tile_4-1 tile_1-3))(not (left tile_4-1 tile_2-1))(not (left tile_4-1 tile_2-2))(not (left tile_4-1 tile_2-3))(not (left tile_4-1 tile_3-1))(not (left tile_4-1 tile_3-2))(not (left tile_4-1 tile_3-3))(not (left tile_4-1 tile_4-1))(not (left tile_4-1 tile_4-3))(not (left tile_4-2 tile_0-1))(not (left tile_4-2 tile_0-2))(not (left tile_4-2 tile_0-3))(not (left tile_4-2 tile_1-1))(not (left tile_4-2 tile_1-2))(not (left tile_4-2 tile_1-3))(not (left tile_4-2 tile_2-1))(not (left tile_4-2 tile_2-2))(not (left tile_4-2 tile_2-3))(not (left tile_4-2 tile_3-1))(not (left tile_4-2 tile_3-2))(not (left tile_4-2 tile_3-3))(not (left tile_4-2 tile_4-1))(not (left tile_4-2 tile_4-2))(not (left tile_4-3 tile_0-1))(not (left tile_4-3 tile_0-2))(not (left tile_4-3 tile_0-3))(not (left tile_4-3 tile_1-1))(not (left tile_4-3 tile_1-2))(not (left tile_4-3 tile_1-3))(not (left tile_4-3 tile_2-1))(not (left tile_4-3 tile_2-2))(not (left tile_4-3 tile_2-3))(not (left tile_4-3 tile_3-1))(not (left tile_4-3 tile_3-2))(not (left tile_4-3 tile_3-3))(not (left tile_4-3 tile_4-1))(not (left tile_4-3 tile_4-2))(not (left tile_4-3 tile_4-3))(not (clear tile_1-2))(not (clear tile_2-3))(not (clear tile_3-1))(not (clear tile_3-2))(not (clear tile_4-1))(not (clear tile_4-2))(not (clear tile_4-3))(not (painted tile_0-1 white))(not (painted tile_0-1 black))(not (painted tile_0-2 white))(not (painted tile_0-2 black))(not (painted tile_0-3 white))(not (painted tile_0-3 black))(not (painted tile_1-1 white))(not (painted tile_1-1 black))(not (painted tile_1-2 white))(not (painted tile_1-2 black))(not (painted tile_1-3 white))(not (painted tile_1-3 black))(not (painted tile_2-1 white))(not (painted tile_2-1 black))(not (painted tile_2-2 white))(not (painted tile_2-2 black))(not (painted tile_2-3 white))(not (painted tile_2-3 black))(not (painted tile_3-1 black))(not (painted tile_3-2 white))(not (painted tile_3-3 white))(not (painted tile_3-3 black))(not (painted tile_4-1 white))(not (painted tile_4-2 black))(not (painted tile_4-3 white))(not (robot-has robot1 black))(not (robot-has robot2 black))(not (free-color robot1))(not (free-color robot2)))))