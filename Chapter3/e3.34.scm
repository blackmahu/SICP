; In order to get square root of b, we have to
; forget value of a and set value of b, in this
; case both input of the multiplier is unspecified,
; it can't get value of a with only one connector b.

(load "c3.3.5.scm")

(define (squarer a b)
  (multiplier a a b))

(define a (make-connector))
(define b (make-connector))

(probe "value of a" a)
(probe "value of b" b)

(set-value! a 3 'user)

(forget-value! a 'user)
(set-value! b 9 'user)
