#lang racket
(require rackunit)

(define (soma-alinhada lst)
    (cond
        [(empty? lst) 0]
        [(list? (first lst)) [(+ (soma-alinhada (first lst))(soma-alinhada (rest lst)))]]
        [else ()]))