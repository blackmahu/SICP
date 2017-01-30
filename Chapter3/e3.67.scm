(load "c3.5.3.scm")

(define (pairs-all s t)
  (define (pairs-1 s t)
	(cons-stream
	  (list (stream-car s) (stream-car t))
	  (interleave
		(stream-map (lambda (x) (list (stream-car s) x))
					(stream-cdr t))
		(pairs-1 (stream-cdr s) (stream-cdr t)))))
  (define (pairs-2 s t)
	(cons-stream
	  (list (stream-car t) (stream-car s))
	  (interleave
		(stream-map (lambda (x) (list x (stream-car s)))
					(stream-cdr t))
		(pairs-2 (stream-cdr s) (stream-cdr t)))))
  (interleave
	(pairs-1 s t)
	(pairs-2 s t)))

(define (pairs-desc s t)
  (stream-filter (lambda (x)
				   (> (car x) (cadr x)))
				 (pairs-all s t)))

(define x (pairs-all integers integers))
(define y (pairs-desc integers integers))

  (define (pairs-3 s t)
	(cons-stream
	  (list (stream-car t) (stream-car s))
	  (interleave
		(stream-map (lambda (x) (list x (stream-car s)))
					(stream-cdr t))
		(pairs-3 (stream-cdr s) (stream-cdr t)))))
(define z (pairs-3 integers integers))

; pairs-3 will do the job same as pairs-desc
