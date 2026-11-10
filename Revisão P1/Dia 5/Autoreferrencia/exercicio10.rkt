#lang racket
(require rackunit)

(define (digitos n)
    (cond
        [(= n 0) empty] ;;[(< n 10) (list n)]
        [else (append (digitos (quotient n 10)) (list(remainder n 10)))]))

(check-equal? (digitos 3) '(3))
(check-equal? (digitos 333) '(3 3 3))
(check-equal? (digitos 33) '(3 3))
