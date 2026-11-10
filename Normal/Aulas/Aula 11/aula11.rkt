#lang racket
(require rackunit)

(define (concatena lst1 lst2)
    (cond
        [(empty? lst1) lst2]
        [else (cons (first lst1)(concatena (rest lst1) lst2))]
    )
)

(check-equal? (concatena (list 1 2 3)(list 4 5 6)) (list 1 2 3 4 5 6))
(check-equal? (concatena empty (list 7 8 9 2 4)) (list 7 8 9 2 4))
(check-equal? (concatena (list 6 3) empty) (list 6 3))
(check-equal? (concatena empty empty) empty)

(define (soma-ponderada lst pesos)
    (cond
        [(empty? lst) 0]
        [else (+ (* (first pesos)(first lst))(soma-ponderada (rest lst)(rest pesos)))]
    )
)
; Soma Ponderada = (x1 . P1) + (x2 . P2) + ... + (xn . Pn)

(check-equal? (soma-ponderada empty empty) 0)
(check-equal? (soma-ponderada (list 4) (list 2)) 8) ; (+ 0 (* 4 2))
(check-equal? (soma-ponderada (list 3 4) (list 5 2)) 23) ; (+ (* 3 5) (* 4 2))
(check-equal? (soma-ponderada (list 5 3 4) (list 1 5 2)) 28) ; (+ (* 5 1) (* 3 5) (* 4 2))

