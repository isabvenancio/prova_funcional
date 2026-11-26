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

; • Pré-ordem (Raiz → Esquerda → Direita): Visita primeiro o nó atual, depois percorre a subárvore esquerda e, por fim, a subárvore direita. Útil para copiar ou clonar a estrutura da árvore.
; • Em-ordem (Esquerda → Raiz → Direita): Percorre primeiro a subárvore esquerda, visita o nó atual e depois percorre a subárvore direita. Em árvores binárias de busca (BST), retorna os valores em ordem crescente.
; • Pós-ordem (Esquerda → Direita → Raiz): Percorre primeiro a subárvore esquerda, depois a subárvore direita e visita o nó atual por último. Útil para liberar memória ou calcular valores que dependem dos filhos antes do pai.

(define (pos-ordem t)
    (cond
        [(empty? t) empty]
        [else (append (pos-ordem (no-esq t))(pos-ordem (no-dir t))(list (no-chave t)))]))

(check-equal? (pos-ordem empty) empty)
(check-equal? (pos-ordem (no 5 empty empty)) (list 5))
(check-equal? (pos-ordem t) (list 1 6 3 14 10 8))
