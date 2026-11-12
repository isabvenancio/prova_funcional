#lang racket
(require rackunit)

;o depósito de r reais é feito no fim de cada mes, e o saldo q já estava na aplicação rende p% naquele mes
;base: S(0) = 0
;recursivo: S(t) = S(t-1) * (1 + p/100) + r -> caso recursivo vezes o rendimento do mês + o depósito do mês

(define (total-acumulado r p t)
    (cond
        [(<= t 0) 0]
        [else (+ (* (total-acumulado r p (sub1 t)) (+ 1 (/ p 100))) r)]))

(check-equal? (total-acumulado 100 100 0) 0)
(check-equal? (total-acumulado 100 0 5) 500) ;sem rendimento r*t
(check-equal? (total-acumulado 100 100 1) 100) ;0 * 2 + 100
(check-equal? (total-acumulado 100 100 3) 700) ;100 -> 300 -> 700
(check-equal? (total-acumulado 100 10 2) 210) ;100 * 1,1 + 100
(check-equal? (total-acumulado 50 20 2) 110) ;50 * 1,2 + 50

;;saldo e meses começa com 0
(define (ultrapassar-total r p m [saldo 0] [meses 0])
    (cond
        [(> saldo m) meses];;Quando o saldo ultrapassar o valor desejado, retornamos a quantidade de meses.
        [else (ultrapassar-total r p m (+ (* saldo (+ 1 (/ p 100))) r) (add1 meses))]
        ;;Atualizamos o saldo com o rendimento e o depósito. Acrescentamos 1 à quantidade de meses. Chamamos a própria função novamente.
        ))


(check-equal? (ultrapassar-total 100 10 -1) 0) ; 0 já é maior que -1
(check-equal? (ultrapassar-total 100 0 450) 5) ; 500 > 450
(check-equal? (ultrapassar-total 100 0 500) 6) ; precisa ultrapassar, não só atingir
(check-equal? (ultrapassar-total 100 100 650) 3) ; 100, 300, 700
(check-equal? (ultrapassar-total 100 100 700) 4) ; 700 não ultrapassa 700; 1500 sim
(check-equal? (ultrapassar-total 100 1 1000) 10) ; 9 meses: 936,85 e 10 meses: 1046,22


