#|Faça uma função que receba 4 númerose retorne a média ponderada, sabendo-se
que os pesos são respectivamente: 1, 2, 3 e 4.|#

#lang racket

(define (media_ponderada num1 num2 num3 num4)
    (/ (+ (* num1 1)(* num2 2)(* num3 3)(* num4 4)) 10))

(media_ponderada 1 4 3 4)