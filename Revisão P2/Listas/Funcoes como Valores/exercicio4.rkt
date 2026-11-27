#lang racket
(require rackunit)

(define (double f)
    (lambda (x) (f (f x))))

(check-equal? ((double add1) 3) 5)
; = ((λ (x) (add1 (add1 x))) 3)   ; (double add1) devolve essa função, com f = add1
; = (add1 (add1 3))               ; a função recebe x = 3
; = 5
(check-equal? ((double (lambda (x) (+ x 1))) 3) 5)

(check-equal? ((double (lambda (x) (* x 2))) 3) 12)