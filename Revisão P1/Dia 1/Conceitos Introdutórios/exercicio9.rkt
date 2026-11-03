#lang racket
(require rackunit)

(define (rendimento deposito taxa-juros)
    (+ deposito (/ (* deposito taxa-juros) 100)))

(check-equal? (rendimento 20 100) 40)