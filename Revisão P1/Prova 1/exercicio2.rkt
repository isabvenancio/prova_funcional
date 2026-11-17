#lang racket
(require rackunit)

;; Number Number Number -> String
;; Um triângulo é válido se todos os ângulos são positivos
;; e a soma dos três é exatamente 180 graus.
;; Recebe os três ângulos (em graus) e devolve:
;; "inválido", "retângulo", "obtusângulo" ou "acutângulo".
(define (tipo-triangulo a b c)
    (cond
        [(not (and (> a 0)(> b 0)(> c 0)(= (+ a b c) 180))) "invalido"]
        [(or (= a 90)(= b 90)(= c 90)) "retangulo"]
        [(or (> a 90)(> b 90)(> c 90)) "obtusangulo"]
        [else "acutangulo"]))

(check-equal? (tipo-triangulo 90 45 45) "retangulo")
(check-equal? (tipo-triangulo 30 90 60) "retangulo")
(check-equal? (tipo-triangulo 120 30 30) "obtusangulo")
(check-equal? (tipo-triangulo 20 20 140) "obtusangulo")
(check-equal? (tipo-triangulo 60 60 60) "acutangulo")
(check-equal? (tipo-triangulo 70 60 50) "acutangulo")
(check-equal? (tipo-triangulo 100 100 100) "invalido")
(check-equal? (tipo-triangulo 90 90 0) "invalido")

; ;; Number Number Number -> Boolean
; ;; Um triângulo é válido se todos os ângulos são positivos
; ;; e a soma dos três é exatamente 180 graus.
; (define (triangulo-valido? a b c)
;   (and (> a 0)
;        (> b 0)
;        (> c 0)
;        (= (+ a b c) 180)))

; ;; Number Number Number -> String
; ;; Recebe os três ângulos (em graus) e devolve:
; ;; "inválido", "retângulo", "obtusângulo" ou "acutângulo".
; (define (classifica-triangulo a b c)
;   (cond
;     [(not (triangulo-valido? a b c)) "inválido"]
;     [(or (= a 90) (= b 90) (= c 90)) "retângulo"]
;     [(or (> a 90) (> b 90) (> c 90)) "obtusângulo"]
;     [else "acutângulo"]))

; (check-equal? (triangulo-valido? 60 60 60) #t)
; (check-equal? (triangulo-valido? 100 100 100) #f)
; (check-equal? (triangulo-valido? 90 90 0) #f)
; (check-equal? (triangulo-valido? -10 100 90) #f)

; (check-equal? (classifica-triangulo 90 45 45) "retângulo")
; (check-equal? (classifica-triangulo 30 90 60) "retângulo")
; (check-equal? (classifica-triangulo 120 30 30) "obtusângulo")
; (check-equal? (classifica-triangulo 20 20 140) "obtusângulo")
; (check-equal? (classifica-triangulo 60 60 60) "acutângulo")
; (check-equal? (classifica-triangulo 70 60 50) "acutângulo")
; (check-equal? (classifica-triangulo 100 100 100) "inválido")
; (check-equal? (classifica-triangulo 90 90 0) "inválido")
