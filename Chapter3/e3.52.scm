(define sum 0) ; 0
(define (accum x) (set! sum (+ x sum)) sum) ; 0
(define seq
  (stream-map accum
			  (stream-enumerate-interval 1 20))) ; 1
(define y (stream-filter even? seq)) ; 6
(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
				 seq)) ; 10
(stream-ref y 7) ; 36
(display-stream z) ; 210

; there will be no difference
