(load "c3.3.5.scm")

(define (divider dividend divisor quotient)
  (define (process-new-value)
    (cond ((and (has-value? divisor) (= (get-value divisor) 0))
           (error "divisor can't be zero" divisor))
          ((and (has-value? dividend) (has-value? divisor))
           (set-value! quotient
                       (/ (get-value dividend) (get-value divisor))
                       me))
          ((and (has-value? quotient) (has-value? dividend))
           (set-value! divisor
                       (/ (get-value diviend)
                          (get-value quotient))
                       me))
          ((and (has-value? quotient) (has-value? divisor))
           (set-value! dividend
                       (* (get-value quotient)
                          (get-value divisor))
                       me))))
  (define (process-forget-value)
    (forget-value! quotient me)
    (forget-value! dividend me)
    (forget-value! divisor me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value) (process-new-value))
          ((eq? request 'I-lost-my-value)(process-forget-value))
          (else (error "Unknown request: MULTIPLIER"
                       request))))
  (connect dividend me)
  (connect divisor me)
  (connect quotient me)
  me)

(define (cv x)
  (let ((y (make-connector)))
	(connect y 'user)
	(set-value! y x 'user)
	y))

(define (c+ x y)
  (let ((z (make-connector)))
	(adder x y z)
	z))

(define (c* x y)
  (let ((z (make-connector)))
	(multiplier x y z)
	z))

(define (c/ x y)
  (let ((z (make-connector)))
	(divider x y z)
	z))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
		  x)
	  (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)

(forget-value! C 'user)
(set-value! F 212 'user)
