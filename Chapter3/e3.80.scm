(load "c3.5.4.scm")

(define (RLC R L C dt)
  (lambda (vC0 iL0)
	(define vC (integral (delay dvC) vC0 dt))
	(define iL (integral (delay diL) iL0 dt))
	(define dvC (scale-stream iL (/ -1 C)))
	(define diL (add-streams (scale-stream vC (/ 1 L))
							 (scale-stream iL (- (/ R L)))))
	(define (make-pair-stream s1 s2)
	  (cons-stream (cons (stream-car s1) (stream-car s2))
				   (make-pair-stream (stream-cdr s1)
									 (stream-cdr s2))))
	(make-pair-stream vC iL)))

(define rlc1 (RLC 1 1 0.2 0.1))
(define x (rlc1 10 0))

; first ten pairs of stream x
;(10 . 0)
;(10 . 1.)
;(9.5 . 1.9)
;(8.55 . 2.66)
;(7.220000000000001 . 3.249)
;(5.5955 . 3.6461)
;(3.77245 . 3.84104)
;(1.8519299999999999 . 3.834181)
;(-.0651605000000004 . 3.6359559)
;(-1.8831384500000004 . 3.2658442599999997)
