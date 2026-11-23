#lang racket
(require rackunit)

(define (sinal-numero x)
  (cond
    [(> x 0) 1]
    [(< x 0) -1]
    [else 0]))

(define (sinais-lista lst)
  (map sinal-numero lst))

(check-equal? (sinais-lista (list 1 3 5 0 -2 -8))
              (list 1 1 1 0 -1 -1))
(check-equal? (sinais-lista (list -2 -3 -4))
              (list -1 -1 -1))
(check-equal? (sinais-lista (list))
              empty)
(check-equal? (sinais-lista (list 2 3 4))
              (list 1 1 1))