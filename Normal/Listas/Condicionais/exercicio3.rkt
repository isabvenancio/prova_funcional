#|Faça uma função que receba um número e informe se ele é par ou impar|#

#lang racket

(define (par_impar num)
    (cond
        [(= (remainder num 2) 0) "par"]
        [else "impar"]
        ))

(par_impar 3)
(par_impar 4)