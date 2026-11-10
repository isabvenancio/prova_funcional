#lang racket
(require examples)

;preco é um real positivo
;combustivel é uma das duas strings:
; - "alcool"
; - "gasolina"
;preco preco -> combustivel
;encontra o combustível que deve ser utilizado no abastecimento
;caso o preco-alcool for menor ou igual a 70% do preco-gasolina, será selecionado "alcool", caso contrario gasolina
;exemplos:
;preco-alcool = 3.00 e preco-gasolina = 4.00 -> "gasolina"
;preco-alcool = 2.90 e preco-gasolina = 4.20 -> "alcool"

(define (seleciona-combustivel preco-alcool preco-gasolina)
    (if (> preco-alcool (* preco-gasolina 0.7))
        "gasolina"
        "alcool"
        ))

(seleciona-combustivel 3.00 4.00)

(exemples
    (check-equal? (seleciona-combustivel 3.00 4.00) "gasolina")
    )