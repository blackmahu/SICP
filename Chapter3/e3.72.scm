(load "e3.71.scm")

(define (square-sum p)
  (+ (square (car p))
	 (square (cadr p))))


(define square-sum-pairs (weighted-pairs integers integers square-sum))

(define (gen-square-num s)
  (let ((p1 (stream-car s))
		(p2 (stream-car (stream-cdr s)))
		(p3 (stream-car (stream-cdr (stream-cdr s)))))
	(if (= (square-sum p1) (square-sum p2) (square-sum p3))
	  (cons-stream (list p1 p2 p3 (square-sum p1))
				   (gen-square-num (stream-cdr (stream-cdr (stream-cdr s)))))
	  (gen-square-num (stream-cdr s)))))

(define x (gen-square-num square-sum-pairs))
; (display-stream x)
;((1 18) (6 17) (10 15) 325)
;((5 20) (8 19) (13 16) 425)
;((5 25) (11 23) (17 19) 650)
;((7 26) (10 25) (14 23) 725)
;((2 29) (13 26) (19 22) 845)
