#lang racket
(require rackunit)

(define (insere-em lst x i)
  (cond
    [(or (zero? i) (empty? lst)) (cons x lst)]
    [else (cons (first lst) (insere-em (rest lst) x (sub1 i)))]))

(check-equal? (insere-em (list 3 6 1 2) 5 2) (list 3 6 5 1 2))
(check-equal? (insere-em (list 3 6 1 2) 5 0) (list 5 3 6 1 2))
(check-equal? (insere-em (list 3 6) 5 9) (list 3 6 5))