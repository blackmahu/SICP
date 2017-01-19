(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

(define (is-loop? x)
  (let ((target x)
		(count 0))
	(define (loop? y)
	  (cond ((null? y) #f)
			((and (eq? y target) (not (= count 0))) #t)
			(else (set! count (+ count 1))
				  (loop? (cdr y)))))
	(loop? x)))
