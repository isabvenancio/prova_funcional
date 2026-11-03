#| Elabore uma função para calcular e retornar o volume de um cilindro de raio r e
altura A utilizando a fórmula: V = 3.14159. (r. r). A.|#

#lang racket

(define PI 3.14159)

(define (volume_cilindro r A)
    (* PI (* r r) A))

(volume_cilindro 2 6)