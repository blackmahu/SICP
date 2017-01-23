(load "c3.3.5.scm")

(define (averager a b c)
  (let ((u (make-connector))
		(v (make-connector)))
	(adder a b u)
	(constant 1/2 v)
	(multiplier u v c)
	'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(probe "value of a" a)
(probe "value of b" b)
(probe "value of c" c)

(averager a b c)

(set-value! a 3 'user)
(set-value! b 5 'user)

(forget-value! a 'user)
(set-value! c 7 'user)
