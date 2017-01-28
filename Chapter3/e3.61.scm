(load "e3.60.scm")

(define (invert-unit-series S)
  (define invert
	(cons-stream 1
				 (stream-map (lambda (x)(* -1 x))
							 (mul-series
							   (stream-cdr S) invert))))
  invert)

(define x (integrate-series ones))
(define y (invert-unit-series x))
