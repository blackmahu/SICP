(load "c3.5.2.scm")

(define (integrate-series S)
  (define (mul-streams s1 s2)
	(stream-map * s1 s2))
  (define (inte-s s)
	(cons-stream (stream-car s)
				 (mul-streams
				   (stream-map / ones (stream-cdr integers))
				   (stream-cdr s))))
  (inte-s S))

(define x (integrate-series ones))
