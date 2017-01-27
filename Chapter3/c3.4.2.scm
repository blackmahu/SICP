(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
					   (account2 'balance))))
	((account1 'withdraw) difference)
	((account2 'deposit) difference)))

(define (make-serializer)
  (let ((mutex (make-mutex)))
	(lambda (p)
	  (define (serialized-p . args)
		(mutex 'acquire)
		(let ((val (apply p args)))
		  (mutex 'release)
		  val))
	  serialized-p)))

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
