#lang racket
(require rackunit)

(define (soma-ate n)
    (cond
        [(zero? n) 0]
        [else (+ n (soma-ate (sub1 n)))]))

(check-equal? (soma-ate 10) 55)
(check-equal? (soma-ate 0) 0)
(check-equal? (soma-ate 5) 15)
(check-equal? (soma-ate 1) 1)


(define (soma-ate-inteiros n)
    (cond
        [(zero? n) 0]
        [else (+ n (soma-ate-inteiros (sub1 n)))]))

(check-equal? (soma-ate-inteiros 3) 6)
;;3 + (soma-ate-inteiros 2)
;;3 + (2 + (soma-ate-inteiros 1))
;;3 + (2 + (1 + (soma-ate-inteiros 0)))
;;3 + (2 + (1 + 0))

(check-equal? (soma-ate-inteiros 4) 10)
;;4 + (soma-ate-inteiros 3)
;;3 + (soma-ate-inteiros 2)
;;2 + (soma-ate-inteiros 1)
;;1 + (soma-ate-inteiros 0)
;;0 + (soma-ate-inteiros 0)
;;