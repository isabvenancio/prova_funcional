#lang racket
(require rackunit)

#|Faça uma função que receba uma lista L e um valor natural n, e retorne uma lista
contendo os n primeiros elementos de L.
Quaando n for maior que o tamanho da lista, retorne a lista toda.
Exemplo:
> (n-primeiros '(4 8 1 3 9 7 5 6) 4)
'(4 8 1 3)
> (n-primeiros '(4 8 1 3 9 7 5 6) 0)
'()
> (n-primeiros '(4 8) 4)
‘(4 8)|#

(define (n_primeiros lst n)
    (cond
        [(or (empty? lst)(= n 0)) empty] ; Se a lista estiver vazia ou n for zero, retorne uma lista vazia
        [else (cons (first lst) (n_primeiros (rest lst) (- n 1)))] ; Caso contrário, retorne o primeiro elemento da lista concatenado com a chamada recursiva para o restante da lista
    )
)

(check-equal? (n_primeiros '(4 8 1 3 9 7 5 6) 4) '(4 8 1 3))
(check-equal? (n_primeiros '(4 8 1 3 9 7 5 6) 0) '())
(check-equal? (n_primeiros '(4 8) 4) '(4 8))