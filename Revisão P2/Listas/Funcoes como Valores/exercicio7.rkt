#lang racket
(require rackunit)

(define (minha-list . args) args)

(check-equal? (minha-list) empty)
(check-equal? (minha-list 1 2 3) (list 1 2 3))