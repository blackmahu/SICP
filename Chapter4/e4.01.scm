; left to right
(define (list-of-values exps env)
  (let ((first (eval (first-operand exps) env)))
	(cons first
		  (list-of-values (rest-operands exps) env))))

; right to left
(define (list-of-values exps env)
  (let ((rest (list-of-values (rest-operands exps) env)))
	(cons (eval (first-operand exps) env)
		  rest)))
