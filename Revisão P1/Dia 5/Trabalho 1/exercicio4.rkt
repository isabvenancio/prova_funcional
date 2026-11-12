#lang racket
(require rackunit)

;pilha
(struct pilha (topo) #:transparent)
(struct no (valor proximo) #:transparent)

;vazia
(define vazia (pilha #f))

;empilhar
(define (empilhar p valor)
    (pilha (no valor (pilha-topo p))))

;desempilhar
(define (desempilhar p)
    (cond
        [(pilha? p) (pilha-anterior p)]
        [else #f]))

;consultar topo
(define (consultar-topo p)
    (cond
        [(pilha? p) (pilha-valor p)]
        [else "A pilha está vazia"]))
    