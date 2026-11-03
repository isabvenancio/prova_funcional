#| Faça uma função que receba os valores dos catetos de um triângulo retângulo e
retorne a hipotenusa. Use a função (sqrt x) para obter a raiz quadrada de um número.|#

#lang racket

(define (hipotenusa a b)
    (sqrt(+ (* a a)(* b b))))

(hipotenusa 3 4)