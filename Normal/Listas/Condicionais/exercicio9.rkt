#|Faça uma função que receba 3 medidas e verifique se essas medidas podem formar um
triangulo. Caso possam formar, verifique qual o tipo de triangulo (equilátero, isóceles
ou escaleno).
-Só é possível formar triangulo quando a soma de dois lados é menor que a do lado
restante
-Um triângulo é equilatero se ele tem todos lados iguais
-Um triângulo é isóceles se tem dois lados iguais
-Um triângulo é escaleno quando todos seus lados são diferentes|#

#lang racket

(define (triangulo num1 num2 num3)
    (cond
        [(or (<= (+ num1 num2) num3)
            (<= (+ num1 num3) num2)
            (<= (+ num2 num3) num1)) "Não é um triângulo válido"])
    (cond
        [(= num1 num2 num3) "equilatero"]
        [(or (= num1 num2)(= num2 num3)(= num1 num3)) "isoceles"]
        [else "escaleno"]
    ))

(triangulo 3 3 3)
(triangulo 1 2 3)
(triangulo 9 0 9)