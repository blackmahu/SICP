(load "c3.5.3.scm")

(define (make-zero-crossing input-stream last-value last-signal)
  (let ((avpt (/ (+ (stream-car input-stream)
					last-signal))))
	(cons-stream
	  (sign-change-detector avpt last-value)
	  (make-zero-crossings
		(stream-cdr input-stream)
		avpt
		(stream-car input-stream)))))
(define zero-crossings
  (make-zero-crossings sense-data 0))
