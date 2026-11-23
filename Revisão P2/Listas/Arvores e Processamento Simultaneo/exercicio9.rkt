#lang racket
(require rackunit)

(define (remove-em lst i)
  (cond
    [(empty? lst) empty]
    [(zero? i) (rest lst)]
    [else (cons (first lst) (remove-em (rest lst) (sub1 i)))]))

(check-equal? (remove-em (list 3 6 1 2) 2) (list 3 6 2))
(check-equal? (remove-em (list 3 6 1 2) 0) (list 6 1 2))
(check-equal? (remove-em (list 3 6 1 2) 9) (list 3 6 1 2))