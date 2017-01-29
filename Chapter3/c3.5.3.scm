(load "c3.5.2.scm")

(define (sqrt-improve guess x)
  (define (average x y)
	(/ (+ x y) 2))
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
	(cons-stream
	  1.0
	  (stream-map (lambda (guess) (sqrt-improve guess x))
				  guesses)))
  guesses)

(load "e3.55.scm") ; for partial-sums
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
			   (stream-map - (pi-summands (+ n 2)))))
(define pi-stream ; scale-stream is defined in c3.5.2.scm
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0)) ;Sn-1
		(s1 (stream-ref s 1)) ;Sn
		(s2 (stream-ref s 2))) ;Sn+1
	(cons-stream (- s2 (/ (square (- s2 s1))
						  (+ s0 (* -2 s1) s2)))
				 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))
