#lang racket
(require rackunit)

(define (digito X n)
    (cond
        [(= n 1) (remainder X 10)];;o 1º dígito menos significativo é o último (x % 10)
        [else (digito (quotient X 10)(- n 1))]))

(check-equal? (digito 123 1) 3)
(check-equal? (digito 87654 3) 6)