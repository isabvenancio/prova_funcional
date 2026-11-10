#lang racket
(require rackunit)

(define (intervalo a b)
    (cond
        [(> a b) empty];; os exemplos estão errados
        [else (cons a (intervalo (+ a 1) b))])) ;; usa cons para juntar o numero atual (a) com o resultado do intervalo de 

(check-equal? (intervalo 1 6) '(1 2 3 4 5 6))
(check-equal? (intervalo 3 14) '(3 4 5 6 7 8 9 10 11 12 13 14))
(check-equal? (intervalo 6 2) '())
(check-equal? (intervalo 5 5) '(5))
(check-equal? (intervalo 1 3) '(1 2 3))
; (cons 1 (intervalo 2 3))
; (cons 1 (cons 2 (intervalo 3 3)))
; (cons 1 (cons 2 (cons 3 (intervalo 4 3))))
; (cons 1 (cons 2 (cons 3 empty))) ; <-- Chegou no caso base, agora ele resolve de trás para frente
; (cons 1 (cons 2 '(3)))
; (cons 1 '(2 3))
; '(1 2 3)
