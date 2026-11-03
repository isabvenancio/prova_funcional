#|Faça uma função que receba 3 notas e seus respectivos pesos, calcule e retorne a
média ponderada dessas notas.|#

#lang racket

(define (notas_media_ponderada nota1 peso1 nota2 peso2 nota3 peso3)
    (/ (+ (* nota1 peso1)(* nota2 peso2)(* nota3 peso3))(+ peso1 peso2 peso3)))

(notas_media_ponderada 2 1 3 4 5 6)