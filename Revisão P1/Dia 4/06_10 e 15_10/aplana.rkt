#lang racket
(require rackunit)
(define (aplana lst)
    (cond
        [(empty? lst) empty]
        [(list? (first lst)) (append (aplana (first lst)) (aplana (rest lst)))]
        [else (cons (first lst) (aplana (rest lst)))]))

(check-equal? (aplana (list 1 2 3 4)) (list 1 2 3 4))
(check-equal? (aplana empty) empty)
(check-equal? (aplana (list 1 2 (list 3 4 (list 5 6) 7) 8 9 (list 10 11 12 13))) (list 1 2 3 4 5 6 7 8 9 10 11 12 13))


(define (aplana-lista lista)
    (cond
        [(empty? lista) empty];;verifica se a lista esta vazia, se for retorna empty
        [(list? (first lista)) (append (aplana-lista (first lista))(aplana-lista (rest lista)))]
        ;; verifica se o primeiro elemento da lista é uma lista (sublista), se for, chama a função recursivamente para a sublista e para o resto da lista, e depois concatena os resultados usando append
        [else (cons (first lista)(aplana-lista (rest lista)))])) 
        ;;senao, com cons o primeiro elemento da lista e chama a função recursivamente para o resto da lista

(check-equal? (aplana-lista (list 1 2 3 4)) (list 1 2 3 4))
(check-equal? (aplana-lista empty) empty)
(check-equal? (aplana-lista (list 1 2 (list 3 4 (list 5 6) 7) 8 9 (list 10 11 12 13))) (list 1 2 3 4 5 6 7 8 9 10 11 12 13))