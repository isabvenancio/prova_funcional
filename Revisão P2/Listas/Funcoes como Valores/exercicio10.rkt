#lang racket
(require rackunit)

(define (same-parity x . outros)
    (cons x (filter (lambda (y) (equal? (even? x) (even? y))) outros))) ;;primeiro argumento de x é igual ao primeiro argumento de y, da o resto

(check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7)) ;;impar
(check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6));;par
(check-equal? (same-parity 5) (list 5));;impar
(check-equal? (same-parity -3 2 -1 4) (list -3 -1));;impar