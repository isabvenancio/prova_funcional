#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (insereNo arv valor)
    (cond
        [(empty? arv) (no valor empty empty)]
        [(= valor (no-valor arv)) arv]
        [(< valor (no-valor arv)) (no (no-valor arv) (insereNo (no-esq arv) valor) (no-dir arv))]
        [else (no (no-valor arv) (no-esq arv) (insereNo (no-dir arv) valor))]))

(define (buscaNo arv valor)
    (cond
        [(empty? arv) #f]
        [(= valor (no-valor arv)) arv]
        [(< valor (no-valor arv))(buscaNo (no-esq arv) valor)]
        [else (buscaNo (no-dir arv) valor)]))

(define (menorValor arv)
    (cond
        [(empty? (no-esq arv)) (no-valor arv)]
        [else (menorValor (no-esq arv))]))

(define (removeNo arv valor)
    (cond
        [(empty? arv) empty]
        [(< valor (no-valor arv)) (no (no-valor arv) (removeNo (no-esq arv) valor) (no-dir arv))]
        [(> valor (no-valor arv)) (no (no-valor arv) (no-esq arv) (removeNo (no-dir arv) valor))]
        [else
            (cond
                [(empty? (no-esq arv)) (no-dir arv)]
                [(empty? (no-dir arv)) (no-esq arv)]
                [else
                    (define menor (menorValor (no-dir arv)))
                    (no menor
                        (no-esq arv)
                        (removeNo (no-dir arv) menor))])]))

; Árvore inicial
(define arvore
    (no 8
        (no 3
            (no 1 empty empty)
            (no 6 empty empty))
        (no 10 empty
            (no 14
                (no 13 empty empty)
                empty))))

; TESTES DE INSERÇÃO
(check-equal? (insereNo empty 5)
              (no 5 empty empty))

(check-equal? (no-valor (insereNo arvore 5)) 8)

(check-equal? (insereNo arvore 3) arvore)

; TESTES DE BUSCA
(check-equal? (buscaNo arvore 6)
              (no 6 empty empty))

(check-equal? (buscaNo arvore 20) #f)

; TESTES DE REMOÇÃO

; Remover nó sem filhos
(check-equal? (removeNo arvore 1)
    (no 8
        (no 3 empty (no 6 empty empty))
        (no 10 empty (no 14 (no 13 empty empty) empty))))

; Remover nó com um filho
(check-equal? (removeNo arvore 10)
    (no 8
        (no 3
            (no 1 empty empty)
            (no 6 empty empty))
        (no 14 (no 13 empty empty) empty)))

; Remover nó com dois filhos
(check-equal? (removeNo arvore 8)
    (no 10
        (no 3
            (no 1 empty empty)
            (no 6 empty empty))
        (no 14 (no 13 empty empty) empty)))

; Remover elemento inexistente
(check-equal? (removeNo arvore 20) arvore)