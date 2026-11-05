#lang racket
(require rackunit)

(define (soma-lista lst)
    (cond
        [(empty? lst) 0]
        ;;aq eu eu verifico se a lista é vazia, se for, retorno 0
        [else (+ (first lst)(soma-lista (rest lst)))]))
        ;;aq eu pego o primeiro elemento da lista e somo com a coma do resto da lista, que é chamada recursivamente

;first = car
;rest = cdr

;testes
(check-equal? (soma-lista (list 1 2 3 4)) 10)
(check-equal? (soma-lista empty) 0)
(check-equal? (soma-lista '()) 0)
(check-equal? (soma-lista (list )) 0)
(check-equal? (soma-lista '(1 2 3 4 5)) 15) ;;aq le direto como uma lista (')
(check-equal? (soma-lista (list 10 20 30)) 60) ;;aq chama a função list para criar a lista (list)