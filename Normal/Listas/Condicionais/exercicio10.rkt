#|Faça uma função que receba a idade de um nadador e o classifique em uma das
seguintes categorias:

Idade Categoria
5 ate 7 anos Infantil A
8 ate 10 anos Infantil B
11 ate 13 anos Juvenil A
14 ate 17 anos Juvenil B
Maiores de 18 anos Adulto|#

#lang racket

(define (idade_nadador idade)
    (cond
        [(and (>= idade 5)(<= idade 7)) "Infantil A"]
        [(and (>= idade 8)(<= idade 10)) "Infantil B"]
        [(and (>= idade 11)(<= idade 13)) "Juvenil A"]
        [(and (>= idade 14)(<= idade 17)) "Juvenil B"]
        [(>= idade 18) "Adulto"]
        [else "Menor que 5 anos"]
        ))

(idade_nadador 18)
(idade_nadador 9)
(idade_nadador 2)
(idade_nadador 7)
(idade_nadador 12)
(idade_nadador 30)
