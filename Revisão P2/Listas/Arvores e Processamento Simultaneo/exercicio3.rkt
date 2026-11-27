#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (busca-elemento t x)
    (cond
        [(empty? t) #f] ;; se a arvore for vazia, o elemento não foi encontrado
        [(= x (no-valor t)) #t] ;; se o elemento for igual ao valor do nó atual, o elemento foi encontrado
        [else (or 
            (busca-elemento (no-esq t) x)
            (busca-elemento (no-dir t) x))]))

(define t (no 8 (no 3 empty empty) (no 10 empty (no 14 empty empty))))

(check-equal? (busca-elemento empty 5) #f)
(check-equal? (busca-elemento t 8) #t)
(check-equal? (busca-elemento t 3) #t)
(check-equal? (busca-elemento t 14) #t)
(check-equal? (busca-elemento t 7) #f)
(check-equal? (busca-elemento t 100) #f)


