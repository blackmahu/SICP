; shit code

(define (front-ptr dqueue) (car dqueue))
(define (rear-ptr dqueue) (cdr dqueue))
(define (set-front-ptr! dqueue item)
  (set-car! dqueue item))
(define (set-rear-ptr! dqueue item)
  (set-cdr! dqueue item))

(define (empty-dqueue? dqueue)
  (null? (front-ptr dqueue)))
(define (make-dqueue) (cons '() '()))

(define (front-dqueue dqueue)
  (if (empty-dqueue? dqueue)
	(error "FRONT called with an empty dqueue" dqueue)
	(car (front-ptr dqueue))))

(define (rear-dqueue dqueue)
  (if (empty-dqueue? dqueue)
	(error "FRONT called with an empty dqueue" dqueue)
	(car (rear-ptr dqueue))))

(define (make-pair item)
  (cons (list item '()) '()))

(define (rear-insert-dqueue! dqueue item)
  (let ((new-pair (make-pair item)))
	(cond ((empty-dqueue? dqueue)
		   (set-front-ptr! dqueue new-pair)
		   (set-rear-ptr! dqueue new-pair)
		   (print-dqueue dqueue))
		  (else
			(set-cdr! (rear-ptr dqueue) new-pair)
			(set-car! (cdar new-pair) (rear-ptr dqueue))
			(set-rear-ptr! dqueue new-pair)
			(print-dqueue dqueue)))))

(define (front-insert-dqueue! dqueue item)
  (let ((new-pair (make-pair item)))
	(cond ((empty-dqueue? dqueue)
		   (set-front-ptr! dqueue new-pair)
		   (set-rear-ptr! dqueue new-pair)
		   (print-dqueue dqueue))
		  (else
			(set-cdr! new-pair (front-ptr dqueue))
			(set-car! (cdar (front-ptr dqueue)) new-pair)
			(set-front-ptr! dqueue new-pair)
			(print-dqueue dqueue)))))

(define (front-delete-dqueue! dqueue)
  (cond ((empty-dqueue? dqueue)
		 (error "DELETE! called with an empty dqueue" dqueue))
		(else
		  (set-front-ptr! dqueue (cdr (front-ptr dqueue)))
		  (set-car! (cdar (front-ptr dqueue)) '())
		  (print-dqueue dqueue))))

(define (rear-delete-dqueue! dqueue)
  (cond ((empty-dqueue? dqueue)
		 (error "DELETE! called with an empty dqueue" dqueue))
		(else
		  (set-rear-ptr! dqueue (cadar (rear-ptr dqueue)))
		  (set-cdr! (rear-ptr dqueue) '())
		  (print-dqueue dqueue))))

(define (print-dqueue dqueue)
   (define (gen-new l)
	(if (null? l)
	  '()
	  (cons (caar l) (gen-new (cdr l)))))
  (gen-new (car dqueue)))

(define q1 (make-dqueue))
(front-insert-dqueue! q1 'a)
(rear-insert-dqueue! q1 'b)
