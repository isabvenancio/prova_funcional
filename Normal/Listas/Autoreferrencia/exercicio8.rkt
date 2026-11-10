#lang racket
(require rackunit)

#|Faça uma função que receba um valor natural e devolva a soma de seus
algarismos.
Exemplos:
> (soma-algarismos 1234)
10
> (soma-algarismos 92)
11|#

(define (soma-algarismos n)
    (cond
        [(< n 10) n] ; caso base: se o número for menor que 10, ele é um único dígito
        [else (+ (remainder n 10) (soma-algarismos (quotient n 10)))] ; Passo recursivo: pega o último dígito (resto)(n % 10) e soma com o restante (divisão inteira)(n // 10)
    )
)

(check-equal? (soma-algarismos 1234) 10)
(check-equal? (soma-algarismos 92) 11)