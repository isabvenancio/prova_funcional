#lang racket
(require rackunit)

(define (sublista lst i j)
  (cond
    [(or (empty? lst) (<= j 0)) empty]
    [(> i 0) (sublista (rest lst) (sub1 i) (sub1 j))]
    [else (cons (first lst) (sublista (rest lst) 0 (sub1 j)))]))

(check-equal? (sublista (list 10 20 30 40 50) 1 4) (list 20 30 40))
(check-equal? (sublista (list 10 20 30 40 50) 0 2) (list 10 20))
(check-equal? (sublista (list 10 20 30) 2 2) empty)
(check-equal? (sublista (list 10 20 30) 1 9) (list 20 30))
(check-equal? (sublista empty 0 3) empty)