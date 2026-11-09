#lang racket
(require rakcunit)

;fila
(struct fila (valor proximo) #:transparent)

;consultar primeiro
(define (consultar_primeiro f)
    (cond
        [(fila? f) (fila-valor f)]
        [else "A fila está vazia"]))

;enfileirar
(define (enfileirar f valor)
    (cond
        [(fila? f) (fila (fila-valor f)(enfileirar (fila-proximo f) valor))]
        [else (fila valor #f)]))

;desenfileirar
(define (desenfileirar f)
    (cond
        [(fila? f) (fila-proximo f)]
        [else #f]))