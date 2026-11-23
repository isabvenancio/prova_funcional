#lang racket
(require rackunit)

(define (descarta lst n)
  (cond
    [(or (zero? n) (empty? lst)) lst]
    [else (descarta (rest lst) (sub1 n))]))

(check-equal? (descarta (list 10 40 70 20 3) 2) (list 70 20 3))
(check-equal? (descarta (list 10 40) 0) (list 10 40))
(check-equal? (descarta (list 10 40) 5) empty)