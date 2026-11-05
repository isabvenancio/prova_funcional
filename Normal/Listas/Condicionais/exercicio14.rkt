#|Faça uma função (para cada subitem) que receba 3 números e retorne o resultado de:
a. Maior número – Menor número
b. Número do meio * Menor número
c. Número do meio + Maior número

Para decidir entre o maior, o menor e o do meio, suponha que estes números compõem
um conjunto ordenado, o primeiro é o menor, o segundo o do meio e o terceiro o maior.

Dica: Implemente funções para obter o maior, o menor e o valor do meio entre 3
números, e as utilize em todas os subitens.|#

#lang racket

(require rackunit)

(define (menor a b c)
  a)

(define (meio a b c)
  b)

(define (maior a b c)
  c)

(define (item-a a b c)
  (- (maior a b c) (menor a b c)))

(define (item-b a b c)
  (* (meio a b c) (menor a b c)))

(define (item-c a b c)
  (+ (meio a b c) (maior a b c)))

(item-a 2 5 10)
; resultado: 8

(item-b 2 5 10)
; resultado: 10

(item-c 2 5 10)
; resultado: 15

(check-equal? (item-a 2 5 10) 8)
(check-equal? (item-b 2 5 10) 10)
(check-equal? (item-c 2 5 10) 15)