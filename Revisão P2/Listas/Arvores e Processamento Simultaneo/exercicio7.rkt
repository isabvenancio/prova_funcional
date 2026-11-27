#lang racket
(require rackunit)

(define (mantem lst n)
  (cond
    [(or (zero? n) (empty? lst)) empty]
    [else (cons (first lst) (mantem (rest lst) (sub1 n)))]))

(check-equal? (mantem (list 10 40 70 20 3) 2) (list 10 40))
(check-equal? (mantem (list 10 40) 0) empty)
(check-equal? (mantem (list 10 40) 5) (list 10 40))