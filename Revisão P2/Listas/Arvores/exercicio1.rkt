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

(define (quant-nos-arv t)
    (cond
        [(empty? t) 0]
        [else (add1 (+ (quant-nos-arv (no-esq t)) (quant-nos-arv (no-dir t))))]))
        ;;verifica se a arvore é vazia, senao conta o no atual e chama a função para contar todos os nós da subarvorea esquerda e dps da direita

(check-equal? (quant-nos-arv empty) 0)
(check-equal? (quant-nos-arv (no 5 empty empty)) 1) ;; nó 5 com direita e esquerda vazias
(check-equal? (quant-nos-arv t) 6)