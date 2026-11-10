#lang racket
(require rackunit)

(define (n-primeiros lstL n)
    (cond
        [(> n (length lstL)) lstL] ;;[(or (empty? lst)(= n 0)) empty]
        [(= n 0) empty] ;;[(or (empty? lst)(= n 0)) empty]
        [else (cons (first lstL)(n-primeiros (rest lstL) (- n 1)))]))

(check-equal? (n-primeiros '(4 8 1 3 9 7 5 6) 4) '(4 8 1 3))
(check-equal? (n-primeiros '(4 8 1 3 9 7 5 6) 0) '())
(check-equal? (n-primeiros '(4 8) 4) '(4 8))