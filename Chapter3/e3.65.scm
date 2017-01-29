(load "c3.5.3.scm")

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
			   (stream-map - (ln2-summands (+ n 1)))))
(define ln2-stream
  (partial-sums (ln2-summands 1)))

;(display-stream ln2-stream)
;(display-stream (euler-transform ln2-stream))
;(display-stream (accelerated-sequence euler-transform ln2-stream))

; first one: take a lot of terms of sequence to converge
; second one: take 7 terms of sequence to converge at 3 digits after decimal point
; third one: take 10 terms of sequence to converge at 16 digits after decimal point
