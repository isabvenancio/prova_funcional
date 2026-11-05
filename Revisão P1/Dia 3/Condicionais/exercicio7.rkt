#lang racket
(require rackunit)

(define (funcao-matematica x)
    (cond
        [(<= x 1) 1]
        [(and (> x 1)(<= x 2) 2)]
        [(and (> x 2)(<= x 3) (* x x))]
        [else (* x x x)]))

(check-equal? (funcao-matematica 3) 9)
(check-equal? (funcao-matematica 1) 1)
(check-equal? (funcao-matematica 4) 64)
(check-equal? (funcao-matematica 0) 1)
(check-equal? (funcao-matematica 2) 2)
(check-equal? (funcao-matematica -1) 1)