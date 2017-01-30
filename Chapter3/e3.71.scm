(load "e3.70.scm")

(define (cube-sum p)
  (+ (expt (car p) 3)
	 (expt (cadr p) 3)))


(define cube-sum-pairs (weighted-pairs integers integers cube-sum))

(define (gen-ram-num s)
  (let ((p1 (stream-car s))
		(p2 (stream-car (stream-cdr s))))
	(if (= (cube-sum p1) (cube-sum p2))
	  (cons-stream (cube-sum p1) (gen-ram-num (stream-cdr (stream-cdr s))))
	  (gen-ram-num (stream-cdr s)))))

(define x (gen-ram-num cube-sum-pairs))
; (display-stream x)

;1729
;4104
;13832
;20683
;32832
;39312
