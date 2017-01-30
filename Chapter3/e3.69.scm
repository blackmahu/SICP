(load "c3.5.3.scm")

; very slow, skip the methematical analyze of getting a fast solution, I'm tired of this shit
(define (triples s t u)
  (stream-filter (lambda (x) 
				   (let ((i (car x))
						 (j (caadr x))
						 (k (cadadr x)))
					 (and (<= i j) (<= j k))))
				 (pairs s (pairs t u))))

(define pythagorean
  (stream-filter (lambda (x)
				   (let ((i (car x))
						 (j (caadr x))
						 (k (cadadr x)))
					 (= (+ (square i) (square j))
						(square k))))
				 (triples integers integers integers)))
