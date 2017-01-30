(define (make-accumulator sum)
  (lambda (num)
    (begin (set! sum (+ sum num))
           sum)))
