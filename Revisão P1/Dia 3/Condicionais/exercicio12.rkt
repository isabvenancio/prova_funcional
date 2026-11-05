#lang racket
(require rackunit)

(define (ponto-cartesiano x y)
    (cond 
        [(and (> x 0)(> y 0)) "Primeiro Quadrante"]
        [(and (< x 0)(> y 0)) "Segundo Quadrante"]
        [(and (< x 0)(< y 0)) "Terceiro Quadrante"]
        [(and (> x 0)(< y 0)) "Quarto Quadrante"]
        [(and (= x 0)(= y 0)) "Origem"]
        [else "Sobre um dos eixos"]))

(check-equal? (ponto-cartesiano 2 3) "Primeiro Quadrante")
(check-equal? (ponto-cartesiano 3 0) "Sobre um dos eixos")
(check-equal? (ponto-cartesiano 3 -9) "Quarto Quadrante")
(check-equal? (ponto-cartesiano -3 -9) "Terceiro Quadrante")
(check-equal? (ponto-cartesiano -3 4) "Segundo Quadrante")
(check-equal? (ponto-cartesiano 0 0) "Origem")
