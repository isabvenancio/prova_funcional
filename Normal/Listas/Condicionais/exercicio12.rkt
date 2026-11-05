#|Faça uma função que receba um ponto no plano cartesiano e retorne em qual quadrante
ele se encontra.|#

#lang racket

(define (plano_cartesiano x y)
  (cond
    [(and (> x 0) (> y 0)) "Primeiro Quadrante"]
    [(and (< x 0) (> y 0)) "Segundo Quadrante"]
    [(and (< x 0) (< y 0)) "Terceiro Quadrante"]
    [(and (> x 0) (< y 0)) "Quarto Quadrante"]
    [(and (= x 0) (= y 0)) "Origem"]
    [else "Sobre um dos eixos"]
    ))

(plano_cartesiano 2 3)
(plano_cartesiano 3 0)
(plano_cartesiano 0 0)
