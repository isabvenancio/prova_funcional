#lang racket
(require rackunit)

;; Devolve #t se a > b.
(define (maior? a b)
  (cond
    [(zero? a) #f]
    [(zero? b) #t]
    [else (maior? (sub1 a) (sub1 b))]))

;; Devolve #t se a >= b.
(define (maior-igual? a b)
  (cond
    [(zero? b) #t]
    [(zero? a) #f]
    [else (maior-igual? (sub1 a) (sub1 b))]))

;; Devolve #t se a < b.
(define (menor? a b)
  (cond
    [(zero? b) #f]
    [(zero? a) #t]
    [else (menor? (sub1 a) (sub1 b))]))

;; Devolve #t se a <= b.
(define (menor-igual? a b)
  (cond
    [(zero? a) #t]
    [(zero? b) #f]
    [else (menor-igual? (sub1 a) (sub1 b))]))

;; Devolve #t se a = b.
(define (igual? a b)
  (cond
    [(zero? a) (zero? b)]
    [(zero? b) #f]
    [else (igual? (sub1 a) (sub1 b))]))

(check-equal? (list (maior? 5 2) (maior? 2 5) (maior? 3 3) (maior? 0 0)) '(#t #f #f #f))
(check-equal? (list (maior-igual? 5 2) (maior-igual? 2 5) (maior-igual? 3 3) (maior-igual? 0 0)) '(#t #f #t #t))
(check-equal? (list (menor? 2 5) (menor? 5 2) (menor? 3 3) (menor? 0 0)) '(#t #f #f #f))
(check-equal? (list (menor-igual? 2 5) (menor-igual? 5 2) (menor-igual? 3 3) (menor-igual? 0 0)) '(#t #f #t #t))
(check-equal? (list (igual? 3 3) (igual? 3 4) (igual? 4 3) (igual? 0 0) (igual? 0 2)) '(#t #f #f #t #f))
