#lang racket
(require rackunit)
(define (insere-fim lst n)
    (cond
        [(empty? lst) (cons n empty)] ; (list n)
        [else (cons (first lst)(insere-fim (rest lst) n))]))

(define (lista-natural n)
    (cond
        [(zero? n) empty]
        [else (insere-fim (lista-natural (sub1 n)) n)]))

(check-equal? (lista-natural 5) (list 1 2 3 4 5))
(check-equal? (lista-natural 0) empty)
(check-equal? (lista-natural 1) (list 1))
(check-equal? (lista-natural 9) (list 1 2 3 4 5 6 7 8 9))


(define (insere-final lista num)
    (cond
        [(empty? lista) (list num)] ;; verifica se a lista esta vazia, se sim, cria uma lista com um numero
        [else (cons (first lista)(insere-final (rest lista) num))])) ;; se nao, cons pega o primeiro elemento da lista e chama a funcao recursivamente com o resto da lista e o numero a ser inserido no final

(define (cria-lista num)
    (cond
        [(zero? num) empty] ;;verifica se o numero é zero, se sim, retorna uma lista vazia
        [else (insere-final (cria-lista (sub1 num)) num)])) ;;se nao, chama para inserir no final da lista o numero atual e chama a funcao recursivamente com o numero decrementado em 1

(check-equal? (cria-lista 3) (list 1 2 3))
(check-equal? (cria-lista 0) '())
(check-equal? (cria-lista 1) (list 1))
(check-equal? (cria-lista 5) (list 1 2 3 4 5))