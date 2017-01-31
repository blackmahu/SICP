(load "c3.5.4.scm")

; 如果直接返回值的话会报dy未定义，所以不能提前求值，只能返回表达式，待solve返回y时再计算就有dy的定义了。
(define (integral delayed-integrand initial-value dt)
  (cons-stream
	initial-value
	(if (stream-null? delayed-integrand)
	  the-empty-stream
	  (let ((integrand (force delayed-integrand)))
		(integral (cdr integrand)
				  (+ (* dt (stream-car integrand))
					 initial-value)
			   dt)))))

(stream-ref (solve (lambda (y) y)
                  1
                  0.001)
           1000)
