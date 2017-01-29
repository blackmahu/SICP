(load "c3.5.3.scm")

(define (stream-limit stream tolerance)
  (define (s-l s)
	(let ((s0 (stream-car s))
		  (s1 (stream-car (stream-cdr s))))
	  (if (< (abs (- s1 s0)) tolerance)
		s1
		(s-l (stream-cdr s)))))
  (s-l stream))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
