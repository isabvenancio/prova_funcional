#lang racket
(require rackunit)

(define (rotaciona-esquerda lst n)
  (cond
    [(or (empty? lst) (zero? n)) lst]
    [else (rotaciona-esquerda (append (rest lst) (list (first lst))) (sub1 n))]))

(check-equal? (rotaciona-esquerda (list 10 20 30 40 50) 2) (list 30 40 50 10 20))
(check-equal? (rotaciona-esquerda (list 10 20 30) 0) (list 10 20 30))
(check-equal? (rotaciona-esquerda (list 10 20 30) 4) (list 20 30 10))
(check-equal? (rotaciona-esquerda empty 3) empty)