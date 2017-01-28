(define (div-series s1 s2)
  (if (zero? (stream-car s2))
	(error "DIV-SERIES constant term of denominator can't be zero" (stream-car s2))
	(mul-series s1 (invert-unit-series s2))))

; tested with right result
(define tangent-series
  (div-series sine-series cosine-series))
