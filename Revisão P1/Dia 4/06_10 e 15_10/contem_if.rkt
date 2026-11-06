#lang racket
(require rackunit)

(define (contem lst val)
    (cond
        [(empty? lst) #f]
        [else (if (equal? (first lst) val)
            #t
            (contem (rest lst) val))]))

(define l1 (list 4 8 3 6 5 0 2))
(check-equal? (contem l1 5) #t)
(check-equal? (contem l1 4) #t)
(check-equal? (contem l1 2) #t)
(check-equal? (contem l1 7) #f)
(check-equal? (contem l1 9) #f)


(define (contem-numero-if lista valor)
    (cond
        [(empty? lista) #f]
        [else (if (equal? (first lista) valor)
            #t
            (contem-numero-if (rest lista) valor))]))

(define l2 '(2 3 5 6 1 20))
(check-equal? (contem-numero-if l2 4) #f)
(check-equal? (contem-numero-if l2 20) #t)
(check-equal? (contem-numero-if l2 7) #f)
