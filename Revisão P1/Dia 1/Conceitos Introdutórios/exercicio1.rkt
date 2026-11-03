#lang racket
(require rackunit)

(define (media-aritmetica a b)
    (/ (+ a b) 2))

(check-equal? (media-aritmetica 10 20) 15)