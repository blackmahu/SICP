(define (make-acc balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (check)
	balance)
  (define (dispatch m)
	(cond ((eq? m 'withdraw) withdraw)
		  ((eq? m 'deposit) deposit)
		  ((eq? m 'check) check)
		  (else (error "Unknown request: MAKE-ACC" m))))
  dispatch)

(define (make-account acc password)
  (define (dispatch p m)
	(cond ((not (eq? password p))
		   (lambda () "Incorrect passowrd"))
		  ((eq? m 'withdraw) (acc 'withdraw))
		  ((eq? m 'deposit) (acc 'deposit))
		  ((eq? m 'check) (acc 'check))
		  ((eq? m 'make-joint) acc)
		  (else (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch)

(define (make-joint account password joint-password)
  (make-account (account password 'make-joint) joint-password))

(define peter-acc (make-account (make-acc 100) 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
