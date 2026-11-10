#lang racket
(require rackunit)

(define (remove-ocorrencias lst n)
    (cond
        [(empty? lst) empty]
        [(= (first lst) n) (remove-ocorrencias (rest lst) n)]
        [else (cons (first lst)(remove-ocorrencias (rest lst) n))]))

(check-equal? (remove-ocorrencias (list 1 2 3 4 5 5) 5) (list 1 2 3 4))
(check-equal? (remove-ocorrencias '(5 5 5) 5) '())