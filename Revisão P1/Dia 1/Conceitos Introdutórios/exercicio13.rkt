#lang racket
(require rackunit)

(define (notas-media-ponderada nota1 peso1 nota2 peso2 nota3 peso3)
    (/ (+ (* nota1 peso1)(* nota2 peso2)(* nota3 peso3))(+ peso1 peso2 peso3)))

(check-equal? (notas-media-ponderada 2 1 3 4 5 6) 4)