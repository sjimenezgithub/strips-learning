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
(:requirements :typing :equality)
(:types child bread-portion content-portion sandwich tray place)


(:predicates (at-kitchen-bread ?b - bread-portion)
	     (at-kitchen-content ?c - content-portion)
     	     (at-kitchen-sandwich ?s - sandwich)
     	     (no-gluten-bread ?b - bread-portion)
       	     (no-gluten-content ?c - content-portion)
      	     (ontray ?s - sandwich ?t - tray)
       	     (no-gluten-sandwich ?s - sandwich)
	     (allergic-gluten ?c - child)
     	     (not-allergic-gluten ?c - child)
	     (served ?c - child)
	     (waiting ?c - child ?p - place)
             (at ?t - tray ?p - place)
	     (notexist ?s - sandwich)
  )

(:action make-sandwich-no-gluten 
	 :parameters (?o1 - sandwich ?b - bread-portion ?c - content-portion)
	 :precondition (and (at-kitchen-bread ?b)
			    (at-kitchen-content ?c)
			    (no-gluten-bread ?b)
			    (no-gluten-content ?c)
			    (notexist ?o1))
	 :effect (and
		   (not (at-kitchen-bread ?b))
		   (not (at-kitchen-content ?c))
		   (at-kitchen-sandwich ?o1)
		   (no-gluten-sandwich ?o1)
                   (not (notexist ?o1))
		   ))


(:action make-sandwich
	 :parameters (?o1 - sandwich ?o2 - bread-portion ?o3 - content-portion)
	 :precondition (and (at-kitchen-bread ?o2)
			    (at-kitchen-content ?o3)
                            (notexist ?o1)
			    )
	 :effect (and
		   (not (at-kitchen-bread ?o2))
		   (not (at-kitchen-content ?o3))
		   (at-kitchen-sandwich ?o1)
                   (not (notexist ?o1))
		   ))


(:action put-on-tray
	 :parameters (?o1 - sandwich ?o2 - tray)
	 :precondition (and  (at-kitchen-sandwich ?o1)
			     (at ?o2 kitchen))
	 :effect (and
		   (not (at-kitchen-sandwich ?o1))
		   (ontray ?o1 ?o2)))


(:action serve-sandwich-no-gluten
 	:parameters (?o1 - sandwich ?o2 - child ?o3 - tray ?o4 - place)
	:precondition (and
		       (allergic-gluten ?o2)
		       (ontray ?o1 ?o3)
		       (waiting ?o2 ?o4)
		       (no-gluten-sandwich ?o1)
                       (at ?o3 ?o4)
		       )
	:effect (and (not (ontray ?o1 ?o3))
		     (served ?o2)))

(:action serve-sandwich
	:parameters (?o1 - sandwich ?o2 - child ?o3 - tray ?o4 - place)
	:precondition (and (not-allergic-gluten ?o2)
	                   (waiting ?o2 ?o4)
			   (ontray ?o1 ?o3)
			   (at ?o3 ?o4))
	:effect (and (not (ontray ?o1 ?o3))
		     (served ?o2)))

(:action move-tray
	 :parameters (?o1 - tray ?o2 ?o3 - place)
	 :precondition (and (at ?o1 ?o2))
	 :effect (and (not (at ?o1 ?o2))
		      (at ?o1 ?o3)))
			    

)