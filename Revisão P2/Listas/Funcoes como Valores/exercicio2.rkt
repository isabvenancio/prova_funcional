#lang racket
(require rackunit)

;; (reduz-num f base n) devolve (f n (f (n-1) ... (f 1 base))).
(define (reduz-num f base n)
    (cond
        [(zero? n) base]
        [else (f n (reduz-num f base (sub1 n)))]))

;; Devolve n! (as novas funções ficaram mais simples: uma linha cada).
(define (fatorial n) (reduz-num * 1 n))

;; Devolve a soma dos naturais de 1 até n.
(define (soma-ate n) (reduz-num + 0 n))

;; Devolve a lista (n n-1 ... 1).
(define (decrescente n) (reduz-num cons empty n))

(check-equal? (reduz-num * 1 3) 6)
; = (* 3 (reduz-num * 1 2))
; = (* 3 (* 2 (reduz-num * 1 1)))
; = (* 3 (* 2 (* 1 (reduz-num * 1 0))))
; = (* 3 (* 2 (* 1 1)))      ; caso base: devolve base = 1
; = 6
(check-equal? (reduz-num + 0 0) 0)
(check-equal? (reduz-num + 0 5) 15)
(check-equal? (reduz-num * 1 4) 24)
(check-equal? (soma-ate 4) 10)
(check-equal? (decrescente 3) (list 3 2 1))
(check-equal? (decrescente 0) empty)