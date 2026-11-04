#lang racket
(require rackunit)
(define (media-arit x y)
  (exact->inexact (/ (+  x y) 2)))

(media-arit 3 5)


(define (media-aritmetica x y)
  (/ (+ x y) 2))

(check-equal? (media-aritmetica 2 3) 5/2)
(check-equal? (media-aritmetica 0 0) 0)
(check-equal? (media-aritmetica 3 5) 4)