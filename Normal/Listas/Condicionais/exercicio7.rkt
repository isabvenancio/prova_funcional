#|Faça uma função que receba um valor para x e retorne o valor de f(x):|#

#lang racket

(define (func_math x)
    (cond
        [(<= x 1) 1]
        [(and (> x 1)(<= x 2)) 2]
        [(and (> x 2)(<= x 3)) (* x x)]
        [(> x 3) (* (* x x) x)]
    ))

(func_math 3)
(func_math 1)
(func_math 4)
(func_math 0)
(func_math 2)