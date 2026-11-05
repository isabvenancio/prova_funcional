#lang racket
(require rackunit)

(define (salario-imposto salario)
    (cond
        [(<= salario 1500.00) salario]
        [(and (> salario 1500.01)(<= salario 3000.00)) (* salario 0.1)]
        [(and (> salario 3000.01)(<= salario 4500.00)) (* salario 0.2)]
        [else (* salario 0.3)]))


(check-equal? (salario-imposto 2000.00) 200.0)
(check-equal? (salario-imposto 1200.00) 1200.0)
(check-equal? (salario-imposto 3030.00) 606.0)
(check-equal? (salario-imposto 6000.00) 1800.0)
(check-equal? (salario-imposto 1500.00) 1500.0)