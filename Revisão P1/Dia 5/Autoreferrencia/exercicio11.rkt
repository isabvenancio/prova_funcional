#lang racket
(require rackunit)

(define (fatorial n)
    (cond
        [(or (= n 0)(= n 1)) 1]
        [else (* n (fatorial (- n 1)))]))

(check-equal? (fatorial 4) 24)
(check-equal? (fatorial 6) 720)
(check-equal? (fatorial 0) 1)