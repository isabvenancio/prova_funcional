#lang racket
(require rackunit)

(define (maiores-strings lst)
  (define tamanhos (map string-length lst))
  (define max-tam (foldr max (first tamanhos) (rest tamanhos)))
  (define (e-maximo? x)
    (= (string-length x) max-tam))
  (filter e-maximo? lst))
  ;(filter (λ (x) (= (string-length x) max-tam)) lst))

(check-equal? (maiores-strings (list "oi" "casa" "aba" "boi" "eita" "a" "cadê"))
              (list "casa" "eita" "cadê"))