#lang racket
(struct aluno (ra nome curso) #:transparent)
(define nilton (aluno 123
                      "Nilton Luiz Queiroz Jr"
                      "Engenharia de Software"))
(define jose (struct-copy aluno nilton [ra 345]
                          [nome "Jose da Silva"])) 


(require rackunit)

(struct alunos (ra nome aluno) #:transparent)

;;criando instancias/objetos
(define aluno1 (alunos 123 "Isabella" "eng software"))
(define aluno2 (alunos 321 "rui" "ed fisica"))

;;usando o predicado
(alunos? aluno1) ;#t
(alunos? "Isabella") ;#f

;;acessando os campos
(alunos-nome aluno1) ;;"Isabella"
(alunos-ra aluno2) ;;321


(define aluno3 (struct-copy alunos aluno1 [ra 456][nome "sla porra"]))
(alunos-nome aluno3) ;;"sla porra"
(alunos-ra aluno3) ;;456