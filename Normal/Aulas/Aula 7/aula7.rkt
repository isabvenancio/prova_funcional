#lang racket
(require rackunit)

#|Autorreferencia e Recursividade|#

; Lista (Estrutura de Dados) -> Recursiva

; | 3 ||->| 6 ||->| 2 ||-| (resto)

(struct lista (primeiro resto) #:transparent)
(struct vazia () #:transparent)

(define lv (vazia))
(define l1 (lista 3 (lista 6 (lista 2 (vazia)))))
(define l2 (lista 9 (vazia)))

(displayln l1) ;print
(displayln lv)
(displayln l2)
(equal? lv (lista-resto l2)) ;; a lista lv (vazia) é igual ao resto da lista l2 (vazia) = true

;; a lista é vazia ou é um link (próxima)
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (+ (lista-primeiro ldn)
        (fn-para-ldn (lista-resto ldn)))]))

;; exemplo: uma funcao que some uma lista de numeros
(define (soma-lista ldn)
  (cond
    [(vazia? ldn) 0] ; caso base = se a lista for vazia, retorna 0
    [else
     (+ (lista-primeiro ldn)(soma-lista (lista-resto ldn)))] ; caso recursivo = soma o primeiro elemento da lista com a soma do resto da lista
    )
)

(check-equal? (soma-lista lv) 0)
(check-equal? (soma-lista l1) 11)
(check-equal? (soma-lista l2) 9)
(check-equal? (soma-lista (lista 1 (lista 2 (lista 3 (lista 4 (vazia)))))) 10)


;; empty ao invés de vazia
;; cons ao invés de lista
;; first ao invés de lista-primeiro
;; rest ao invés de lista-resto

;; refazer a função soma-lista usando empty, cons, first e rest

(define lv-2 empty)
(define l1-2 (list 3 6 2))
(define l2-2 (list 9))

(define (soma-lista-2 ldn)
    (cond
        [(empty? ldn) 0]
        [else
        (+ (first ldn)(soma-lista-2 (rest ldn)))]
    )
)

(check-equal? (soma-lista-2 lv-2) 0)
(check-equal? (soma-lista-2 l1-2) 11)
(check-equal? (soma-lista-2 l2-2) 9)
(check-equal? (soma-lista-2 (list 1 2 3 4)) 10)
