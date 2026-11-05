#lang racket
(require rackunit)

(define (par-impar num)
    (if (even? num)
        "par"
        "impar"))

(check-equal? (par-impar 3) "impar")
(check-equal? (par-impar 0) "par")
(check-equal? (par-impar 2) "par")

;;ou

(define (impar-par num)
    (cond
        [(= (remainder num 2) 0) "par"]
        [else "impar"]
        ))

(check-equal? (impar-par 3) "impar")
(check-equal? (impar-par 0) "par")
(check-equal? (impar-par 2) "par")
