#lang racket
(require rackunit)

(define (concatena lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [else (cons (first lst1) (concatena (rest lst1) lst2))]))

(check-equal? (concatena (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))
(check-equal? (concatena empty (list 7 8 9 2 4)) (list 7 8 9 2 4))
(check-equal? (concatena (list 6 3) empty) (list 6 3))
(check-equal? (concatena (list 7 8) (list 3 4 5 6 7)) (list 7 8 3 4 5 6 7))
(check-equal? (concatena empty empty) empty)


(define (concatena-lista lista1 lista2)
    (cond
        [(empty? lista1) lista2]
        [(empty? lista2) lista1]
        [else (cons (first lista1)(concatena-lista (rest lista1) lista2))]))

(check-equal? (concatena-lista (list 1 2 3)(list 4 7 2 0)) (list 1 2 3 4 7 2 0))
(check-equal? (concatena-lista empty empty) empty)
(check-equal? (concatena-lista (list 6 3) empty) (list 6 3))
(check-equal? (concatena-lista empty (list 6 3)) (list 6 3))