(define (make-mutex)
  (let ((cell (list false)))
	(define (the-mutex m)
	  (cond ((eq? m  'acquire)
			 (if (test-and-set! cell)
			   (the-mutex 'acquire)))
			((eq? m 'release) (clear! cell))))
	the-mutex))
(define (clear! cell) (set-car! cell false))
(define (test-and-set! cell)
  (if (car cell) true (begin (set-car! cell true) false)))

; in term of mutexes

; in term of atomic test-and-set! operations