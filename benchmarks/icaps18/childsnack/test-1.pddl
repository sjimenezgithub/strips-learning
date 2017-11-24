(define (problem prob-snack)
  (:domain child-snack)
  (:objects kitchen -  place child1 -  child child2 -  child child3 -  child child4 -  child child5 -  child child7 -  child child6 -  child bread1 -  bread-portion bread2 -  bread-portion bread3 -  bread-portion bread4 -  bread-portion bread5 -  bread-portion bread6 -  bread-portion bread7 -  bread-portion content1 -  content-portion content2 -  content-portion content3 -  content-portion content4 -  content-portion content5 -  content-portion content6 -  content-portion content7 -  content-portion tray1 -  tray tray2 -  tray table1 -  place table2 -  place table3 -  place sandw1 -  sandwich sandw2 -  sandwich sandw3 -  sandwich sandw4 -  sandwich sandw5 -  sandwich sandw6 -  sandwich sandw7 -  sandwich sandw8 -  sandwich sandw9 -  sandwich sandw10 -  sandwich )
  (:init (at_kitchen_bread bread6) (no_gluten_bread bread5) (notexist sandw6) (waiting child3 table1) (no_gluten_content content7) (at_kitchen_content content5) (notexist sandw1) (waiting child6 table3) (at_kitchen_content content7) (allergic_gluten child7) (no_gluten_bread bread2) (waiting child1 table1) (at_kitchen_content content1) (not_allergic_gluten child3) (notexist sandw10) (no_gluten_content content6) (at_kitchen_bread bread7) (notexist sandw5) (waiting child4 table3) (notexist sandw3) (at_kitchen_content content2) (not_allergic_gluten child6) (allergic_gluten child4) (notexist sandw4) (at tray2 kitchen) (not_allergic_gluten child2) (waiting child7 table1) (at_kitchen_bread bread2) (at_kitchen_bread bread5) (notexist sandw2) (notexist sandw9) (waiting child2 table1) (at_kitchen_content content4) (waiting child5 table1) (at_kitchen_bread bread1) (at_kitchen_content content3) (at_kitchen_content content6) (at tray1 kitchen) (not_allergic_gluten child5) (notexist sandw7) (notexist sandw8) (not_allergic_gluten child1) (at_kitchen_bread bread4) (at_kitchen_bread bread3) )
  (:goal (and (no_gluten_bread bread5)(waiting child3 table1)(no_gluten_content content7)(notexist sandw1)(waiting child6 table3)(at_kitchen_content content7)(allergic_gluten child7)(no_gluten_bread bread2)(waiting child1 table1)(not_allergic_gluten child3)(no_gluten_content content6)(notexist sandw5)(waiting child4 table3)(not_allergic_gluten child6)(allergic_gluten child4)(notexist sandw4)(at tray2 kitchen)(not_allergic_gluten child2)(waiting child7 table1)(at_kitchen_bread bread5)(waiting child2 table1)(waiting child5 table1)(at tray1 kitchen)(not_allergic_gluten child5)(notexist sandw7)(not_allergic_gluten child1)(at_kitchen_sandwich sandw10)(at_kitchen_sandwich sandw3)(at_kitchen_sandwich sandw6)(at_kitchen_sandwich sandw8)(at_kitchen_sandwich sandw9)(at_kitchen_sandwich sandw2)(no_gluten_sandwich sandw2)(not (at_kitchen_bread bread1))(not (at_kitchen_bread bread2))(not (at_kitchen_bread bread3))(not (at_kitchen_bread bread4))(not (at_kitchen_bread bread6))(not (at_kitchen_bread bread7))(not (at_kitchen_content content1))(not (at_kitchen_content content2))(not (at_kitchen_content content3))(not (at_kitchen_content content4))(not (at_kitchen_content content5))(not (at_kitchen_content content6))(not (at_kitchen_sandwich sandw1))(not (at_kitchen_sandwich sandw4))(not (at_kitchen_sandwich sandw5))(not (at_kitchen_sandwich sandw7))(not (no_gluten_bread bread1))(not (no_gluten_bread bread3))(not (no_gluten_bread bread4))(not (no_gluten_bread bread6))(not (no_gluten_bread bread7))(not (no_gluten_content content1))(not (no_gluten_content content2))(not (no_gluten_content content3))(not (no_gluten_content content4))(not (no_gluten_content content5))(not (ontray sandw1 tray1))(not (ontray sandw1 tray2))(not (ontray sandw2 tray1))(not (ontray sandw2 tray2))(not (ontray sandw3 tray1))(not (ontray sandw3 tray2))(not (ontray sandw4 tray1))(not (ontray sandw4 tray2))(not (ontray sandw5 tray1))(not (ontray sandw5 tray2))(not (ontray sandw6 tray1))(not (ontray sandw6 tray2))(not (ontray sandw7 tray1))(not (ontray sandw7 tray2))(not (ontray sandw8 tray1))(not (ontray sandw8 tray2))(not (ontray sandw9 tray1))(not (ontray sandw9 tray2))(not (ontray sandw10 tray1))(not (ontray sandw10 tray2))(not (no_gluten_sandwich sandw1))(not (no_gluten_sandwich sandw3))(not (no_gluten_sandwich sandw4))(not (no_gluten_sandwich sandw5))(not (no_gluten_sandwich sandw6))(not (no_gluten_sandwich sandw7))(not (no_gluten_sandwich sandw8))(not (no_gluten_sandwich sandw9))(not (no_gluten_sandwich sandw10))(not (allergic_gluten child1))(not (allergic_gluten child2))(not (allergic_gluten child3))(not (allergic_gluten child5))(not (allergic_gluten child6))(not (not_allergic_gluten child4))(not (not_allergic_gluten child7))(not (served child1))(not (served child2))(not (served child3))(not (served child4))(not (served child5))(not (served child6))(not (served child7))(not (waiting child1 kitchen))(not (waiting child1 table2))(not (waiting child1 table3))(not (waiting child2 kitchen))(not (waiting child2 table2))(not (waiting child2 table3))(not (waiting child3 kitchen))(not (waiting child3 table2))(not (waiting child3 table3))(not (waiting child4 kitchen))(not (waiting child4 table1))(not (waiting child4 table2))(not (waiting child5 kitchen))(not (waiting child5 table2))(not (waiting child5 table3))(not (waiting child6 kitchen))(not (waiting child6 table1))(not (waiting child6 table2))(not (waiting child7 kitchen))(not (waiting child7 table2))(not (waiting child7 table3))(not (at tray1 table1))(not (at tray1 table2))(not (at tray1 table3))(not (at tray2 table1))(not (at tray2 table2))(not (at tray2 table3))(not (notexist sandw2))(not (notexist sandw3))(not (notexist sandw6))(not (notexist sandw8))(not (notexist sandw9))(not (notexist sandw10)))))