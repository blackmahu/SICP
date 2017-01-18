(define (make-simplified-withdraw balance)
  (lambda (amount)
	(set! balance (- balance amount))
	balance))

(define (make-decrementer balance)
  (lambda (amount)
	(- balance amount)))
