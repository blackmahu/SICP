(load "c3.5.3.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
		((stream-null? s2) s1)
		(else
		  (let ((s1car (stream-car s1))
				(s2car (stream-car s2)))
			(cond ((<= (weight s1car) (weight s2car))
				   (cons-stream
					 s1car
					 (merge-weighted (stream-cdr s1) s2 weight)))
				  ((> (weight s1car) (weight s2car))
				   (cons-stream
					 s2car
					 (merge-weighted s1 (stream-cdr s2) weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
	(list (stream-car s) (stream-car t))
	(merge-weighted
	  (stream-map (lambda (x) (list (stream-car s) x))
				  (stream-cdr t))
	  (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
	  weight)))

; a
(define x (weighted-pairs integers integers 
						  (lambda (p)
							(+ (car p) (cadr p)))))

; b
(load "e3.56.scm")
(define (merge-exclude s1 s2)
	(cond ((stream-null? s2) s1)
		  ((stream-null? s1) the-empty-stream)
		  (else
			(let ((s1car (stream-car s1))
				  (s2car (stream-car s2)))
			  (if (= s1car s2car)
				(merge-exclude (stream-cdr s1) (stream-cdr s2))
				(cons-stream s1car (merge-exclude (stream-cdr s1) s2)))))))

(define integer-stream-asked
  (merge-exclude integers (stream-cdr S))) ; S is defined in e3.56.scm, (stream-cdr S) to save number 1 from being filtered

(define y (weighted-pairs integer-stream-asked
						  integer-stream-asked
						  (lambda (p)
							(let ((i (car p))
								  (j (cadr p)))
							  (+ (* 2 i)
								 (* 3 j)
								 (* 5 i j))))))

