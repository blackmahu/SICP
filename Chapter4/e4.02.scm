; a
; If the procedure applications appear before
; assignments, eval will first check expressions
; with application?, according to definition of 
; procedure application, it's a pair and then the
; expression will be applyed as (define x 3) and
; define is a special form not a procedure.

; b
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
		((variable? exp) (lookup-variable-value exp env))
		((quoted? exp) (text-of-quotation exp))
		((application? exp)
		 (apply (eval (operator exp) env)
				(list-of-values (operands exp) env)))
		((assignment? exp) (eval-assignment exp env))
		((definition? exp) (eval-definition exp env))
		((if? exp) (eval-if exp env))
		((lambda? exp) (make-procedure (lambda-parameters exp)
									   (lambda-body exp)
									   env))
		((begin? exp)
		 (eval-sequence (begin-action exp) env))
		((cond? exp) (eval (cond->if exp) env))
		(else
		  (error "Unknown expression type: EVAL" exp))))

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
