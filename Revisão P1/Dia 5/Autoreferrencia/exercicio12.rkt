#lang racket
(require rackunit)


(define (fatorial n)
    (cond
        [(or (= n 0)(= n 1)) 1]
        [else (* n (fatorial (- n 1)))]))

(define (fatoriais lst)
    (cond
        [(empty? lst) empty]
        [else (cons (fatorial (first lst)) (fatoriais (rest lst)))]))
        ;;o cons recebe o primeiro elemento da lista fatorial e chama o resto da lista recursivamente
    
(check-equal? (fatoriais '(1 2 3 4 5)) '(1 2 6 24 120))
(check-equal? (fatoriais '(3 6)) '(6 720))