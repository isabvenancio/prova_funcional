#lang racket
(require rackunit)

(define (categoria-natacao idade)
    (cond
        [(and (>= idade 5)(<= idade 7)) "Infantil A"]
        [(and (>= idade 8)(<= idade 10)) "Infantil B"]
        [(and (>= idade 11)(<= idade 13)) "Juvenil A"]
        [(and (>= idade 14)(<= idade 17)) "Juvenil B"]
        [(>= idade 18) "Adulto"]
        [else "Menor que 5 anos"]
        ))

(check-equal? (categoria-natacao 18) "Adulto")
(check-equal? (categoria-natacao 10) "Infantil B")
(check-equal? (categoria-natacao 3) "Menor que 5 anos")
(check-equal? (categoria-natacao 11) "Juvenil A")
(check-equal? (categoria-natacao 16) "Juvenil B")
(check-equal? (categoria-natacao 6) "Infantil A")
(check-equal? (categoria-natacao -4) "Menor que 5 anos")