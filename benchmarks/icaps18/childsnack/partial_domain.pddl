;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The child-snack domain 2013
;;
;; This domain is for planning how to make and serve sandwiches for a group of
;; children in which some are allergic to gluten. There are two actions for
;; making sandwiches from their ingredients. The first one makes a sandwich and
;; the second one makes a sandwich taking into account that all ingredients are
;; gluten-free. There are also actions to put a sandwich on a tray, to move a tray
;; from one place to another and to serve sandwiches.
;; 
;; Problems in this domain define the ingredients to make sandwiches at the initial
;; state. Goals consist of having all kids served with a sandwich to which they
;; are not allergic.
;; 
;; Author: Raquel Fuentetaja and Tomás de la Rosa
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (domain child-snack)
(:requirements :typing)
(:types child bread-portion content-portion sandwich tray place)
(:constants kitchen - place)

(:predicates (at_kitchen_bread ?b - bread-portion)
	     (at_kitchen_content ?c - content-portion)
     	     (at_kitchen_sandwich ?s - sandwich)
     	     (no_gluten_bread ?b - bread-portion)
       	     (no_gluten_content ?c - content-portion)
      	     (ontray ?s - sandwich ?t - tray)
       	     (no_gluten_sandwich ?s - sandwich)
	     (allergic_gluten ?c - child)
     	     (not_allergic_gluten ?c - child)
	     (served ?c - child)
	     (waiting ?c - child ?p - place)
             (at ?t - tray ?p - place)
	     (notexist ?s - sandwich)
  )

(:action make_sandwich_no_gluten 
	 :parameters (?o1 - sandwich ?o2 - bread-portion ?o3 - content-portion)
	 :precondition (and (at_kitchen_bread ?o2)
			    (at_kitchen_content ?o3)
			    (no_gluten_bread ?o2)
			    (no_gluten_content ?o3)
			    (notexist ?o1))
	 :effect (and
		   (not (at_kitchen_bread ?o2))
		   (not (at_kitchen_content ?o3))
		   (at_kitchen_sandwich ?o1)
		   (no_gluten_sandwich ?o1)
                   (not (notexist ?o1))
		   ))


(:action make_sandwich
	 :parameters (?o1 - sandwich ?o2 - bread-portion ?o3 - content-portion)
	 :precondition (and (at_kitchen_bread ?o2)
			    (at_kitchen_content ?o3)
                            (notexist ?o1)
			    )
	 :effect (and
		   (not (at_kitchen_bread ?o2))
		   (not (at_kitchen_content ?o3))
		   (at_kitchen_sandwich ?o1)
                   (not (notexist ?o1))
		   ))


(:action put_on_tray
	 :parameters (?o1 - sandwich ?o2 - tray)
	 :precondition (and  (at_kitchen_sandwich ?o1)
			     (at ?o2 kitchen))
	 :effect (and
		   (not (at_kitchen_sandwich ?o1))
		   (ontray ?o1 ?o2)))
			    
)