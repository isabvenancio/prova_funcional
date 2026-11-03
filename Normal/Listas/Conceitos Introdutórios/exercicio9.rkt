#| Faça uma função que receba o valor de um depósito e o valor da taxa de juros (em
porcentagem), calcule e retorne o valor total depois do rendimento.|#

#lang racket

(define (total_rendimento deposito taxaJuros)
    (+ deposito (/ (* deposito taxaJuros) 100)))

(total_rendimento 20 100)