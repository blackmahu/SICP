(define f
  (let ((sum 1))
	(lambda (x)
	  (set! sum (* sum x))
	  sum)))

(+ (f 0) (f 1))

; return 1 by MIT-Scheme
