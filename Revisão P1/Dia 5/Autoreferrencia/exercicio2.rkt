#lang racket
(require rackunit)

(define (juntar lstL strS)
    (cond
        [(empty? lstL) ""]
        [(empty? (rest lstL)) (first lstL)];;se o resto da lista for vazia, retorna o primeiro elemento
        [else (string-append (first lstL) strS (juntar (rest lstL) strS))]))

(check-equal? (juntar (list "ola" "tudo bem?") ", ") "ola, tudo bem?")
(check-equal? (juntar (list "ola" "mundo!") " ") "ola mundo!")
(check-equal? (juntar (list "ra" "nome" "nota") ",") "ra,nome,nota")
(check-equal? (juntar (list "string unica") "!") "string unica")
(check-equal? (juntar (list "a" "b" "c" "d" "e" "f" "g") " ") "a b c d e f g")
(check-equal? (juntar (list "inteiro" "real") "->") "inteiro->real")