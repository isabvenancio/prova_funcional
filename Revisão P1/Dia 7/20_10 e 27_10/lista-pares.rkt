#lang racket

(require rackunit)
(define (lista-pares lst)
    (cond
        [(empty? lst) empty]
        [(even? (first lst)) (cons (first lst)(lista-pares (rest lst)))]
        [else (lista-pares (rest lst))]))

(check-equal? (lista-pares empty) empty)
;; lista vazia retorna lista vazia

(check-equal? (lista-pares '(1 3 5 7)) empty)
;; não existem números pares

(check-equal? (lista-pares '(2 4 6 8)) '(2 4 6 8))
;; todos os números são pares

(check-equal? (lista-pares '(1 2 3 4 5 6)) '(2 4 6))
;; mantém somente os números pares

(check-equal? (lista-pares '(10 15 20 25 30)) '(10 20 30))
;; remove os ímpares e mantém os pares

(check-equal? (lista-pares '(7 9 11 13 16)) '(16))
;; somente o último número é par