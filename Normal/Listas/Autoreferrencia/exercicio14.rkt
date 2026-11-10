#lang racket
(require rackunit)

#|Uma fila é uma estrutura de dados que realiza operações de inserção em uma
extremidade e remoções na outra, ou seja, o primeiro a entrar é o primeiro a sair
(FIFO). Considerando a seguinte struct para a implementação de uma fila:
(struct fila (dados)#:transparent)
;; fila representa uma fila de valores
;; dados: list - lista que armazena os itens da fila
Implemente as funções:
a. Para enfileirar um elemento, que receba uma fila F e um valor x que será
enfileirado, e retorne a fila F’, que é a fila F com x enfileirado.
b. Para desenfileirar um elemento, que receba uma fila F e retorne a fila F’,
que é F após remover seu primeiro elemento.
c. Para obter o primeiro da fila. Caso a fila esteja vazia, utilize a função
error.Exemplo: (error “fila vazia”)
Dica: implemente funções para remover um elemento no inicio da lista e inserir um
elemento no final da lista|#

(struct fila (dados) #:transparent)

;remove-inicio
(define (remove-inicio lst)
    (cond
        [(empty? lst) (error "fila vazia")]
        [else (rest lst)]))

;insere-final
(define (insere-final lst x)
    (cond
        [(empty? lst) (list x)]
        [else (cons (first lst)(insere-final (rest lst) x))] ;;recebe o primeiro e o restante da lista
))

;a.enfileirar
(define (enfileirar f x)
    (fila (insere-final (fila-dados f) x)))

;b.desenfileirar
(define (desenfileirar f)
    (fila (remove-inicio (fila-dados f))))

;c.obter o primeiro elemento da fila
(define (primeiro f)
    (cond
        [(empty? (fila-dados f)) (error "fila vazia")]
        [else (first (fila-dados f))]
    ))



(check-equal? (enfileirar (fila '()) 10) (fila '(10)))
(check-equal? (enfileirar (fila '(10 20)) 30) (fila '(10 20 30)))

(check-equal? (desenfileirar (fila '(10 20 30))) (fila '(20 30)))
(check-equal? (desenfileirar (fila '(10))) (fila '()))

(check-equal? (primeiro (fila '(10 20 30))) 10)
(check-equal? (primeiro (fila '(5))) 5)

