#lang racket
(require rackunit)

(struct no (valor esq dir) #:transparent)

(define (cria-no valor)
    (no valor empty empty))

(define (altura t)
    (cond
        [(empty? t) 0]
        [else (+ 1 (max (altura (no-esq t)) (altura (no-dir t))))]))

(define (insere t n lado)
    (cond
        [(equal? lado "dir")
            (struct-copy no t [dir n])]
        [(equal? lado "esq")
            (struct-copy no t [esq n])]
        [else t]
    )
)

(define t0 (cria-no 10))
(define t1-aux (cria-no 9))
(define t1 (insere t1-aux t0 "esq"))
; (define t2-aux (cria-no 7))
; (define t2-filhoesq (insere t2-aux (cria-no 8) "esq"))
; (define t2-filhodir (insere t2-filhoesq t1 "dir"))
(define t2 (no 7 (cria-no 8) t1))
(define t3 (no 4 (cria-no 3) empty))
(define raiz (no 3 t3 t2))
(displayln raiz)

(altura raiz)
(altura t0)
(altura t1)
(altura t2)
(altura t3)



