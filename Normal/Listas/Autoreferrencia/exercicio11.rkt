#lang racket
(require rackunit)

#|Faça uma função que receba um valor natural N e retorne o fatorial deste
número.
> (fatorial 4)
24
> (fatorial 6)
720
> (fatorial 0)
1|#

(define (fatorial n)
    (cond
        [(= n 0) 1] ; caso base: 0! = 1
        [else (* n (fatorial (- n 1)))] ; caso recursivo: n! = n * (n-1)!
    )
)

(check-equal? (fatorial 4) 24)
(check-equal? (fatorial 6) 720)
(check-equal? (fatorial 0) 1)
