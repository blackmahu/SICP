(load "c3.5.1.scm")
(load "c3.5.5.scm")

; assume generate request as 'generate
; reset request as ('reset val)
(define (rand op-stream)
  (define (rand-generator op base)
	(cond ((stream-null? op) the-empty-stream)
		  ((eq? 'generate (stream-car op))
		   (let ((next (rand-update base)))
			 (cons-stream
			   next
			   (rand-generator (stream-cdr op) next))))
		  ((eq? 'reset (car (stream-car op)))
		   (let ((next (rand-update (cadr (stream-car op)))))
		   (cons-stream
			 next
			 (rand-generator (stream-cdr op) next))))
		  (else (error "Incorrect request:" (stream-car op)))))
  (rand-generator op-stream random-init))

(define op (cons-stream 'generate (cons-stream 'generate (cons-stream (list 'reset 1) (cons-stream 'generate (cons-stream 'generate '()))))))

(define x (rand op))
(display-stream x)
