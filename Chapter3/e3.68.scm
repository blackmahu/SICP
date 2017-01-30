(load "c3.5.3.scm")

(define (pairs s t)
  (interleave
	(stream-map (lambda (x) (list (stream-car s) x))
				  t)
				(pairs (stream-cdr s) (stream-cdr t))))

(define x (pairs integers integers))

; no this will not work
; without the first element of stream, the first expression of interleave will trigered evaling nonstop until recursion depth of the intepreter is exceeded.
