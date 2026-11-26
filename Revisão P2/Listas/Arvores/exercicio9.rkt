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

(define (menor t)
    (cond
        [(empty? (no-esq t)) (no-chave t)]
        ; se o filho da esquerda estiver vazio, significa q n tem nenhum numero menor q o nó atual -> retorna o atual
        [else (menor (no-esq t))]))
        ; se continuar existindo filho busca na esquerda

(check-equal? (menor (no 5 empty empty)) 5)
(check-equal? (menor (no 5 empty (no 9 empty empty))) 5)
(check-equal? (menor t) 1)