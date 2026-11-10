#lang racket
(require rackunit)

(struct pilha (dados)#:transparent)
;; pilha representa uma pilha de valores
;; dados: list - lista que armazena os itens da pilha

(define (insere-inicio P x)
    (cons x P));;;;cons recebe o primeiro e o resto

(define (remove-inicio P)
    (cond
        [(empty? P) (error "pilha vazia")]
        [else (rest P)])) ;; manda o resto da lista

(define (empilhar P x)
    (pilha (insere-inicio (pilha-dados P) x))) ;uma pilha com novos dados atualizado
    ;; p é o resto da lista e o pilha-dados é o novo elemento a ser empilhado

(define (desempilhar P)
    (pilha (remove-inicio (pilha-dados P))))

(define (topo-pilha P)
    (cond
        [(empty? (pilha-dados P)) (error "pilha vazia")]
        [else (first (pilha-dados P))]))

(check-equal? (empilhar (pilha '()) 10)(pilha '(10)))
(check-equal? (empilhar (pilha '(10 20)) 5)(pilha '(5 10 20)))

(check-equal? (desempilhar (pilha '(10 20 30)))(pilha '(20 30)))
(check-equal? (desempilhar (pilha '(5)))(pilha '()))

(check-equal? (topo-pilha (pilha '(10 20 30))) 10)
(check-equal? (topo-pilha (pilha '(5))) 5)