#lang racket 
(require rackunit)

(define (merge lst1 lst2)
    (cond
        [(empty? lst1) lst2]
        [(empty? lst2) lst1]
        [(<= (first lst1)(first lst2)) (cons (first lst1)(merge (rest lst1) lst2))]
        [else (cons (first lst2)(merge lst1 (rest lst2)))]))

(check-equal? (merge '(5 8 9) '(1 2 3 4 6 7 10)) '(1 2 3 4 5 6 7 8 9 10))
(check-equal? (merge '() '(5 8 9)) '(5 8 9))
(check-equal? (merge '(2 5 8) '(5 8 9)) '(2 5 5 8 8 9))