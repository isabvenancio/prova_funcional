#lang racket
(require rackunit)

(define (remove-negativo lst)
    (cond
        [(empty? lst) empty]
        [(< (first lst) 0)(remove-negativo (rest lst))]
        ; ou (negative? (first lst) 
        [else (cons (first lst) (remove-negativo (rest lst)))]))

(check-equal? (remove-negativo (list 5 8 -3 7 0 -4 -10)) (list 5 8 7 0))
(check-equal? (remove-negativo (list -2 6 4 -5 1)) (list 6 4 1))
(check-equal? (remove-negativo (list -7 -2 -4)) empty)


(define (remove-negativo-lista lista)
    (cond
        [(empty? lista) empty];; verifica se a lista é vazio, se for é retornado vazio
        [(negative? (first lista)) (remove-negativo-lista (rest lista))] ;; verifica se o primeiro elemento da lista é negativo, se for é chamado a função recursivamente com o resto da lista
        [else (cons (first lista)(remove-negativo-lista (rest lista)))])) ;;se o primeiro elemento da lista não for negativo, retona cons do primeiro elemento da lista atual mais a chamada recursiva da função com o resto da lista

(check-equal? (remove-negativo-lista (list -3 4 6 -9 2 0 4 -6 1)) (list 4 6 2 0 4 1))
(check-equal? (remove-negativo-lista (list 2 6 4 -5 1)) (list 2 6 4 1))
(check-equal? (remove-negativo-lista (list -7 -2 -4)) empty)
(check-equal? (remove-negativo-lista (list 5 -3 7 -4)) (list 5 7))
;;(cons (5 (remove-negativo-lista (list -3 7 -4))) -> chamada recursiva da função com o resto da lista (list -3 7 -4) e o primeiro elemento da lista atual (5) é adicionado a lista resultante
;;(negative? 3)(remove-negativo-lista (list 7 -4)) -> chamada recursiva da função com o resto da lista (list 7 -4)
;;(cons (7 (remove-negativo-lista (list -4)))) -> chamada recursiva da função com o resto da lista (list -4) e o primeiro elemento da lista atual (7) é adicionado a lista resultante
;;(negative? -4)(remove-negativo-lista empty) -> chamada recursiva da função com a lista vazia
;;(empty? empty) -> retorna empty
;;agora retorna (cons 7 empty) -> (list 7) e depois retorna (cons 5 (list 7)) -> (list 5 7) e finalmente retorna (list 5 7)
;; cons ele tava guardando o primeiro elemento da lista atual e adicionando a lista resultante da chamada recursiva da função com o resto da lista, assim ele vai construindo a lista final sem os elementos negativos



