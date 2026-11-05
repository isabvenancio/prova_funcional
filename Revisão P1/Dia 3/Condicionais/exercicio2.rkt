#lang racket
(require rackunit)

(define (metade-num num)
    (if (> num 20)
        (/ num 2)
        num))

(check-equal? (metade-num 30) 15)
(check-equal? (metade-num 10) 10)