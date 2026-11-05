#|Faça uma função que receba duas notas de um aluno e retorne qual conceito o aluno
obteve de acordo com sua média.
Média Conceito
Menor que 5 E
Maior ou igual a 5 e menor que 6 D
Maior ou igual a 6 e menor que 7 C
Maior ou igual a 7 e menor que 9 B
Maior ou igual a 9 A|#

#lang racket

(define (notas_aluno nota1 nota2)
  (define media (/ (+ nota1 nota2) 2)) 
  (cond
    [(< media 5) "E"]
    [(and (>= media 5) (< media 6)) "D"]
    [(and (>= media 6) (< media 7)) "C"]
    [(and (>= media 7) (< media 9)) "B"]
    [(>= media 9) "A"]
    ))

(notas_aluno 10 9)
(notas_aluno 3 2)
(notas_aluno 5 6)
