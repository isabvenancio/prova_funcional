#lang racket 
(require rackunit)

#|Faça uma função que receba duas listas ordenadas e retorne uma terceira lista
também ordenada.
Exemplo:
> (merge '(5 8 9) '(1 2 3 4 6 7 10))
'(1 2 3 4 5 6 7 8 9 10)
> (merge '() '(5 8 9))
'(5 8 9)
> (merge '(2 5 8) '(5 8 9))
'(2 5 5 8 8 9)|#

(define (merge lst1 lst2)
    (cond 
        [(empty? lst1) lst2]
        [(empty? lst2) lst1]
        [(<= (first lst1)(first lst2)) (cons(first lst1)(merge (rest lst1) lst2))]
        [else (cons (first lst2)(merge lst1 (rest lst2)))]
        ))


(check-equal? (merge '(5 8 9) '(1 2 3 4 6 7 10)) '(1 2 3 4 5 6 7 8 9 10))
(check-equal? (merge '() '(5 8 9)) '(5 8 9))
(check-equal? (merge '(2 5 8) '(5 8 9)) '(2 5 5 8 8 9))
(check-equal? (merge '() '()) '())
(check-equal? (merge '(1 3 5) '(2 4 6)) '(1 2 3 4 5 6))