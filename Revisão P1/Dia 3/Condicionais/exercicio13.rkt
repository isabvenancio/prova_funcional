#lang racket
(require rackunit)

(define (media nota1 nota2)
    (/ (+ nota1 nota2) 2)) 

(define (nota-alunos media)
    (cond
    [(< media 5) "E"]
    [(and (>= media 5) (< media 6)) "D"]
    [(and (>= media 6) (< media 7)) "C"]
    [(and (>= media 7) (< media 9)) "B"]
    [(>= media 9) "A"]
    ))

(check-equal? (nota-alunos (media 10 9)) "A")
(check-equal? (nota-alunos (media 3 2)) "E")
(check-equal? (nota-alunos (media 7 6)) "C")
(check-equal? (nota-alunos (media 7 8)) "B")
(check-equal? (nota-alunos (media 5 5)) "D")