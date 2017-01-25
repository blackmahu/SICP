(load "parallel.scm") ; code from the website of SICP

(define x 10)

;(parallel-execute
;  (lambda () (set! x (* x x)))
;  (lambda () (set! x (+ x 1))))

(define s (make-serializer))
(parallel-execute
  (lambda () (set! x ((s (lambda () (* x x))))))
  (s (lambda () (set! x (+ x 1)))))
; 101
; 121
; 
; 11
; 100
