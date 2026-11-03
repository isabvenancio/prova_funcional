#|Faça uma função que receba a base menor (b), a base maior (B) e a altura de um
trapezio e calcule e retorne sua área.
A = ((B + b). h)/2|#

#lang racket

(define (area_trapezio b B h)
    (/ (* (+ B b) h) 2))

(area_trapezio 2 8 4)