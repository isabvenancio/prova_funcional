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

(define (maior t)
    (cond
        [(empty? (no-dir t)) (no-chave t)]
        ; se o filho da direita estiver vazio, significa q n tem nenhum numero maior q o nó atual -> retorna o atual
        [else (maior (no-dir t))]))
        ; se continuar existindo filho busca na direita

(check-equal? (maior (no 5 empty empty)) 5)
(check-equal? (maior (no 5 (no 3 empty empty) empty)) 5)
(check-equal? (maior t) 14)