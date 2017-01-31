(load "c3.5.5.scm")
(load "e3.55.scm") ; for generic stream-map

; presume a unit circle center at (1,1)

(define (random-in-range low high)
  (let ((range (- high low)))
	(+ low (random range))))

(define (estimate-integral x1 x2 y1 y2)
  (let ((area (* (abs (- x1 x2)) (abs (- y1 y2)))))
	(stream-map
	  (lambda (p) (* p area))
	  (monte-carlo (cesaro-stream x1 x2 y1 y2) 0 0))))

(define (hit? x y)
  (<= (+ (square (- x 1))
		 (square (- y 1)))
	  1))

(define (cesaro-stream x1 x2 y1 y2)
  (define (rand-x)
	(random-in-range (min x1 x2) (max x1 x2)))
  (define (rand-y)
	(random-in-range (min y1 y2) (max y1 y2)))
  (define s1 (cons-stream
			   (rand-x)
			   (stream-map (lambda (x) (rand-x)) s1)))
  (define s2 (cons-stream
			   (rand-x)
			   (stream-map (lambda (x) (rand-x)) s1)))
  (stream-map hit? s1 s2))

(define x (estimate-integral 0.0 2.0 0.0 2.0))
;(display-stream x)
