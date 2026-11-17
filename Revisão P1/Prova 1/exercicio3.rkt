#lang racket
(require rackunit)

;; ListaDeString -> ListaDeNumero
;; Devolve uma lista com a quantidade de caracteres de cada string,
;; na mesma ordem da lista original.
(define (tamanhos lista)
  (cond
    [(empty? lista) empty]
    [else (cons (string-length (first lista))(tamanhos (rest lista)))]))

(check-equal? (tamanhos empty) empty)
(check-equal? (tamanhos (list "abc")) (list 3))
(check-equal? (tamanhos (list "racket" "oi" "")) (list 6 2 0))

;; ListaDeString -> Number
;; Variação: total de caracteres somando todas as strings da lista.
;; (use esta se o enunciado pedir um único número)
(define (total-caracteres lista)
  (cond
    [(empty? lista) 0]
    [else (+ (string-length (first lista))
             (total-caracteres (rest lista)))]))

(check-equal? (total-caracteres empty) 0)
(check-equal? (total-caracteres (list "racket" "oi" "")) 8)
(check-equal? (total-caracteres (list "abc")) 3)