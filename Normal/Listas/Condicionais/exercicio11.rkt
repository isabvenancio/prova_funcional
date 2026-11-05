#|Faça uma função que receba 3 números, A, B e C. Sua função deverá retronar um valor
booleano, informando se A está no intervalo [B,C]|#

#lang racket

(define (intervalo_func A B C)
    (and (>= A B)(<= A C)) 
)

(intervalo_func 1 2 3)
(intervalo_func 3.4 2 9)