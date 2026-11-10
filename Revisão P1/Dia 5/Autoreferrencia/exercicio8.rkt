#lang racket
(require rackunit)

(define (soma-algarismos num)
    (cond
        [(= num 0) 0] ;;[(< n 10) n]
        [else (+ (remainder num 10)(soma-algarismos (quotient num 10)))]))
        ;;remainder pega o ultimo algarismo e quotient elemina o ultimo algarismo
        ;;pega o último dígito (resto)(n % 10) e soma com o restante (divisão inteira)(n // 10)

(check-equal? (soma-algarismos 1234) 10)
(check-equal? (soma-algarismos 92) 11)

; Chamada	remainder	quotient
; 1234	       4	       123
; 123	       3	        12
; 12	       2	         1
; 1	           1	         0
; 0	          Para	     Para

; Depois, a recursão retorna:
; (+ 4 (+ 3 (+ 2 (+ 1 0))))