#lang racket
(require rackunit)

(define (intercala l1 l2)
  (cond
    [(empty? l1) l2]
    [(empty? l2) l1]
    [(<= (first l1) (first l2)) (cons (first l1) (intercala (rest l1) l2))]
    [else (cons (first l2) (intercala l1 (rest l2)))]))

(check-equal? (intercala empty empty) empty)
(check-equal? (intercala (list 1 2) empty) (list 1 2))
(check-equal? (intercala (list 3 7 12) (list 2 4 5)) (list 2 3 4 5 7 12))
(check-equal? (intercala (list 1 3 3) (list 3 4)) (list 1 3 3 3 4))