#lang racket
(require rackunit)

(struct fila (dados)#:transparent)
;; fila representa uma fila de valores
;; dados: list - lista que armazena os itens da fila

(define (remove-inicio F)
    (cond
        [(empty? F) (error "fila vazia")]
        [else (rest F)]))

(define (insere-final F x)
    (cond
        [(empty? F) (list x)]
        [else (cons (first F)(insere-final (rest F) x))] ;;recebe o primeiro e o restante da lista
))

(define (enfileirar F x)
    (fila (insere-final (fila-dados F) x)))

(define (desenfileirar F)
    (fila (remove-inicio (fila-dados F))))

(define (primeiro-fila F)
    (cond
        [(empty? (fila-dados F)) (error "fila vazia")]
        [else (first (fila-dados F))]
    ))

(check-equal? (enfileirar (fila '()) 10) (fila '(10)))
(check-equal? (enfileirar (fila '(10 20)) 30) (fila '(10 20 30)))

(check-equal? (desenfileirar (fila '(10 20 30))) (fila '(20 30)))
(check-equal? (desenfileirar (fila '(10))) (fila '()))

(check-equal? (primeiro-fila (fila '(10 20 30))) 10)
(check-equal? (primeiro-fila (fila '(5))) 5)
