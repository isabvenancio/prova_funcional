#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (abb? t)
  (cond
    [(empty? t) #t] 
    [(not (empty? (no-esq t))) ;;verifica se o nó da esquerda é menor que o nó atual e se a subárvore da esquerda é uma ABB
        (and (< (no-valor (no-esq t)) (no-valor t))
            (abb? (no-esq t))
            (abb? (no (no-valor t) (no-dir (no-esq t)) (no-dir t))))] 
            ; o mesmo valor de t ((no-valor t));
            ; como filho esquerdo, o filho direito do filho esquerdo de t ((no-dir (no-esq t)));
            ; como filho direito, o mesmo filho direito de t ((no-dir t)).

    [(not (empty? (no-dir t)));;verifica se o nó da direita é maior que o nó atual e se a subárvore da direita é uma ABB
        (and (> (no-valor (no-dir t)) (no-valor t))
            (abb? (no-dir t))
            (abb? (no (no-valor t) empty (no-esq (no-dir t)))))]
            ; o mesmo valor de t;
            ; empty como filho esquerdo, que t já não tinha;
            ; como filho direito, o filho esquerdo do filho direito de t ((no-esq (no-dir t))).
    [else #t]))


(check-equal? (abb? empty) #t)
(check-equal? (abb? (no 5 empty empty)) #t)
(check-equal? (abb? (no 5 (no 3 empty empty) (no 8 empty empty))) #t)
(check-equal? (abb? (no 5 (no 3 empty empty) empty)) #t)
(check-equal? (abb? (no 5 empty (no 8 empty empty))) #t)