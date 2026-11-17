#lang racket
(require rackunit)

;; Number Number -> ListaDeNumero
;; Devolve, em ordem decrescente de n até 1, os números divisíveis por x.
;; Se x for 0, devolve empty (ninguém é divisível por 0).
(define (divisiveis n x)
    (cond
        [(= x 0) empty]
        [(< n 1) empty]
        [(= (remainder n x) 0) (cons n (divisiveis (- n 1) x))]
        [else (divisiveis (- n 1) x)]))

(check-equal? (divisiveis 10 5) (list 10 5))
(check-equal? (divisiveis 10 3) (list 9 6 3))
(check-equal? (divisiveis 10 1) (list 10 9 8 7 6 5 4 3 2 1))
(check-equal? (divisiveis 4 5) empty)
(check-equal? (divisiveis 0 5) empty)
(check-equal? (divisiveis 10 0) empty)