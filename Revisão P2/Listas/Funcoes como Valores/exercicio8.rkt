#lang racket
(require rackunit)

(define (concatena . lsts) ;;numero variavel de listas -> concatena todos os parametros
    (foldr append empty lsts)) ;;(foldr f base lst)

(check-equal? (concatena) empty)
(check-equal? (concatena (list 1 2 3) (list 4) (list 5 6)) (list 1 2 3 4 5 6))
(check-equal? (concatena (list 1) empty (list 2)) (list 1 2))
(check-equal? (concatena (list 1 2 3) (list 4) (list 5 6)) '(1 2 3 4 5 6))

;O foldr combina todos os elementos de uma lista em um único resultado, e aqui os elementos são listas.
