#lang racket
(require rackunit)

(define PI 3.14159)
(define (circunferencia-circulo r)
    (* PI r 2))

(check-equal? (circunferencia-circulo 2) 12.56636)