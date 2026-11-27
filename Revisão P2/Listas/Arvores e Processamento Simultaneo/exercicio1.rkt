#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (soma-arvore t n)
    (cond
        [(empty? t) empty]
        [else (no (+ (no-valor t) n) ;;cria um nó novo com o valor do nó atual + n
            (soma-arvore (no-esq t) n)
            (soma-arvore (no-dir t) n))]))

(define t
  (no 3
      (no 4 (no 3 empty empty) empty)
      (no 7
          (no 8 empty empty)
          (no 9 (no 10 empty empty) empty))))

(check-equal? (soma-arvore empty 5) empty)
(check-equal? (soma-arvore empty -3) empty)
(check-equal? (soma-arvore (no 1 empty empty) 4) (no 5 empty empty))

