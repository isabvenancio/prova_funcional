#lang racket
(require rackunit)

(define (natal preco-original preco-concorrente desconto)
    (if (> (* preco-original (- 1 (/ desconto 100))) preco-concorrente)
        preco-concorrente
        (* preco-original (- 1 (/ desconto 100)))))


(check-equal? (natal 100 90 20) 80) ;; o preço com desconto (80) é menor que o da concorrente (90), então retorna 80
(check-equal? (natal 100 75 20) 75) ;; o preço com desconto (80) é maior que o da concorrente (75), então retorna 75
(check-equal? (natal 100 80 20) 80) ;; o preço com desconto (80) é igual ao da concorrente (80), então retorna 80
(check-equal? (natal 250 200 10) 200) ;; o preço com desconto (225) é maior que o da concorrente (200), então retorna 200
(check-equal? (natal 150 100 50) 75) ;; o preço com desconto (75) é menor que o da concorrente (100), então retorna 75

; (* preco-original (/ desconto 100)) → calcula quanto será descontado.
; (* preco-original (- 1 (/ desconto 100))) → calcula quanto será pago.