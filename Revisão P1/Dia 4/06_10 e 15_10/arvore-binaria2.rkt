#lang racket
(require rackunit)
(struct no (valor esq dir) #:transparent)

(define (cria-no valor)
    (no valor empty empty))

(define (inserir arvore node lado)
    (cond
        [(equal? lado "dir") (struct-copy no arvore [dir node])]
        [(equal? lado "esq") (struct-copy no arvore [esq node])]
        [else arvore]))

(define (busca arvore valor)
    (cond
        [(empty? arvore) #f]
        [(equal? (no-valor arvore) valor) #t] 
        [else (or (busca (no-esq arvore) valor) (busca (no-dir arvore) valor))]))

(define (altura arvore)
    (cond
        [(empty? arvore) 0]
        [else (+ 1 (max (altura (no-esq arvore)) (altura (no-dir arvore))))]))

(define t0 (cria-no 10))
(define t1 (no 9 t0 empty))
(define t2 (no 7 (cria-no 8) t1))
(define t3 (no 4 (cria-no 3) empty))
(define raiz (no 3 t3 t2))


(check-equal? (busca raiz 10) #t)
(check-equal? (busca raiz 4) #t)
(check-equal? (busca raiz 99) #f)

(define no-teste (cria-no 5))
(check-equal? (no-valor no-teste) 5)
(check-equal? (no-esq no-teste) empty)
(check-equal? (no-dir no-teste) empty)

(define no-com-esq (inserir (cria-no 5) (cria-no 3) "esq"))
(check-equal? (no-valor (no-esq no-com-esq)) 3)
(check-equal? (no-dir no-com-esq) empty) 

(define no-com-dir (inserir (cria-no 5) (cria-no 8) "dir"))
(check-equal? (no-valor (no-dir no-com-dir)) 8)
(check-equal? (no-esq no-com-dir) empty) 

(define no-invalido (inserir (cria-no 5) (cria-no 8) "meio"))
(check-equal? no-invalido (cria-no 5))

(check-equal? (altura empty) 0)
(check-equal? (altura (cria-no 5)) 1)
