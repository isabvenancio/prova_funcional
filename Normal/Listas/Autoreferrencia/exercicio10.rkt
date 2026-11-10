#lang racket
(require rackunit)

#|Faça um programa que receba um valor N, sendo N um inteiro maior que 0 e
retorne uma lista contendo cada digito N.|#

(define (digitos n)
  (cond
    [(< n 10) (list n)]
    [else (append (digitos (quotient n 10)) (list (remainder n 10)))])) ;caso recursivo: adiciona o último dígito à lista e chama a função recursivamente com o restante

(check-equal? (digitos 1234) (list 1 2 3 4))
(check-equal? (digitos 92) (list 9 2))