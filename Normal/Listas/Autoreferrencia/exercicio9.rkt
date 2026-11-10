#lang racket
(require rackunit)

#|Faça uma função que receba dois números naturais X e n. Sua função deverá
retornar o n-ésimo digito menos significativo de X.
Exemplos:
> (digito 123 1)
3
> (digito 87654 3)
6|#

(define (digito x n)
    (cond
        [(= n 1) (remainder x 10)] ; caso base: o 1º dígito menos significativo é o último (x % 10)
        [else (digito (quotient x 10) (- n 1))] ; caso recursivo: tira o último dígito (x // 10) e procura o (n-1)-ésimo
    )
)

(check-equal? (digito 123 1) 3)
(check-equal? (digito 87654 3) 6)
(check-equal? (digito 87654 5) 8)
