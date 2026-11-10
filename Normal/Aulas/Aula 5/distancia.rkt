#lang racket

(struct ponto (x y) #:transparent)

;p é um ponto
(define (distancia-da-origem p)
    sqrt (+ (sqrt (ponto-x p))
            (sqrt (ponto-y p))))

(distancia-da-origem (ponto 2 4))

