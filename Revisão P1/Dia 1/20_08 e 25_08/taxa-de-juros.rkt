#lang racket
(require rackunit)
;Faça uma função que receba o valor de um depósito
;e o valor da taxa de juros (em porcentagem), calcule
;e retorne o valor total depois do rendimento.
(define (juros deposito taxa)
  (+ deposito (* deposito (/ taxa 100))))

(juros 100 20)
(juros 1500 10)


(define (rendimento-total deposito taxa-juros)
    (+ deposito (* deposito (/ taxa-juros 100))))

(check-equal? (rendimento-total 100 20) 120)
(check-equal? (rendimento-total 1500 10) 1650)
