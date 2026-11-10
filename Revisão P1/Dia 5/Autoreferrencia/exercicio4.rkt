#lang racket
(require rackunit)

(define (ultimo lst)
    (cond
        [(empty? lst) empty];;lista vazia retorna vazio
        [(empty?(rest lst)) (first lst)] ;;o resto da lista é vazio, ent sobrou só um elemento, retorna ele (first)
        [else (ultimo (rest lst))])) ;;senao retorna o ultimo do resto da lista (recursivo)

(check-equal? (ultimo (list 1 2 3)) 3)
(check-equal? (ultimo (list 1)) 1)
(check-equal? (ultimo (list 1 3 4 2 1 7)) 7)
(check-equal? (ultimo '()) '())