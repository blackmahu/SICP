; presume a unit circle center at (1,1)

(define (random-in-range low high)
  (let ((range (- high low)))
	(+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (monte-carlo trials (P x1 x2 y1 y2))
	 (* (abs (- x1 x2)) (abs (- y1 y2)))))

; P is a procedure returns a predicate
; not just a predicate asked by the book
; don't know how to do that.
(define (P x1 x2 y1 y2)
  (lambda ()
	  (let ((x (random-in-range (min x1 x2) (max x1 x2)))
			(y (random-in-range (min y1 y2) (max y1 y2))))
		(<= (+ (square (- x 1)) (square (- y 1))) 1))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
	(cond ((= trials-remaining 0)
		   (/ trials-passed trials))
		  ((experiment)
		   (iter (- trials-remaining 1)
				 (+ trials-passed 1)))
		  (else
			(iter (- trials-remaining 1)
				  trials-passed))))
  (iter trials 0))

(estimate-integral P 0.0 2.0 0.0 2.0 100000.0)
