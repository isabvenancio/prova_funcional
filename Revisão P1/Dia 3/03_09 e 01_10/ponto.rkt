#lang racket
(struct ponto (x y) #:transparent)

;p eh um ponto
(define (distancia-da-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))



(require rackunit)

(define (distancia-origem p)
    (sqrt (+ (sqr (ponto-x p))(sqr (ponto-y p)))))

(check-equal? (distancia-origem (ponto 3 4)) 5)
(check-equal? (distancia-origem (ponto 0 0)) 0)
(check-equal? (distancia-origem (ponto 5 6)) 7.810249675906654)