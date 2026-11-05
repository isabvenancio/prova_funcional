#lang racket
(require rackunit)

(define (verificar-idade idade)
    (cond
        [(>= idade 65) "idoso"]
        [(>= idade 18) "adulto"]
        [else "jovem"]))


(check-equal? (verificar-idade 18) "adulto")
(check-equal? (verificar-idade 30) "adulto")
(check-equal? (verificar-idade 65) "idoso")
(check-equal? (verificar-idade 80) "idoso")
(check-equal? (verificar-idade 13) "jovem")