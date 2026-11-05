#|A Chevrolet abriu uma linha de crédito para compra de carros aos seus clientes. O valor
máximo da prestação não poderá ultrapassar 40% do salário bruto. Faça uma função que
receba o salário bruto e o valor da prestação e retorne se o emprestimo pode ou não ser
concedido.|#

#lang racket

(define (concede_emprestimo salario prestacao)
  (if (<= prestacao (* salario 0.40))
      "Empréstimo pode ser concedido"
      "Empréstimo não pode ser concedido"))

(concede_emprestimo 3000.00 1000.00) 
(concede_emprestimo 3000.00 1500.00) 
