#lang racket
(require rackunit)
(define (soma-aninhada lst)
    (cond
        [(empty? lst) 0]
        [(list? (first lst)) (+ (soma-aninhada (first lst))(soma-aninhada (rest lst)))]
        [else (+ (first lst)(soma-aninhada (rest lst)))]))

(soma-aninhada (list  (list (list 5) 1 2 empty 3)  (list 1 (list 3 4))  4));;23


(define (somar-escondidos-alinhados lista)
    (cond
        [(empty? lista) 0] ;;veririca se a lista está vazia, se for retorna soma 0
        [(list? (first lista)) (+ (somar-escondidos-alinhados (first lista))(somar-escondidos-alinhados (rest lista)))]
        ;;verifica se o primeiro elemento da lista é uma lista(sublista), se for, chama a função recursivamente para somar os elementos da lista e da lista restante
        ;;o aplana era (append()()) e (cons()()), aq será (+()())
        [else (+ (first lista)(somar-escondidos-alinhados (rest lista)))]))
        ;;senao, soma o primeiro elemento da lista e chama a função recursivamente para somar os elementos da lista restante

(check-equal? (somar-escondidos-alinhados (list 1 2 3 4 5)) 15)
(check-equal? (somar-escondidos-alinhados (list (list (list 5) 1 2 empty 3) (list 1 (list 3 4)) 4)) 23)
(check-equal? (somar-escondidos-alinhados (list empty (list empty 10) empty 20)) 30)
(check-equal? (somar-escondidos-alinhados (list (list (list (list 7))))) 7)