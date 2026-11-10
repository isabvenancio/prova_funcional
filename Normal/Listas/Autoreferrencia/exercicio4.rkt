#lang racket
(require rackunit)

#|Faça uma função que retorne o ultimo elemento de uma lista de valores.
Exemplos:
> (ultimo (list 1 2 3))
3
> (ultimo (list 1))
1
> (ultimo (list 1 3 4 2 1 7))
7|#

(define (ultimo lst)
    (cond
        [(empty? lst) (error "lista vazia")] ; lista vazia não tem último elemento
        [(empty? (rest lst)) (first lst)] ; caso base: só sobrou um elemento, ele é o último
        [else (ultimo (rest lst))] ; caso recursivo: procura o último no resto da lista
    )
)

(check-equal? (ultimo (list 1 2 3)) 3)
(check-equal? (ultimo (list 1)) 1)
(check-equal? (ultimo (list 1 3 4 2 1 7)) 7)
