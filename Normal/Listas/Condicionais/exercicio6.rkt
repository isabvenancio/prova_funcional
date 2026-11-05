#|Faça um função que receba o salário de um funcionário e calcule e retorne seu imposto
de renda com base na tabela a seguir:
Intervalo do Salário Desconto do imposto de renda
Até 1500,00 Isento
Entre 1500,01 e 3000,00 10%
Entre 3000,01 e 4500,00 20%
Acima de 4500,01 30%|#

#lang racket

(define (imposto_salario salario)
    (cond
        [(<= salario 1500.00) salario]
        [(and(> salario 1500.01)(<= salario 3000.00)) (* salario 0.1)]
        [(and(> salario 3000.01)(<= salario 4500.00)) (* salario 0.2)]
        [else (* salario 0.3)]

    ))

(imposto_salario 2000.00)
(imposto_salario 1200.00)
(imposto_salario 3030.00)
(imposto_salario 6000.00)
(imposto_salario 1500.00)