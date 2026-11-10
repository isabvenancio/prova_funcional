#lang racket
(require rackunit)

#|Faça uma função que receba uma lista de strings L e uma string separadora S.
Sua função deverá juntar todas as strings de L separadas pela string S.
Obs: a ultima strings não deve ser seguida pelo separadora.
Exemplos:
> (junta (list "ola" "tudo bem?") ", ")
"ola, tudo bem?"
> (junta (list "ola" "mundo!") " ")
"ola mundo!"
> (junta (list "ra" "nome" "nota") ",")
"ra,nome,nota"
> (junta (list "string unica") "!")
"string única"
> (junta (list "a" "b" "c" "d" "e" "f" "g") " ")
"a b c d e f g"
> (junta (list "inteiro" "real") "->")
"inteiro->real"|#

(define (junta lst s)
    (cond
        [(empty? lst) ""] ; lista vazia: string vazia
        [(empty? (rest lst)) (first lst)] ; caso base: última string, não coloca o separador depois dela
        [else (string-append (first lst) s (junta (rest lst) s))] ; caso recursivo: primeira string + separador + junta do resto
    )
)

(check-equal? (junta (list "ola" "tudo bem?") ", ") "ola, tudo bem?")
(check-equal? (junta (list "ola" "mundo!") " ") "ola mundo!")
(check-equal? (junta (list "ra" "nome" "nota") ",") "ra,nome,nota")
(check-equal? (junta (list "string unica") "!") "string unica")
(check-equal? (junta (list "a" "b" "c" "d" "e" "f" "g") " ") "a b c d e f g")
(check-equal? (junta (list "inteiro" "real") "->") "inteiro->real")
