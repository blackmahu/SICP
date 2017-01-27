(define (make-mutex)
  (let ((cell (list false)))
	(define (the-mutex m)
	  (cond ((eq? m  'acquire) (test-and-set! cell))
			    ; modify a bit otherwise the mutex would not return until this one can be acquired
			((eq? m 'release) (clear! cell))))
	the-mutex))

(define (clear! cell) (set-car! cell false))
(define (test-and-set! cell)
  (if (car cell) true (begin (set-car! cell true) false)))

; in term of mutexes
(define (make-semaphore n)
  (define (make-cells x)
	(if (= x 0)
	  '()
	  (cons (make-mutex) (make-cells (- x 1)))))
  (let ((cells (make-cells n)))
	(define (the-semaphore m)
	  (cond ((eq? m  'acquire)
			 (if (test-and-set-semaphore! cells)
			   (the-semaphore 'acquire)))
			((eq? m 'release) (clear-semaphore! cells))))
	the-semaphore))
(define (clear-semaphore! cells)
  (if (eq? cells '()) '()
	(begin ((car cells) 'release)
		   (clear-semaphore! (cdr cells))))
  cells)

(define (test-and-set-semaphore! cells)
  (if (eq? cells '()) false
	(if ((car cells) 'acquire)
	  (test-and-set-semaphore! (cdr cells))
	  false)))

