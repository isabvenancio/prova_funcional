#lang racket
(require rackunit)

#|Declare uma struct para um aluno, contendo o nome, RA e a sua média e em
seguida implemente as seguintes funções
a. Uma função que receba uma lista de alunos, uma valor de média e retone
uma lista contendo todos os alunos que foram aprovados (notas maiores
ou iguais a média).
b. Uma função que receba uma lista de alunos, um valor de média e retorne
a lista de alunos que foram reprovados (notas menores que a média).
c. Uma função que receba uma lista de alunos e retorne a média dos alunos.
d. Uma função que receba uma lista de alunos, uma média e retorne a
média dos alunos aprovados.
Dica: use as funções dos itens (a) e (c).
e. Uma função que receba uma lista de alunos, uma média e retorne a
média dos alunos reprovados.
Dica: use as funções dos itens (b) e (c).|#

;; Struct para representar um aluno
(struct aluno (nome ra media) #:transparent)

;; a. Retorna os alunos aprovados
(define (aprovados lst media)
  (cond
    [(empty? lst) empty]
    [(>= (aluno-media (first lst)) media) (cons (first lst)(aprovados (rest lst) media))]
    [else (aprovados (rest lst) media)]))

;; b. Retorna os alunos reprovados
(define (reprovados lst media)
  (cond
    [(empty? lst) empty]
    [(< (aluno-media (first lst)) media) (cons (first lst)(reprovados (rest lst) media))]
    [else (reprovados (rest lst) media)]))

;; Soma as médias dos alunos
(define (soma-medias lst)
  (cond
    [(empty? lst) 0]
    [else (+ (aluno-media (first lst))(soma-medias (rest lst)))]))

;; Conta a quantidade de alunos
(define (conta-alunos lst)
  (cond
    [(empty? lst) 0]
    [else (+ 1 (conta-alunos (rest lst)))]))

;; c. Retorna a média de todos os alunos
(define (media-alunos lst)
  (cond
    [(empty? lst) (error "lista vazia")]
    [else (/ (soma-medias lst)(conta-alunos lst))]))

;; d. Retorna a média dos alunos aprovados
(define (media-aprovados lst media)
  (media-alunos (aprovados lst media)))

;; e. Retorna a média dos alunos reprovados
(define (media-reprovados lst media)
  (media-alunos (reprovados lst media)))


(define turma (list (aluno "Ana" 1001 8)(aluno "Bruno" 1002 5)(aluno "Carla" 1003 7)(aluno "Daniel" 1004 4)))

(check-equal? (aprovados turma 6) (list (aluno "Ana" 1001 8)(aluno "Carla" 1003 7)))
(check-equal? (reprovados turma 6) (list (aluno "Bruno" 1002 5)(aluno "Daniel" 1004 4)))

(check-equal? (media-alunos turma) 6)
(check-equal? (media-aprovados turma 6) 15/2)
(check-equal? (media-reprovados turma 6) 9/2)