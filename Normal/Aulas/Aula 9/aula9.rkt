#lang racket
(require rackunit)

(define (inverte lst)
  (cond
    [(empty? lst) empty]
    [else (append (inverte (rest lst)) (list (first lst)))]))

(check-equal? (inverte '(1 2 3 4)) '(4 3 2 1))
(check-equal? (inverte '(1 2 2 1)) '(1 2 2 1))
(check-equal? (inverte '()) '())
(check-equal? (inverte '(5)) '(5))