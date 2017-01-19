(define (mystery x)
  (define (loop x y)
	(if (null? x)
	  y
	  (let ((temp (cdr x)))
		(set-cdr! x y)
		(loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))

; the mystery procedure returns a reverse list of x
; after evaluating w
; w : (d c b a)
; v : (a)
; the node of list v is the same last node of list w
