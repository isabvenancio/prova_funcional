#lang racket
(require rackunit)

(define (media-ponderada nota1 nota2 nota3 nota4)
    (/ (+ (* nota1 1)(* nota2 2)(* nota3 3)(* nota4 4)) 10))

(check-equal? (media-ponderada 1 4 3 4) 17/5)