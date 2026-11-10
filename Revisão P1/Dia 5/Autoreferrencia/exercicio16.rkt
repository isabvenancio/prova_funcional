#lang racket
(require rackunit)

(struct aluno (nome ra media) #:transparent)

(define (aprovados lst media)
    (cond
        [(empty? lst) empty]
        [(>= (aluno-media (first lst)) media) (cons (first lst) (aprovados (rest lst) media))]
        ;; verifica se a media do aluno é maior ou igual a media passada como parametro, se for cons o primeiro elemento da lista e chama a função recursivamente com o resto da lista
        [else (aprovados (rest lst) media)]))
        ;; senao, pega o resto da lista e chama a função recursivamente

(define (reprovados lst media)
    (cond
        [(empty? lst) empty]
        [(< (aluno-media (first lst)) media) (cons (first lst) (reprovados (rest lst) media))]
        ;; verifica se a media do aluno é menor que a media passada como parametro, se for cons o primeiro elemento da lista e chama a função recursivamente com o resto da lista
        [else (reprovados (rest lst) media)]))
        ;; senao, pega o resto da lista e chama a função recursivamente


(define (soma-medias lst)
  (cond
    [(empty? lst) 0]
    [else (+ (aluno-media (first lst))(soma-medias (rest lst)))]))

(define (conta-alunos lst)
  (cond
    [(empty? lst) 0]
    [else (+ 1 (conta-alunos (rest lst)))]))

(define (media-alunos lst)
  (cond
    [(empty? lst) (error "lista vazia")]
    [else (/ (soma-medias lst)(conta-alunos lst))]))


(define (media-aprovados lst media)
  (media-alunos (aprovados lst media)))


(define (media-reprovados lst media)
  (media-alunos (reprovados lst media)))


(define turma (list (aluno "Ana" 1001 8)(aluno "Bruno" 1002 5)(aluno "Carla" 1003 7)(aluno "Daniel" 1004 4)))

(check-equal? (aprovados turma 6) (list (aluno "Ana" 1001 8)(aluno "Carla" 1003 7)))
(check-equal? (reprovados turma 6) (list (aluno "Bruno" 1002 5)(aluno "Daniel" 1004 4)))

(check-equal? (media-alunos turma) 6)
(check-equal? (media-aprovados turma 6) 15/2)
(check-equal? (media-reprovados turma 6) 9/2)