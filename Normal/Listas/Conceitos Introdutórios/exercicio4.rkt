; Escreva uma função que retorne o valor da circunferência de um criculo - Circunferência= 2 * Pi * Raio

#lang racket

(define PI 3.14159)

(define (circunferencia_circulo r)
    (* 2 PI r))

(circunferencia_circulo 2)