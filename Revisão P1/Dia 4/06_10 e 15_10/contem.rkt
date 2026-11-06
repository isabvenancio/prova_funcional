#lang racket
(require rackunit)

(define (contem lst val)
    (cond
        [(empty? lst) #f]
        [(equal? (first lst) val) #t]
        [else (contem (rest lst) val)]))

(define l1 (list 4 8 3 6 5 0 2))
(check-equal? (contem l1 5) #t)
(check-equal? (contem l1 4) #t)
(check-equal? (contem l1 2) #t)
(check-equal? (contem l1 7) #f)
(check-equal? (contem l1 9) #f)

(define (contem-numero lista valor)
    (cond
        [(empty? lista) #f]; se a lista for vazia, entao é false
        [(equal? (first lista) valor) #t]; se o primeiro elemento da lista é igual ao valor q procuramos, ent é true
        [else (contem (rest lista) valor)])); senao , chamamos a funcao contem novamente, mas agora com o resto da lista

(define l2 '(1 3 5 7 9))
(check-equal? (contem-numero l2 5) #t)
(check-equal? (contem-numero l2 2) #f)  