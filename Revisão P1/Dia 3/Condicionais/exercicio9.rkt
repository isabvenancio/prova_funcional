#lang racket
(require rackunit)

(define (tipo-triangulo a b c)
    (if (and (> (+ a b) c)(> (+ a c) b)(> (+ b c) a))
        (cond
            [(= a b c) "equilátero"]
            [(or (= a b) (= b c) (= a c)) "isósceles"]
            [else "escaleno"])
        "não podem formar"))

(check-equal? (tipo-triangulo 3 3 3) "equilátero")
(check-equal? (tipo-triangulo 4 4 5) "isósceles")
(check-equal? (tipo-triangulo 3 4 5) "escaleno")
(check-equal? (tipo-triangulo 3 0 9) "não podem formar")


;;ou

(define (triangulo-tipo num1 num2 num3)
    (cond
        [(or (<= (+ num1 num2) num3)
            (<= (+ num1 num3) num2)
            (<= (+ num2 num3) num1)) 
        "Não é um triângulo válido"]
        [(= num1 num2 num3) "equilatero"]
        [(or (= num1 num2)(= num2 num3)(= num1 num3)) "isoceles"]
        [else "escaleno"]
    ))

(check-equal? (triangulo-tipo 3 3 3) "equilatero")
(check-equal? (triangulo-tipo 4 4 5) "isoceles")
(check-equal? (triangulo-tipo 3 4 5) "escaleno")
(check-equal? (triangulo-tipo 3 0 9) "Não é um triângulo válido")