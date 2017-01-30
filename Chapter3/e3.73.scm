(define (RC R C dt)
  (lambda (si v0)
	(cons-stream v0
				 (add-stream (scale-stream si R)
							 (scale-stream
							   (integral si 0 dt)
							   (/ 1 C))))))

(define RC1 (RC 5 1 0.5))
