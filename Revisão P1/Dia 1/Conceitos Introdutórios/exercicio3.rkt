#lang racket
(require rackunit)

(define (diametro-circulo r)
    (* r 2))

(check-equal? (diametro-circulo 2) 4)