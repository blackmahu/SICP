(define (count-pairs x)
  (define (member? a l)
	(cond ((null? l) #f)
		  ((eq? a (car l)) #t)
		  (else (member? a (cdr l)))))
  (let ((counted-list '()))
	(define (count-pair y)
	  (cond ((not (pair? y)) 0)
		((member? y counted-list) 0)
		(else (set! counted-list (cons y counted-list))
			  (+ (count-pair (car y))
				 (count-pair (cdr y))
				 1))))
	(count-pair x)))
;((a) (b)) return 3
(define u (cons (list 'a) (list 'b)))

;((a b) b) return 3 other than 4
(define x (list 'b))
(define v (cons (cons 'a x) x))

;(((a) b) (a) b) return 4 other than 7
(define y (list 'a))
(define z (cons x y))
(define w (cons z z))

; never returns still
(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))
(define (make-circle x)
  (set-cdr! (last-pair x) x)
  x)
(define m (make-circle (list 'a 'b 'c)))
