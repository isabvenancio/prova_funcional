#lang racket
(require rackunit)
(define (produto-lista lst)
  (cond
    [(empty? lst) 1]
    [else (* (first lst)(produto-lista (rest lst)))]))

(check-equal? (produto-lista empty) 1)
;; lista vazia retorna 1

(check-equal? (produto-lista '(5)) 5)
;; lista com apenas um elemento

(check-equal? (produto-lista '(2 3 4)) 24)
;; 2 * 3 * 4 = 24

(check-equal? (produto-lista '(1 2 3 4 5)) 120)
;; 1 * 2 * 3 * 4 * 5 = 120

(check-equal? (produto-lista '(10 2 5)) 100)
;; 10 * 2 * 5 = 100

(check-equal? (produto-lista '(2 0 5)) 0)
;; qualquer multiplicação por zero resulta em zero

(check-equal? (produto-lista '(-2 3 4)) -24)
;; lista com número negativo