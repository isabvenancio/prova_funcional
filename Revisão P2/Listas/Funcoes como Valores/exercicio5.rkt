#lang racket
(require rackunit)

(define (meu-cons x y)
    (lambda (m) (m x y)))

(define (meu-first z)
    (z (lambda (p q) p))) ;;retorna o primeiro elemento do par

(define (meu-rest z)
    (z (lambda (p q) q))) ;;retorna o segundo elemento do par

(check-equal? (meu-first (meu-cons 1 2)) 1)
(check-equal? (meu-rest (meu-cons 1 2)) 2)
(check-equal? (meu-first (meu-cons (list 1 2) 'b)) (list 1 2))