(load "c3.5.3.scm")

(define (make-zero-crossing input-stream last-value)
  (cons-stream
	(sign-change-detector
	  (stream-car input-stream)
	  last-value)
	(make-zero-crossings
	  (stream-cdr input-stream)
	  (stream-car input-stream))))

(define (smooth input-stream)
  (scale-stream (add-stream input-stream
							(stream-cdr input-stream))
				1/2))

(define zero-crossings
  (make-zero-crossings (smooth sense-data) 0))
