#lang racket
(require rackunit)

#|Faça uma função que receba uma lista L e retorne um a lista M, onde o i-ésimo
elemento de M é dado pelo fatorial do i-ésimo valor de L.
Exemplos:
> (fatoriais '(1 2 3 4 5))
'(1 2 6 24 120))
> (fatoriais '(3 6))
'(6 720)|#

(define (fatorial n)
    (cond
        [(= n 0) 1]
        [else (* n (fatorial (- n 1)))] ; caso recursivo: n! = n * (n-1)!
    )
)

(define (fatoriais lst)
    (cond
        [(empty? lst) empty]
        [else (cons (fatorial (first lst))(fatoriais (rest lst)))] ; caso recursivo: o cont recebe o primeiro elemento da lista fatorial e chama o resto da lista recursivamente
    )
)

(check-equal? (fatoriais '(1 2 3 4 5)) '(1 2 6 24 120))
(check-equal? (fatoriais '(3 6)) '(6 720))
(check-equal? (fatoriais '(0 1 2)) '(1 1 2))
(check-equal? (fatoriais '()) '())