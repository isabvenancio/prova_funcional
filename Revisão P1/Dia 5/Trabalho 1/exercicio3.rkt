#lang racket
(require rackunit)

(struct aluno (ra nome nota1 nota2 nota3 nota4 total-faltas) #:transparent)

(define (dados-aluno a nota-aprovacao carga-horaria percentual-maximo-faltas)

    (define (media-aluno a)
    (/ (+ (aluno-nota1 a)(aluno-nota2 a)(aluno-nota3 a)(aluno-nota4 a)) 4))

    (define (limite-faltas carga-horaria percentual-maximo-faltas)
    (* carga-horaria (/ percentual-maximo-faltas 100)))

    (cond 
        [(and (>= (media-aluno a) nota-aprovacao)(<= (aluno-total-faltas a) (limite-faltas carga-horaria percentual-maximo-faltas)) "Aprovado")]
        [(and (< (media-aluno a) nota-aprovacao)(> (aluno-total-faltas a) (limite-faltas carga-horaria percentual-maximo-faltas)) "Reprovado por nota e falta")]
        [(< (media-aluno a) nota-aprovacao) "Reprovado por nota"]
        [else "Reprovado por falta"]))

(define a1 (aluno 101 "Carol" 10 10 10 10 0));aprovada (Média 10, 0 faltas)
(define a2 (aluno 102 "Isa" 5 5 5 5 0));reprovado por Nota (Média 5, 0 faltas)
(define a3 (aluno 103 "Pedro" 8 8 8 8 20))
(define a4 (aluno 104 "Ana" 5 5 5 5 20))
(check-equal? (dados-aluno a1 6 60 25) "Aprovado")
(check-equal? (dados-aluno a2 6 60 25) "Reprovado por nota")
(check-equal? (dados-aluno a3 6 60 25) "Reprovado por falta")
(check-equal? (dados-aluno a4 6 60 25) "Reprovado por nota e falta")

(struct resumo-turma (total-reprovados percentual-reprovados total-reprovados-nota percentual-reprovados-nota total-reprovados-faltas percentual-reprovados-faltas media-reprovados-nota) #:transparent)

(define (soma-medias turma)
  (cond
    [(empty? turma) 0]
    [else (+ (media-aluno (first turma))(soma-medias (rest turma)))]))

;; Calcula um percentual
(define (percentual quantidade total)
  (if (= total 0)
      0
      (* 100 (/ quantidade total))))

;; Analisa uma turma e retorna suas estatísticas
(define (relatorio-turma turma nota-aprovacao carga-horaria percentual-maximo-faltas)

  (define limite
    (limite-faltas carga-horaria percentual-maximo-faltas))

  ;; Verifica se reprovou por nota
  (define (reprovado-nota? a)
    (< (media-aluno a) nota-aprovacao))

  ;; Verifica se reprovou por faltas
  (define (reprovado-faltas? a)
    (> (aluno-total-faltas a) limite))

  ;; Verifica se reprovou por pelo menos um motivo
  (define (reprovado? a)
    (or (reprovado-nota? a)
        (reprovado-faltas? a)))

  ;; Separa os alunos de acordo com cada situação
  (define reprovados (filter reprovado? turma))
  (define reprovados-nota (filter reprovado-nota? turma))
  (define reprovados-faltas (filter reprovado-faltas? turma))

  ;; Conta os alunos
  (define total-reprovados (length reprovados))
  (define total-nota (length reprovados-nota))
  (define total-faltas (length reprovados-faltas))

  ;; Calcula a média dos alunos reprovados por nota
  (define media-reprovados
    (if (= total-nota 0)
        #f
        (/ (soma-medias reprovados-nota) total-nota)))

  ;; Retorna o relatório
(resumo-turma total-reprovados (percentual total-reprovados (length turma)) total-nota (percentual total-nota total-reprovados) total-faltas (percentual total-faltas total-reprovados) media-reprovados))

(define turma1
  (list
   (aluno 101 "Carol" 10 10 10 10 0)
   (aluno 102 "Isa" 5 5 5 5 0)
   (aluno 103 "Pedro" 8 8 8 8 20)
   (aluno 104 "Ana" 5 5 5 5 20)))

(define resultado
  (relatorio-turma turma1 6 60 25))

(check-equal? (resumo-turma-total-reprovados resultado) 3)

(check-equal? (resumo-turma-percentual-reprovados resultado) 75)

(check-equal? (resumo-turma-total-reprovados-nota resultado) 2)

(check-equal? (resumo-turma-percentual-reprovados-nota resultado) (/ 200 3))

(check-equal? (resumo-turma-total-reprovados-faltas resultado) 2)

(check-equal? (resumo-turma-percentual-reprovados-faltas resultado) (/ 200 3))

(check-equal? (resumo-turma-media-reprovados-nota resultado) 5)