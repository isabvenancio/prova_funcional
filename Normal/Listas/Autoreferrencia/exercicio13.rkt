#lang racket
(require rackunit)

#|Uma pilha é uma estrutura de dados que realiza suas operações de inserção e
remoção na mesma extremidade, ou seja, o primeiro a entrar é o ultimo a sair
(FILO). Considerando a seguinte struct para a implementação de uma pilha:
(struct pilha (dados)#:transparent)
;; pilha representa uma pilha de valores
;; dados: list - lista que armazena os itens da pilha
Implemente as funções:

a. Para empilhar um elemento, que receba uma pilha P e um valor x e
retorne P’, que é P com x empilhado.
b. Para desempilhar um elemento, que receba uma pilha P e retorne a pilha
P’, que é P após remover o elemento do seu topo.
c. Pare obter o topo da pilha. Caso a pilha esteja vazia, utilize a função error,
com uma mensagem de erro. Exemplo: (error “pilha vazia”)
Dica: implemente funções para remover e inserir um elemento no inicio da lista.|#

(struct pilha (dados) #:transparent)

;insere inicio
(define (insere-inicio lst x)
    (cons x lst)) ;;const recebe o primeiro e o resto

;remove inicio
(define (remove-inicio lst )
    (cond
        [(empty? lst) (error "pilha vazia")]
        [else (rest lst)])) ;; manda o resto da lista


;a. empilhar 
(define (empilhar p x)
    (pilha (insere-inicio (pilha-dados p) x))) ;uma pilha com novos dados atualizado
    ;; p é o resto da lista e o pilha-dados é o novo elemento a ser empilhado

;b. desempilhar
(define (desempilhar p)
    (pilha (remove-inicio (pilha-dados p))))

;c. obter topo da pilha
(define (topo p)
    (cond
        [(empty? (pilha-dados p)) (error "pilha vazia")]
        [else (first (pilha-dados p))]))

(check-equal? (empilhar (pilha '()) 10)(pilha '(10)))
(check-equal? (empilhar (pilha '(10 20)) 5)(pilha '(5 10 20)))

(check-equal? (desempilhar (pilha '(10 20 30)))(pilha '(20 30)))
(check-equal? (desempilhar (pilha '(5)))(pilha '()))

(check-equal? (topo (pilha '(10 20 30))) 10)
(check-equal? (topo (pilha '(5))) 5)