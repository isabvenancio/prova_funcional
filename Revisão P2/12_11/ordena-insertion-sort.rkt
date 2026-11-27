#lang racket
(require rackunit)
(define (insere-ordenado x lst)
  (cond
    [(empty? lst)
     (cons x empty)]
    [(> x (first lst))
     (cons (first lst)
           (insere-ordenado x (rest lst)))]
    [else
     (cons x lst)]))

(define (ordena lst)
  (foldr insere-ordenado empty lst))

(check-equal? (ordena (list 7 1 9 4 3 10 8))
              (list 1 3 4 7 8 9 10))

(check-equal? (insere-ordenado 9 empty)
              (list 9))
(check-equal? (insere-ordenado 2 (list 1 6 8) )
              (list 1 2 6 8))
(check-equal? (insere-ordenado 1 (list 5 9))
              (list 1 5 9))
(check-equal? (insere-ordenado 7 (list 1 4 6))
              (list 1 4 6 7))