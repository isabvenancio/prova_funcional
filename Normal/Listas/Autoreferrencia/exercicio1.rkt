#lang racket
(require rackunit)

#|Faça uma função que receba uma lista de números inteiros e um inteiro n. Sua
função deve remover todas as ocorrências de n.|#

(define (remove-todos lst n)
    (cond
        [(empty? lst) empty] ; caso base: lista vazia, não há o que remover
        [(= (first lst) n) (remove-todos (rest lst) n)] ; se o primeiro for igual a n, descarta ele e continua no resto
        [else (cons (first lst) (remove-todos (rest lst) n))] ; senão, mantém o primeiro e continua no resto
    )
)

(check-equal? (remove-todos '(1 2 3 2 4 2) 2) '(1 3 4))
(check-equal? (remove-todos '(5 5 5) 5) '())
(check-equal? (remove-todos '(1 2 3) 7) '(1 2 3))
(check-equal? (remove-todos '() 1) '())
