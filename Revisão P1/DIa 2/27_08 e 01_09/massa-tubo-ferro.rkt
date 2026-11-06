#lang racket
(require rackunit)

;; Comprimento é um número positivo dado em metros.
;; Massa é um número positivo dado em quilogramas.

;; Comprimento Comprimento Comprimento -> Massa
;; Calcula a massa de um tubo de ferro a partir das suas dimensões.
;; Requer que (> diametro-externo diametro-interno)

(define PI 3.14) ; na prática precisa de mais casas decimais!
(define DENSIDADE-FERRO 7874) ; em kg/m^3

(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (define area-externa (* PI (sqr (/ diametro-externo 2))))
  (define area-interna (* PI (sqr (/ diametro-interno 2))))
  (define area-da-base (- area-externa area-interna))
  (define volume (* area-da-base altura))
  (* volume DENSIDADE-FERRO))

  ;; O valor correto para (0.05, 0.03, 0.1) com PI = 3.14 é ~0.98897
(check-equal? (massa-tubo-ferro 0.05 0.03 0.1) 0.9889744000000001)
