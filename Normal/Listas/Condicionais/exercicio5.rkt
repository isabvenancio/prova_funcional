#|Faça uma função que receba uma temperatura em graus celsios e uma string. Se a string
informada for ‘Kelvin’ seu algoritmo deverá converter a temperatura para Kelvin. Se a
string for ‘Fahrenheit’ a temperatura deverá ser convertida para Fahrenheit.

K = C + 273,15 
F = (9c+160) / 5|#

#lang racket

(define (converter_temperatura celsios string)
    (cond
        [(string=? string "Kelvin") (+ celsios 273.15)]
        [(string=? string "Fahrenheit") (/ (+ (* 9 celsios) 160) 5)]
        [else "Digite novamente: Kelvin ou Fahrenheit"]
    ))

(converter_temperatura 20 "Kelvin")
(converter_temperatura 30 "isa")