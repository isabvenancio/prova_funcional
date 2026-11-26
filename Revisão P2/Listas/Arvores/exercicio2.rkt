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

(define (altura-arv t)
    (cond
        [(empty? t) 0]
        [else (add1 (max (altura-arv (no-esq t)) (altura-arv (no-dir t))))]))
        ;;verifica se a arvore é vazia, senao conta o nó atual e com max esolhe o maior lado, chama a função para descer por todos os nós da subarvore para ver qual a profundidade do lado

(check-equal? (altura-arv empty) 0)
(check-equal? (altura-arv (no 5 empty empty)) 1)
(check-equal? (altura-arv t) 3)
(check-equal? (altura-arv (no 1 empty (no 2 empty (no 3 empty empty)))) 3)