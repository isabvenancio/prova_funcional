#|Faça uma função que receba uma temperatura em graus centígrados e retorne o
valor convertido em graus Fahrenheit. A fórmula de conversão é:

F = (9. c + 160) / 5

F é a temperatura em Fahrenheit e C é a temperatura em centígrados.|#

#lang racket

(define (celsius_fahrenheit c)
    (/ (+ (* 9 c) 160) 5))

(celsius_fahrenheit 0) ; Retorna 32.0