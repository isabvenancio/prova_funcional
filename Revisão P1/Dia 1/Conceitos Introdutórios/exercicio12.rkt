#lang racket
(require rackunit)

(define (area-trapezio B b h)
    (/ (* (+ B b) h) 2))

(check-equal? (area-trapezio 2 8 4)20)