#lang racket
(require rackunit)

(define (prefixo? lst1 lst2)
    (cond
        [(empty? lst1) #t]
        [(empty? lst2) #f]
        [else ; (and (cons? lst1) (cons? lst2))
        (and (= (first lst1) (first lst2))(prefixo? (rest lst1) (rest lst2)))]))

(check-equal? (prefixo? empty empty) #t)
(check-equal? (prefixo? empty (list 3 2 1)) #t)
(check-equal? (prefixo? (list 3 2 1) empty) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
(check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f)

;Essa função verifica se a primeira lista (lst1) é o início (um prefixo) da segunda lista (lst2). 
;Em outras palavras, ela responde se lst2 começa exatamente com os mesmos elementos e na mesma ordem que lst1.
(define (primeira-inicio-segunda lista1 lista2)
    (cond
        [(empty? lista1) #t]
        [(empty? lista2) #f];;pq a primeira n esta vazia
        [else (and (= (first lista1)(first lista2))(primeira-inicio-segunda (rest lista1)(rest lista2)))]))
        
(check-equal? (primeira-inicio-segunda empty empty) #t)
(check-equal? (primeira-inicio-segunda empty (list 3 2 1)) #t)
(check-equal? (primeira-inicio-segunda (list 3 2 1) empty) #f)
(check-equal? (primeira-inicio-segunda (list 3 4) (list 3 4)) #t)
(check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
(check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)