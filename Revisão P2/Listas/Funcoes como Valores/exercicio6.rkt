#lang racket
(require rackunit)

(let ([f (lambda (x) x)])
    (f 4))

(let ([f (lambda x x)])
    (f 4))
; (lambda (x) x), com parênteses, recebe exatamente um argumento e o devolve.
; (lambda x x), sem parênteses, recebe qualquer quantidade de argumentos e junta todos em uma lista chamada x.

(let ([f (lambda (x . y) x)])
    (f 4 5 6))
; O . separa os parâmetros obrigatórios dos opcionais. Tudo o que vem depois dele é um único nome, e esse nome recebe todos os argumentos que sobrarem, juntos em uma lista.

(let ([f (lambda (x . y) y)])
    (f 4 5 6))

(check-equal? (let ([f (λ (x) x)]) (f 4)) 4) ;; a função devolve o proprio valor de x = 4
(check-equal? (let ([f (λ x x)]) (f 4)) '(4)) ;; a função devolve a lista de argumentos q tem o valor de x = 4
(check-equal? (let ([f (λ (x . y) x)]) (f 4 5 6)) 4) ;; a função devolve o valor de x antes q é 4
(check-equal? (let ([f (λ (x . y) y)]) (f 4 5 6)) '(5 6)) ;; a função devolve a lista de argumentos q tem o valor de y = '(5 6), pode ser apenas um numero ou uma lista de numeros, dependendo do que for passado como argumento
(check-equal? (let ([f (λ (x . y) y)]) (f 4 5)) '(5)) ;; a função devolve a lista de argumentos q tem o valor de y = '(5), pq foi passado um argumento depois do x

; O let cria nomes locais, que só existem dentro dele. Serve para dar nome a um valor, em vez de repetir a expressão.
; (let ([nome1 valor1]
;       [nome2 valor2])
;   corpo)
(let ([x 3]
        [y 4])
    (+ x y))        ; => 7

; Para que serve: evitar repetir um cálculo e dar nome ao que é importante:
(let ([quadrado (* 5 5)])
    (+ quadrado quadrado))   ; => 50, e o (* 5 5) foi calculado uma vez só

; Relação com λ: o let é só uma forma mais legível de aplicar uma função anônima. Estes dois são equivalentes:
(let ([x 3]) (+ x 1))
((lambda (x) (+ x 1)) 3)