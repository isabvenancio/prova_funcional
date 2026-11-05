#|Faça uma função para ler um número e, se ele for maior do que 20, então retornar a
metade do número, caso contrario, retonar o próprio número.|#

#lang racket

(define (compara_20 num)
    (if (> num 20)
        (/ num 2)
        num))

(compara_20 40)
(compara_20 10)