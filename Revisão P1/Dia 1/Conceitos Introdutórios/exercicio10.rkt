#lang racket
(require rackunit)

(define (raiz-quadrada a b)
    (sqrt(+ (* a a)(* b b))))

(check-equal? (raiz-quadrada 3 4) 5)