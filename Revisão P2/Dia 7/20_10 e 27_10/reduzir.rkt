#lang racket
(require rackunit)
(define (reduzir-funcao funcao base lst)
  (cond
    [(empty? lst) base]
    [else (funcao (first lst)(reduzir-funcao funcao base (rest lst)))]))

(check-equal? (reduzir-funcao + 0 (list 1 2 3 4 5)) 15)
(check-equal? (reduzir-funcao + 0 (list )) 0)
(check-equal? (reduzir-funcao + 0 (list 3 -2 7 4 -1 -9)) 2)
(check-equal? (reduzir-funcao * 1 (list 1 2 3 4 5)) 120)
(check-equal? (reduzir-funcao * 1 (list 1 2 3)) 6)
(check-equal? (reduzir-funcao * 1 (list )) 1 )
