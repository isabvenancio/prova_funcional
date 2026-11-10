#lang racket
(require rackunit)

(define (contem lst val)
  (cond
    [(empty? lst) #f]
    [(equal? (first lst) val) #t]
    [else (contem (rest lst) val)]))

(define lst1 '(1 2 3 4 5))
(check-equal? (contem lst1 3) #t)
(check-equal? (contem lst1 6) #f)


(define (contem-negativo lst val)
    (cond
        [(empty? lst) #f]
        [(and (negative? (first lst)) (equal? (first lst) val)) #t] ; Verifica se o primeiro elemento é negativo e igual ao valor
        ;;(equal? (first lst) val) só isso já bastaria, mas o enunciado pede para verificar se é negativo também
        [else (contem-negativo (rest lst) val)]))

(define lst2 '(1 -2 3 -4 5))
(check-equal? (contem-negativo lst2 -2) #t)
(check-equal? (contem-negativo lst2 -6) #f)


(define (remove-negativos lst)
  (cond
    [(empty? lst) empty]
    [(< (first lst) 0) (remove-negativos (rest lst))] ; Se o primeiro elemento for negativo, remove-o e continua com o resto da lista
    [else (cons (first lst)(remove-negativos (rest lst)))]))

(define lst3 '(1 -2 3 -4 5))
(check-equal? (remove-negativos lst3) '(1 3 5))


(define (soma-ate n)
    (cond
        [(zero? n) 0] ; Caso base: se n for 0, retorna 0
        [else (+ n (soma-ate(sub1 n)))])) ; Caso recursivo: soma n com a soma de todos os números até n-1 ; sub1 é uma função que decrementa o valor de n em 1

(define n 5)
(check-equal? (soma-ate n) 15)


(define (insere-fim lst n)
    (cond
        [(empty? lst) (list n)] ; Caso base: se a lista estiver vazia, retorna uma nova lista com o elemento n
        [else (cons (first lst) (insere-fim (rest lst) n))])) ; Caso recursivo: mantém o primeiro elemento e chama a função com o resto da lista

(define (lista-natural n)
    (cond
        [(zero? n) empty] ; Caso base: se n for 0, retorna uma lista vazia
        [else (insere-fim (lista-natural (sub1 n)) n)])) ; Caso recursivo: adiciona n à lista e chama a função com n-1

(check-equal? (lista-natural 5) '(1 2 3 4 5))
(check-equal? (lista-natural 0) '())
(check-equal? (lista-natural 3) '(1 2 3))

