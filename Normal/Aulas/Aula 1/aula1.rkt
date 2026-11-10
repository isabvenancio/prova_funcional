#lang racket

#|1. O seu amigo Alan está planejando uma viagem pro final do ano com a família e está
considerando diversos destinos. Uma das coisas que ele está levando em consideração é o
custo da viagem, que inclui, entre outras coisas, hospedagem, combustível e o pedágio.
Para o cálculo do combustível ele pediu a sua ajuda, ele disse que sabe a distância que vai
percorrer, o preço do litro do combustível e o rendimento do carro (quantos quilômetros o
carro anda com um litro de combustível), mas que é muito chato ficar fazer o cálculo
manualmente, então ele quer que você faça um programa para calcular o gasto de
combustível em uma viagem.|#

;isso aq n é uma função, é só um cálculo
(define (custo distancia preco rendimento)
    (/ (* distancia rendimento) preco))

(custo 100 5 10)

#|2. Depois que você fez o programa para o Alan, a Márcia, amiga em comum de vocês, soube
que você está oferecendo serviços desse tipo e também quer a sua ajuda. O problema da
Márcia é que ela sempre tem que fazer a conta manualmente para saber se deve abastecer
o carro com álcool ou gasolina. A conta que ela faz é verificar se o preço do álcool é até
70% do preço da gasolina, se sim, ela abastece o carro com álcool, senão ela abastece o
carro com gasolina. Você pode ajudar a Márcia também?|#

(define (abastecer preco_alcool preco_gasolina)
    (if (< preco_alcool (* 0.7 preco_gasolina))
        (displayln "Abastecer com álcool") 
        (displayln "Abastecer com gasolina")))

(abastecer 3.5 5.0) ; if não é uma função, é só uma condicional, então não precisa de parênteses no final
