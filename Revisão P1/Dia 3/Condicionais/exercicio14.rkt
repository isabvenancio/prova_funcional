#lang racket
(require rackunit)


(define (obter-menor a b c)
    (min a b c))

(define (obter-maior a b c)
    (max a b c))

(define (obter-meio a b c)
    (- (+ a b c)(obter-menor a b c)(obter-maior a b c)))

(define (subitem-a a b c)
    (- (obter-maior a b c)(obter-menor a b c)))

(define (subitem-b a b c)
    (* (obter-meio a b c)(obter-menor a b c)))

(define (subitem-c a b c)
    (+ (obter-meio a b c)(obter-maior a b c)))


(define n1 5)
(define n2 10)
(define n3 2)

(check-equal? (subitem-a n1 n2 n3) 8)
(check-equal? (subitem-b n1 n2 n3) 10)
(check-equal? (subitem-c n1 n2 n3) 15)