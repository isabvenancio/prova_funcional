#lang racket
(require rackunit)

(define PI 3.14159)
(define (volume-cilindro r A)
    (* PI (* r r) A))

(check-equal? (volume-cilindro 2 6) 75.39815999999999)