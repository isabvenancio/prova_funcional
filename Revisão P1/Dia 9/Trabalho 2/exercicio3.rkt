#lang racket
(require rackunit)

(define (scan f ini lst)
    (cond
        [(empty? lst) empty]
        [else
            (define novo (f ini (first lst)))
                (cons novo (scan f novo (rest lst)))]))

(check-equal? (scan + 0 (list)) '())
(check-equal? (scan + 2 (list 9 3 1 7)) '(11 14 15 22))
(check-equal? (scan * 1 (list 2 3 5)) '(2 6 30))
(check-equal? (scan append (list) (list (list 1 2) (list 3) (list 4 5))) '((1 2) (1 2 3) (1 2 3 4 5)))
(check-equal? (scan append (list 0) (list (list 1 2) (list 3) (list 4 5))) '((0 1 2) (0 1 2 3) (0 1 2 3 4 5)))