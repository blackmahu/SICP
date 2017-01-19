(define (count-pairs x)
  (if (not (pair? x))
	0
	(+ (count-pairs (car x))
	   (count-pairs (cdr x))
	   1)))

;((a) (b)) return 3
(define u (cons (list 'a) (list 'b)))

;((a b) b) return 4
(define x (list 'b))
(define v (cons (cons 'a x) x))

;(((a) b) (a) b) return 7
(define y (list 'a))
(define z (cons x y))
(define w (cons z z))

; never returns
(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))
(define (make-circle x)
  (set-cdr! (last-pair x) x)
  x)
(define m (make-circle (list 'a 'b 'c)))
