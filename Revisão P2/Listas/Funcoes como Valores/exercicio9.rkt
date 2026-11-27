#lang racket
(require rackunit)

(define (mapeia f . lsts)
    (cond
        [(empty? (first lsts)) empty]
        [else (cons (apply f (map first lsts)) (apply mapeia f (map rest lsts)))]))
        ;;calcula o elemento atual do resultado e cuida do resto

(check-equal? (mapeia + (list 1 2 3) (list 4 5 6) (list 7 8 9)) (list 12 15 18))
(check-equal? (mapeia list (list 1 2 3) (list 4 5 6) (list 7 8 9)) (list (list 1 4 7) (list 2 5 8) (list 3 6 9)))
(check-equal? (mapeia * (list 1 2) (list 3 4)) (list 3 8))
(check-equal? (mapeia add1 (list 1 2)) (list 2 3))