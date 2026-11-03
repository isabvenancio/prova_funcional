#lang racket
(require rackunit)

(define PI 3.14159)
(define (area-circulo r)
    (* PI r r))

(check-equal? (area-circulo 4) 50.26544)