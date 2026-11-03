#lang racket
(require rackunit)

(define (diagonal D d)
    (/ (* D d) 2))

(check-equal? (diagonal 4 2) 4)