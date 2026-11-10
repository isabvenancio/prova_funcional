#lang racket
(require rackunit)

(define (conta-digitos num)
    (cond
        [(= num 0) 1] ;;[(< n 10) 1]
        [(= (quotient num 10) 0) 1]
        [else (+ 1 (conta-digitos (quotient num 10)))])) ;;divide o número por 10, elimina o último dígito e adiciona 1 à contagem

(check-equal? (conta-digitos 1234) 4)
(check-equal? (conta-digitos 222) 3)
(check-equal? (conta-digitos 12) 2)
(check-equal? (conta-digitos 2) 1)
(check-equal? (conta-digitos 0) 1)