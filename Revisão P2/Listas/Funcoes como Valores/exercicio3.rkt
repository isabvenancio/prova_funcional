#lang racket
(require rackunit)

; recebe uma lista e um predicado (retorna um valor booleano) e conta quantos elemento satisfazem o predicado
(define (conta pred? lst) 
    (length (filter pred? lst))) ;; lenght conta o tamanho da nova lista filtrada 
    ; filter percorre a lista e cria uma nova filtrando apenas os itens q pred? é #t
    
(check-equal? (conta positive? (list 1 -1 2 3 -2 5)) 4)
(check-equal? (conta even? (list 1 -1 2 3 -2 5)) 2)