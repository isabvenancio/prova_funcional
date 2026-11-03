#lang racket
(require rackunit)

(define (conversao celsius)
    (/ (+ (* 9 celsius) 160) 5))

(check-equal? (conversao 0) 32)