#lang racket
(require rackunit)

(define (fibonacci n)
    (cond
        [(= n 1) 0]
        [(= n 2) 1]
        [else (+ (fibonacci (- n 1))(fibonacci (- n 2)))]))

(check-equal? (fibonacci 1) 0)
(check-equal? (fibonacci 2) 1)
(check-equal? (fibonacci 3) 1)
(check-equal? (fibonacci 4) 2)
(check-equal? (fibonacci 5) 3)
(check-equal? (fibonacci 9) 21)