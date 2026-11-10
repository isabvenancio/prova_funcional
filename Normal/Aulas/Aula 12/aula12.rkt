#lang racket
(require rackunit)

;map f: D->I   lista

(define (lista-positivos lst)
    (cond
        [(empty? lst) empty]
        [(positive? (first lst))(cons (first lst)(lista-positivos (rest lst)))]
        [else (lista-positivos (rest lst))]
    )
)

(check-equal? (lista-positivos (list 1 2 -3 4 5 -6 -7 8))(list 1 2 4 5 8))

(define (lista-pares lst)
    (cond
        [(empty? lst) empty]
        [(even? (first lst))(cons (first lst)(lista-pares (rest lst)))]
        [else (lista-pares (rest lst))]))

(check-equal? (lista-pares (list 1 2 -3 4 5 -6 -7 8))(list 2 4 -6 8))

(define (filtra pred? lst)
    (cond
        [(empty? lst) empty]
        [(pred? (first lst))(cons (first lst)(filtra pred? (rest lst)))]
        [else (filtra pred? (rest lst))]))

(check-equal? (filtra positive? empty) empty)
(check-equal? (filtra positive? (list 1 2 -3 4 5 -6 -7 8)) (list 1 2 4 5 8))
(check-equal? (filtra even? (list 1 2 -3 4 5 -6 -7 8)) (list 2 4 -6 8))
(check-equal? (filtra odd? (list 1 2 -3 4 5 -6 -7 8)) (list 1 -3 5 -7))
(check-equal? (filtra negative? (list 1 2 3)) empty)
(filter negative? (list 4 6 10));'()
(filter even? (list 7 2 18));'(2 18)

;filter f:  D->Booleano    lista
(define (soma-lista lst)
    (cond
        [(empty? lst) 0]
        [else (+ (first lst)(soma-lista (rest lst)))]))

(define (produto-lista lst)
    (cond
        [(empty? lst) 1]
        [else (* (first lst)(produto-lista (rest lst)))]))

(check-equal? (soma-lista (list 4 3 1)) 8)
(check-equal? (soma-lista (list )) 0)
(check-equal? (produto-lista (list 4 3 1)) 12)
(check-equal? (produto-lista (list )) 1)

;reduzir f:DxD -> D     lista
(define (reduz f base lst)
    (cond
        [(empty? lst) base]
        [else (f (first lst)(reduz f base (rest lst)))]))

(check-equal? (reduz + 0 empty) 0)
(check-equal? (reduz * 1 (list 3 5 -2))-30)

;foldr
(define (foldr f base lst)
    (cond
        [(empty? lst) base]
        [else (f (first lst)(foldr f base (rest lst)))]))

(foldr + 0 (list 4 6 10)) ;20
(foldr cons empty (list 7 2 18)) ;'(7 2 18)
(foldr max 7 (list 7 2 18 -20)) ;18