#lang racket
(require rackunit)

#|Faça uma função que receba dois números, a e b, e retorne uma lista com os
números inteiros no intervalo [a, b]. Quando a < b, a lista deve ser vazia.
Exemplos:
> (intervalo 1 6)
'(1 2 3 4 5 6)
> (intervalo 3 14)
'(3 4 5 6 7 8 9 10 11 12 13 14)
> (intervalo 6 2)
'()
> (intervalo 5 5)
'(5)|#

(define (intervalo a b)
    (cond
        [(> a b) empty] ; caso base: a passou de b, o intervalo acabou (ou já começou vazio)
        [else (cons a (intervalo (+ a 1) b))] ; caso recursivo: coloca a na lista e continua a partir de a+1
    )
)

(check-equal? (intervalo 1 6) '(1 2 3 4 5 6))
(check-equal? (intervalo 3 14) '(3 4 5 6 7 8 9 10 11 12 13 14))
(check-equal? (intervalo 6 2) '())
(check-equal? (intervalo 5 5) '(5))
