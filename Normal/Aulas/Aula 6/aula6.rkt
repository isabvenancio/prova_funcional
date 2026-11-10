#lang racket
(require rackunit)

#|
Struct -> tipo especial de dado que coloca varios tipos em um só (estilo enum)
|#

(struct contagem (verde vermelho azul branco) #:transparent)

; verde = 1
; vermelho = 2
; azul = 3
; branco = 4

(define (atualiza cont resp)
    (cond
        [(equal? resp "branco")
        (struct-copy contagem cont ;O struct-copy significa basicamente: Crie uma cópia da estrutura cont, mas altere o campo branco.
            [branco (+ 1 (contagem-branco cont))])]
        
        [(equal? resp "azul")
        (struct-copy contagem cont
            [azul (+ 1 (contagem-azul cont))])]

        [(equal? resp "vermelho")
        (struct-copy contagem cont
            [vermelho (+ 1 (contagem-vermelho cont))])]

        [(equal? resp "verde")
        (struct-copy contagem cont
            [verde (+ 1 (contagem-verde cont))])]
    ))


(check-equal? (atualiza (contagem 1 2 3 4) "branco")
            (contagem 1 2 3 5))

(check-equal? (atualiza (contagem 4 4 2 0) "azul")
            (contagem 4 4 3 0))

(check-equal? (atualiza (contagem 2 3 1 5) "vermelho")
            (contagem 2 4 1 5))

(check-equal? (atualiza (contagem 0 0 0 0) "verde")
            (contagem 1 0 0 0))