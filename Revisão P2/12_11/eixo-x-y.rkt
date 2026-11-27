#lang racket
(require rackunit)
(struct ponto (x y) #:transparent)
(define (ponto-no-eixo? p)
  (or (= (ponto-x p) 0)
      (= (ponto-y p) 0)))

(define (eixo-x-ou-y lst)
  (filter ponto-no-eixo? lst))

(check-equal? (eixo-x-ou-y (list (ponto 0 1) (ponto 1 1) (ponto 4 0)))
              (list (ponto 0 1) (ponto 4 0)))
(check-equal? (eixo-x-ou-y (list (ponto 1 1) (ponto 1 1) (ponto 4 3)))
              (list ))
(check-equal? (eixo-x-ou-y (list (ponto 0 3) (ponto 0 0) (ponto 2 0)))
              (list (ponto 0 3) (ponto 0 0) (ponto 2 0)))