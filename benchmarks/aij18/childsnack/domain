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
	 :parameters (?s - sandwich ?b - bread-portion ?c - content-portion)
	 :precondition (and (at-kitchen-bread ?b)
			    (at-kitchen-content ?c)
			    (no-gluten-bread ?b)
			    (no-gluten-content ?c)
			    (notexist ?s))
	 :effect (and
		   (not (at-kitchen-bread ?b))
		   (not (at-kitchen-content ?c))
		   (at-kitchen-sandwich ?s)
		   (no-gluten-sandwich ?s)
                   (not (notexist ?s))
		   ))


(:action make-sandwich
	 :parameters (?s - sandwich ?b - bread-portion ?c - content-portion)
	 :precondition (and (at-kitchen-bread ?b)
			    (at-kitchen-content ?c)
                            (notexist ?s)
			    )
	 :effect (and
		   (not (at-kitchen-bread ?b))
		   (not (at-kitchen-content ?c))
		   (at-kitchen-sandwich ?s)
                   (not (notexist ?s))
		   ))


(:action put-on-tray
	 :parameters (?s - sandwich ?t - tray)
	 :precondition (and  (at-kitchen-sandwich ?s)
			     (at ?t kitchen))
	 :effect (and
		   (not (at-kitchen-sandwich ?s))
		   (ontray ?s ?t)))


(:action serve-sandwich-no-gluten
 	:parameters (?s - sandwich ?c - child ?t - tray ?p - place)
	:precondition (and
		       (allergic-gluten ?c)
		       (ontray ?s ?t)
		       (waiting ?c ?p)
		       (no-gluten-sandwich ?s)
                       (at ?t ?p)
		       )
	:effect (and (not (ontray ?s ?t))
		     (served ?c)))

(:action serve-sandwich
	:parameters (?s - sandwich ?c - child ?t - tray ?p - place)
	:precondition (and (not-allergic-gluten ?c)
	                   (waiting ?c ?p)
			   (ontray ?s ?t)
			   (at ?t ?p))
	:effect (and (not (ontray ?s ?t))
		     (served ?c)))

(:action move-tray
	 :parameters (?t - tray ?p1 ?p2 - place)
	 :precondition (and (at ?t ?p1))
	 :effect (and (not (at ?t ?p1))
		      (at ?t ?p2)))
			    

)