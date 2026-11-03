#lang racket
(require rackunit)

(define (quadrado n)
    (* n n))

(check-equal? (quadrado 2) 4)