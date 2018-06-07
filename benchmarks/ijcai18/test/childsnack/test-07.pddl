(define (problem prob-snack)
  (:domain child-snack)
  (:objects child1 -  child child2 -  child child3 -  child child4 -  child child5 -  child child7 -  child child6 -  child child8 -  child child9 -  child bread1 -  bread-portion bread2 -  bread-portion bread3 -  bread-portion bread4 -  bread-portion bread5 -  bread-portion bread6 -  bread-portion bread7 -  bread-portion bread8 -  bread-portion bread9 -  bread-portion content1 -  content-portion content2 -  content-portion content3 -  content-portion content4 -  content-portion content5 -  content-portion content6 -  content-portion content7 -  content-portion content8 -  content-portion content9 -  content-portion tray1 -  tray tray2 -  tray tray3 -  tray table1 -  place table2 -  place table3 -  place sandw1 -  sandwich sandw2 -  sandwich sandw3 -  sandwich sandw4 -  sandwich sandw5 -  sandwich sandw6 -  sandwich sandw7 -  sandwich sandw8 -  sandwich sandw9 -  sandwich sandw10 -  sandwich sandw11 -  sandwich sandw12 -  sandwich kitchen -  place )
  (:init (not_allergic_gluten child4) (not_allergic_gluten child8) (at_kitchen_content content4) (no_gluten_content content5) (allergic_gluten child9) (notexist sandw3) (waiting child6 table1) (waiting child5 table1) (not_allergic_gluten child7) (at_kitchen_bread bread7) (waiting child3 table3) (notexist sandw4) (at_kitchen_bread bread6) (no_gluten_content content9) (at_kitchen_content content5) (not_allergic_gluten child6) (no_gluten_content content4) (at tray2 kitchen) (waiting child8 table2) (not_allergic_gluten child5) (waiting child4 table1) (waiting child1 table3) (at_kitchen_bread bread2) (allergic_gluten child2) (no_gluten_bread bread7) (notexist sandw10) (waiting child9 table2) (waiting child2 table1) (no_gluten_bread bread6) (at tray3 kitchen) (waiting child7 table3) (notexist sandw2) (allergic_gluten child3) (notexist sandw7) (at_kitchen_content content9) (not_allergic_gluten child1) (no_gluten_bread bread2) (notexist sandw1) (at tray1 kitchen) (at_kitchen_sandwich sandw11) (at_kitchen_sandwich sandw12) (at_kitchen_sandwich sandw5) (at_kitchen_sandwich sandw6) (at_kitchen_sandwich sandw8) (at_kitchen_sandwich sandw9) )
  (:goal (and (not_allergic_gluten child4)(not_allergic_gluten child8)(at_kitchen_content content4)(no_gluten_content content5)(allergic_gluten child9)(notexist sandw3)(waiting child6 table1)(waiting child5 table1)(not_allergic_gluten child7)(at_kitchen_bread bread7)(waiting child3 table3)(notexist sandw4)(no_gluten_content content9)(not_allergic_gluten child6)(no_gluten_content content4)(at tray2 kitchen)(waiting child8 table2)(not_allergic_gluten child5)(waiting child4 table1)(waiting child1 table3)(at_kitchen_bread bread2)(allergic_gluten child2)(no_gluten_bread bread7)(waiting child9 table2)(waiting child2 table1)(no_gluten_bread bread6)(at tray3 kitchen)(waiting child7 table3)(notexist sandw2)(allergic_gluten child3)(notexist sandw7)(at_kitchen_content content9)(not_allergic_gluten child1)(no_gluten_bread bread2)(notexist sandw1)(at tray1 kitchen)(at_kitchen_sandwich sandw11)(at_kitchen_sandwich sandw12)(at_kitchen_sandwich sandw5)(at_kitchen_sandwich sandw6)(at_kitchen_sandwich sandw8)(at_kitchen_sandwich sandw9)(at_kitchen_sandwich sandw10)(no_gluten_sandwich sandw10)(not (at_kitchen_bread bread1))(not (at_kitchen_bread bread3))(not (at_kitchen_bread bread4))(not (at_kitchen_bread bread5))(not (at_kitchen_bread bread6))(not (at_kitchen_bread bread8))(not (at_kitchen_bread bread9))(not (at_kitchen_content content1))(not (at_kitchen_content content2))(not (at_kitchen_content content3))(not (at_kitchen_content content5))(not (at_kitchen_content content6))(not (at_kitchen_content content7))(not (at_kitchen_content content8))(not (at_kitchen_sandwich sandw1))(not (at_kitchen_sandwich sandw2))(not (at_kitchen_sandwich sandw3))(not (at_kitchen_sandwich sandw4))(not (at_kitchen_sandwich sandw7))(not (no_gluten_bread bread1))(not (no_gluten_bread bread3))(not (no_gluten_bread bread4))(not (no_gluten_bread bread5))(not (no_gluten_bread bread8))(not (no_gluten_bread bread9))(not (no_gluten_content content1))(not (no_gluten_content content2))(not (no_gluten_content content3))(not (no_gluten_content content6))(not (no_gluten_content content7))(not (no_gluten_content content8))(not (ontray sandw1 tray1))(not (ontray sandw1 tray2))(not (ontray sandw1 tray3))(not (ontray sandw2 tray1))(not (ontray sandw2 tray2))(not (ontray sandw2 tray3))(not (ontray sandw3 tray1))(not (ontray sandw3 tray2))(not (ontray sandw3 tray3))(not (ontray sandw4 tray1))(not (ontray sandw4 tray2))(not (ontray sandw4 tray3))(not (ontray sandw5 tray1))(not (ontray sandw5 tray2))(not (ontray sandw5 tray3))(not (ontray sandw6 tray1))(not (ontray sandw6 tray2))(not (ontray sandw6 tray3))(not (ontray sandw7 tray1))(not (ontray sandw7 tray2))(not (ontray sandw7 tray3))(not (ontray sandw8 tray1))(not (ontray sandw8 tray2))(not (ontray sandw8 tray3))(not (ontray sandw9 tray1))(not (ontray sandw9 tray2))(not (ontray sandw9 tray3))(not (ontray sandw10 tray1))(not (ontray sandw10 tray2))(not (ontray sandw10 tray3))(not (ontray sandw11 tray1))(not (ontray sandw11 tray2))(not (ontray sandw11 tray3))(not (ontray sandw12 tray1))(not (ontray sandw12 tray2))(not (ontray sandw12 tray3))(not (no_gluten_sandwich sandw1))(not (no_gluten_sandwich sandw2))(not (no_gluten_sandwich sandw3))(not (no_gluten_sandwich sandw4))(not (no_gluten_sandwich sandw5))(not (no_gluten_sandwich sandw6))(not (no_gluten_sandwich sandw7))(not (no_gluten_sandwich sandw8))(not (no_gluten_sandwich sandw9))(not (no_gluten_sandwich sandw11))(not (no_gluten_sandwich sandw12))(not (allergic_gluten child1))(not (allergic_gluten child4))(not (allergic_gluten child5))(not (allergic_gluten child6))(not (allergic_gluten child7))(not (allergic_gluten child8))(not (not_allergic_gluten child2))(not (not_allergic_gluten child3))(not (not_allergic_gluten child9))(not (served child1))(not (served child2))(not (served child3))(not (served child4))(not (served child5))(not (served child6))(not (served child7))(not (served child8))(not (served child9))(not (waiting child1 kitchen))(not (waiting child1 table1))(not (waiting child1 table2))(not (waiting child2 kitchen))(not (waiting child2 table2))(not (waiting child2 table3))(not (waiting child3 kitchen))(not (waiting child3 table1))(not (waiting child3 table2))(not (waiting child4 kitchen))(not (waiting child4 table2))(not (waiting child4 table3))(not (waiting child5 kitchen))(not (waiting child5 table2))(not (waiting child5 table3))(not (waiting child6 kitchen))(not (waiting child6 table2))(not (waiting child6 table3))(not (waiting child7 kitchen))(not (waiting child7 table1))(not (waiting child7 table2))(not (waiting child8 kitchen))(not (waiting child8 table1))(not (waiting child8 table3))(not (waiting child9 kitchen))(not (waiting child9 table1))(not (waiting child9 table3))(not (at tray1 table1))(not (at tray1 table2))(not (at tray1 table3))(not (at tray2 table1))(not (at tray2 table2))(not (at tray2 table3))(not (at tray3 table1))(not (at tray3 table2))(not (at tray3 table3))(not (notexist sandw5))(not (notexist sandw6))(not (notexist sandw8))(not (notexist sandw9))(not (notexist sandw10))(not (notexist sandw11))(not (notexist sandw12)))))