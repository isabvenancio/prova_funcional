#lang racket
(require rackunit)

#|Faça uma função que receba um número inteiro e conte quantos dígitos esse
número tem:
Exemplos:
> (conta-digitos 1234)
4
> (conta-digitos 222)
3|#

(define (conta-digitos n)
    (cond
        [(< n 10) 1] ; caso base: se o número for 0 (para o caso de n=0 original ou fim da divisão)
        [else (+ 1 (conta-digitos (quotient n 10)))] ; Caso recursivo: conta 1 dígito e chama a função reduzindo o número por 10
    )
)
;;quotient = //
;;/ = /

(check-equal? (conta-digitos 1234) 4)
(check-equal? (conta-digitos 222) 3)