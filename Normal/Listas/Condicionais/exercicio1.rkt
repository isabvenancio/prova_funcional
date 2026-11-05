#|Faça uma função que leia um número inteiro e diga se este número é menor que zero,
igual a zero ou maior que zero.|#

#lang racket

(define (num_inteiro num)
    (cond
        [(> num 0) "maior que zero"]
        [(< num 0) "menor que zero"]
        [else "igual a zero"]
    )
)

(num_inteiro 3)
(num_inteiro 0)
(num_inteiro -4)