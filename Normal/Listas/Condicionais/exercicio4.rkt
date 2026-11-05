#|Faça um função para receber a idade de uma pessoa e informar:
-Se ela é maior de idade;
-Se ela é menor de idade;
-Se ela tem mais de 65 anos;|#

#lang racket

(define (comparar_idade idade)
    (cond
        [(> idade 65) "idoso"]
        [(> idade 18) "maior de idade"]
        [else "menor de idade"]
    ))

(comparar_idade 70)
(comparar_idade 20)
(comparar_idade 3)