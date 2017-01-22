(define (ripple-carry-adder a-k b-k s-k c)
  (define (adder la lb ls c-out)
    (if (= (length la) 1)
      (let ((c-in make-wire))
        (full-adder (car la) (car lb) c-in (car ls) c-out))
      (let ((c-in make-wire))
        (full-adder (car la) (car lb) c-in (car ls) c-out)
        (ripple-carry-addr (cdr la) (cdr lb) (cdr ls) c-in))))
  (adder a-k b-k s-k c))

; ((2*and-gate-delay + or-gate-delay + inverter-delay)*2 + or-gate-delay) * n
