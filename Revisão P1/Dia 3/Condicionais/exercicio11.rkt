#lang racket
(require rackunit)

(define (intervalo-funcao A B C)
    (if (and (>= A B)(<= A C))
        #t
        #f))

(check-equal? (intervalo-funcao 5 1 10) #t)
(check-equal? (intervalo-funcao 12 1 10) #f)