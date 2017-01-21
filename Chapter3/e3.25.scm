; look like shit, but functional

(define (make-table)
	(define (assoc key records)
	  (cond ((null? records) false)
			((equal? key (caar records)) (car records))
			(else (assoc key (cdr records)))))
  (let ((local-table (list '*table*)))
	(define (lookup key-list)
	  (define (look k-list table)
		(if (or (null? k-list) (null? (cdr table)))
		  false
		  (let ((subtable
			  (assoc (car k-list) (cdr local-table))))
			(if subtable
			  (if (null? (cdr k-list))
				(cdr subtable)
				(look (cdr k-list) subtable))
			  false))))
	  (look key-list local-table))
	(define (insert! key-list value)
	  (define (ins! k-list table)
		(if (null? k-list)
		  false
		  (let ((subtable
				  (assoc (car k-list) (cdr table))))
			(if subtable
			  (if (null? (cdr k-list))
				(set-cdr! subtable value)
				(if (pair? (cdr subtable))
				  (ins! (cdr k-list) subtable)
				  (begin (set-cdr! subtable '())
						 (ins! (cdr k-list) subtable))))
			  (if (null? (cdr k-list))
				(set-cdr! table
						  (cons (cons (car k-list) value)
								(cdr table)))
				(ins! k-list
					  (begin
						(set-cdr! table
								  (cons (cons (car k-list) '())
										(cdr table)))
						table)))))))
	  (ins! key-list local-table)
	  'ok)
	(define (table)
	  local-table)
	(define (dispatch m)
	  (cond ((eq? m 'lookup-proc) lookup)
			((eq? m 'insert-proc!) insert!)
			((eq? m 'table-proc!) table)
			(else (error "Unknown operation: TABLE" m))))
	dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
(define tab (operation-table 'table-proc!))
