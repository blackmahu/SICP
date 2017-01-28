(load "e3.59-b.scm")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
			   (add-streams (mul-series s1 (stream-cdr s2))
							(stream-map (lambda (x)
										  (* x (stream-car s2))) (stream-cdr s1)))))

(define s
  (add-streams (mul-series sine-series sine-series)
			   (mul-series cosine-series cosine-series)))
