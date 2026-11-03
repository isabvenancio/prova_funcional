; Escreva uma função que receba o raio r e retorne a área do criculo de raio r. - Área = Pi * Raio * Raio

#lang racket

(define PI 3.14159)

(define (area_circulo r)
    (* pi (* r r))) ;ou (* pi r r)

(area_circulo 4)
