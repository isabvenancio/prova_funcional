#lang racket

; (struct point (x y))
; (define origem (point 0 0))
; (define x 100)

; (point? (point 1 2)) ; => #t

; ---------------------------------------

(struct aluno (ra nome curso))
(define eu (aluno 123 "Nilton" "Biologia"))

(aluno-nome eu)
(aluno-curso eu)
(aluno? "Nilton")

; ---------------------------------------

(struct ponto (x y) )
(define origem (ponto 0 0))

(define p1 (ponto (+ (ponto-x origem) 5)(+ (ponto-y origem) 3)))
(ponto-x p1)
(ponto-y p1)

; --------------------------------------

