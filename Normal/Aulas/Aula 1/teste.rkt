#lang racket
(define (main)
    (define nome "João")
    (define sobrenome "Silva")
    (define idade 20)
    (displayln nome)
    (displayln sobrenome)
    (displayln idade)

    (define strappend (string-append nome " " sobrenome))
    (displayln strappend)

    (define soma (+ 10 8))
    (displayln soma)

    (define maior (if (> idade 18) "Maior de idade" "Menor de idade"))
    (displayln maior)

    (if (>= idade 18)
        (displayln "Maior de idade")
        (displayln "Menor de idade"))

    (define maior? (> 10 5))
    (displayln maior?)

    (define nota 8)
    (displayln (cond
        [(>= nota 9) "A"]
        [(>= nota 7) "B"]
        [(>= nota 5) "C"]
        [else "D"])
    )

    ;não existe mudança de estado, x vai continuar x até o final

    (define (saudacao)
        "Olá!")

    (saudacao)

)
(main)


(define x 20)
(define quadrado 
    (* x x)
)
quadrado

