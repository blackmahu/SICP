(load "c3.5.2.scm")

(define (partial-sums s)
  (define partial
	(cons-stream (car s)
				 (add-streams partial (stream-cdr s))))
  partial)

(define x (partial-sums integers))
