#lang racket
(require rackunit)

;; Ponto representa uma coordenada no plano cartesiano.
;; x: Number - coordenada horizontal
;; y: Number - coordenada vertical
(struct ponto (x y) #:transparent)

;; Ponto Ponto -> Number
;; Calcula a distância euclidiana entre dois pontos.
(define (distancia p1 p2)
    (sqrt (+ (sqr (- (ponto-x p2) (ponto-x p1)))
           (sqr (- (ponto-y p2) (ponto-y p1)))))) 

(check-equal? (distancia (ponto 0 0) (ponto 3 4)) 5)
(check-equal? (distancia (ponto 1 1) (ponto 1 1)) 0)
(check-equal? (distancia (ponto -1 -1) (ponto 2 3)) 5)
(check-equal? (distancia (ponto 0 0) (ponto 6 8)) 10)
