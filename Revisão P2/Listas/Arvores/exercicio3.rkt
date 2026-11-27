#lang racket
(require rackunit)

(struct no (chave esq dir) #:transparent)

;; árvore usada nos testes (é uma ABB)
;;        8
;;      /   \
;;     3     10
;;    / \      \
;;   1   6      14
(define t
  (no 8
      (no 3 (no 1 empty empty) (no 6 empty empty))
      (no 10 empty (no 14 empty empty))))

(define (insira-arv t x)
    (cond
        [(empty? t) (no x empty empty)]
        ; chegou num galho vazio, cria um novo nó com empty dos dois lados
        [(> x (no-chave t)) (no (no-chave t) (no-esq t) (insira-arv (no-dir t) x))]
        ;;lado direito, mantem a msm chave e o lado esquerdo intacto e insere x na subarvore da direita
        [(< x (no-chave t)) (no (no-chave t) (insira-arv (no-esq t) x) (no-dir t))]
        ;lado esquerdo, mantem a msm chave e insere x na subarvore esquerda e o lado direito intacto
        [else t]))
        ;t é igual ao nó atual, só devolve t

(check-equal? (insira-arv empty 5) (no 5 empty empty))
(check-equal? (insira-arv (no 5 empty empty) 3) (no 5 (no 3 empty empty) empty))
(check-equal? (insira-arv (no 5 empty empty) 8) (no 5 empty (no 8 empty empty)))
(check-equal? (insira-arv (no 5 empty empty) 5) (no 5 empty empty))
(check-equal? (insira-arv t 7)
              (no 8
                  (no 3 (no 1 empty empty) (no 6 empty (no 7 empty empty)))
                  (no 10 empty (no 14 empty empty))))