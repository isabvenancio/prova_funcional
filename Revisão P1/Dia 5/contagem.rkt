#lang racket
(require rackunit)

;Exemplo contagem: enquete onde cada resposta é uma cor (verde, vermelho, azul ou branco)
; receber a contagem atual + uma nova resposta e produzir a contagem atualizada

;Análise: atualizar a contagem considerando uma nova resposta (verde, vermelho, azul ou branco)

; Tipos
;  - resposta → tipo enumerado 
;  - contagem → estrutura com um campo pra cada tipo de resposta

;; Resposta é um dos valores:
;; - "verde"
;; - "vermelho"
;; - "azul"
;; - "branco"

(struct contagem (verde vermelho azul branco) #:transparent)
;; Uma contagem das respostas de cada cor
;;    verde    : Número - número de respostas verde
;;    vermelho : Número - número de respostas vermelho
;;    azul     : Número - número de respostas azul
;;    branco   : Número - número de respostas branco

(define (atualiza-contagem res cont)
    (cond
        [(equal? res "verde")
            (struct-copy contagem cont [verde (add1 (contagem-verde cont))])]
            ;;pega a contagem atual (contagem-verde cont), copia ela e atualiza o campo verde com o valor incrementado em 1

        [(equal? res "vermelho")
            (struct-copy contagem cont [vermelho (add1 (contagem-vermelho cont))])]

        [(equal? res "azul")
            (struct-copy contagem cont [azul (add1 (contagem-azul cont))])]

        [(equal? res "branco")
            (struct-copy contagem cont [branco (add1 (contagem-branco cont))])]

        [else (error "Resposta inválida" res)]))


(check-equal? (atualiza-contagem "verde" (contagem 4 5 1 2)) (contagem 5 5 1 2))
 ;; (struct-copy contagem (contagem 4 5 1 2) [verde (add1 (contagem-verde (contagem 4 5 1 2)))])
(check-equal? (atualiza-contagem "vermelho" (contagem 4 5 1 2)) (contagem 4 6 1 2))