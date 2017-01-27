; by using the deadlock-avoidance method, each process
; of concurrent executing will acquire the same shared
; resource at the first step and this kind of conflict
; can be managed by the mutex model.

(load "c3.4.2.scm")

(define (make-account-and-serializer balance number)
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "Insufficient funds"))
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  (let ((balance-serializer (make-serializer)))
	(define (dispatch m)
	  (cond ((eq? m 'withdraw) withdraw)
			((eq? m 'deposit) deposit)
			((eq? m 'balance) balance)
			((eq? m 'serializer) balance-serializer)
			((eq? m 'get-number) number)
			(else (error "Unknown request: MAKE-ACCOUNT" m))))
	dispatch))

(define (serialized-exchange account1 account2)
  (let ((number1 (account1 'get-number))
		(number2 (account2 'get-number))
		(serializer1 (account1 'serializer))
		(serializer2 (account2 'serializer)))
	(if (< number1 number2)
	  ((serializer1 (serializer2 exchange))
	   account1
	   account2)
	  ((serializer2 (serializer1 exchange))
	   account1
	   account2))))
