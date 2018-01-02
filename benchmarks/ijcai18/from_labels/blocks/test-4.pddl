(define (problem test-4-4)
(:domain blocks)
(:objects D C B A - object)
(:init
       	   (holding A)
       	   (ontable D)	   
           (on C D)
	   (on B C)
	   (clear B) 	   
       )
(:goal (AND

	   (handempty)

	   (not (holding A))
	   (not (holding B))
	   (not (holding C))
	   (not (holding D))


           (not (ontable A))
           (not (ontable C))
           (ontable D)
           (ontable B)

	   (not (on D A))
	   (not (on D B))
	   (not (on D C))
	   (not (on D D))	   	   

           (not (on C A))
           (on C B)
           (not (on C C))
	   (not (on C D))	   


	   (not (on B A))
	   (not (on B B))
	   (not (on B C))
	   (not (on B D))

	   (not (on A A))
	   (not (on A B))	   
	   (not (on A C))
	   (on A D)	  

	   (clear A)
	   (not (clear B))	   
	   (clear C)	   
	   (not (clear D))
)))