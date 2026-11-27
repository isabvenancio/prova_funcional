#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (reverse* lst)
    (cond
        [(empty? lst) empty]
        [(list? (first lst)) (append (reverse* (rest lst)) (list (reverse* (first lst))))]
        [else (append (reverse* (rest lst)) (list (first lst)))]))

(check-equal? (reverse* (list (list 2 3) 8 (list 9 (list 10 11) 50) (list 10) 70))
              '(70 (10) (50 (11 10) 9) 8 (3 2)))
(check-equal? (reverse* empty) empty)
(check-equal? (reverse* (list 1 2 3)) '(3 2 1))
(check-equal? (reverse* (list (list 1 2) 3)) '(3 (2 1)))
(check-equal? (reverse* (list empty 1)) '(1 ()))
(check-equal? (reverse* (list 1 (list 2 (list 3 4)))) '(((4 3) 2) 1))
(check-equal? (reverse* (list (list 2 3) 8 (list 9 (list 10 11) 50) (list 10) 70))
              '(70 (10) (50 (11 10) 9) 8 (3 2)))