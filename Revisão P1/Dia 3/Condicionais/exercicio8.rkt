#lang racket
(require rackunit)

(define (chevrolet salario-bruto prestacao)
    (if (<= prestacao (* salario-bruto 0.4))
        "pode ser concedido"
        "não pode ser concedido"))

(check-equal? (chevrolet 3000.00 1000.00) "pode ser concedido")
(check-equal? (chevrolet 3000.00 1500.00) "não pode ser concedido")