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

(define (abb? t)
  (cond
    [(empty? t) #t] 
    [(not (empty? (no-esq t))) ;;verifica se o nó da esquerda é menor que o nó atual e se a subárvore da esquerda é uma ABB
        (and (< (no-chave (no-esq t)) (no-chave t))
            (abb? (no-esq t))
            (abb? (no (no-chave t) (no-dir (no-esq t)) (no-dir t))))] 
            ; o mesmo valor de t ((no-chave t));
            ; como filho esquerdo, o filho direito do filho esquerdo de t ((no-dir (no-esq t)));
            ; como filho direito, o mesmo filho direito de t ((no-dir t)).

    [(not (empty? (no-dir t)));;verifica se o nó da direita é maior que o nó atual e se a subárvore da direita é uma ABB
        (and (> (no-chave (no-dir t)) (no-chave t))
            (abb? (no-dir t))
            (abb? (no (no-chave t) empty (no-esq (no-dir t)))))]
            ; o mesmo valor de t;
            ; empty como filho esquerdo, que t já não tinha;
            ; como filho direito, o filho esquerdo do filho direito de t ((no-esq (no-dir t))).
    [else #t]))

(check-equal? (abb? empty) #t)
(check-equal? (abb? t) #t)
(check-equal? (abb? (no 5 (no 7 empty empty) empty)) #f)
(check-equal? (abb? (no 5 (no 3 empty (no 6 empty empty)) empty)) #f)
(check-equal? (abb? (no 5 empty (no 5 empty empty))) #f)