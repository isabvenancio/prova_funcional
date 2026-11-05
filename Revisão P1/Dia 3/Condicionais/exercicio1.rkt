#lang racket
(require rackunit)

(define (comparacao-zero num)
    (cond
        [(< num 0) "menor que zero"]
        [(> num 0) "maior que zero"]
        [else "igual a zero"]))

(check-equal? (comparacao-zero 3) "maior que zero")
(check-equal? (comparacao-zero -4) "menor que zero")
(check-equal? (comparacao-zero 0) "igual a zero")