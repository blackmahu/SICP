(load "e3.59-a.scm")

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (stream-map (lambda (x) (* -1 x))
							 (integrate-series sine-series))))
(define sine-series
  (cons-stream 0 (integrate-series  cosine-series)))

