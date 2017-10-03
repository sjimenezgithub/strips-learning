(define (problem test-4-5)
(:domain blocks)
(:objects D C B A - object)
(:init
	   (handempty)
           (ontable D)
           (ontable B)
	   (on A D)
           (on C B)	   
	   (clear A)
	   (clear C)	   	   
       )

(:goal (AND
	   (not (handempty))

	   (not (holding A))
	   (not (holding B))
	   (holding C)
	   (not (holding D))

           (ontable A)
           (not (ontable C))
           (ontable D)
           (ontable B)

	   (not (on D A))
	   (not (on D B))
	   (not (on D C))
	   (not (on D D))	   	   

           (not (on C A))
           (not (on C B))
           (not (on C C))
	   (not (on C D))	   

	   (not (on B A))
	   (not (on B B))
	   (not (on B C))
	   (not (on B D))

	   (not (on A A))
	   (not (on A B))	   
	   (not (on A C))
	   (not (on A D))

	   (clear A)
	   (clear B)
	   (not (clear C))
	   (clear D)
)))