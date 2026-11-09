#lang racket
(require rackunit)

; Campo de quadrados q podem ter minas escondidas
;  - abre quadrados clicando; objetivo é abrir todos os q não têm mina; abriu mina → perdeu
;  - quadrado aberto mostra quantas minas tem ao redor (máx 8); se for 0, abre todos ao redor
;  - pode colocar/remover bandeira num quadrado fechado (sinaliza possível mina e impede de abrir)
;  - projetar um tipo pra representar um quadrado (não precisa guardar o nº de bombas ao redor, dá pra calcular)

; 1ª tentativa: 3 itens relacionados → estrutura, cada um com 2 estados → booleano

;;(struct quadrado (mina? aberto? bandeira?) #:transparent)
;;   mina?     : Bool - #t se tem uma mina no quadrado
;;   aberto?   : Bool - #t se o quadrado está aberto
;;   bandeira? : Bool - #t se tem uma bandeira no quadrado

; Segue as diretrizes? 3 campos × 2 valores = 2 × 2 × 2 = 8 instâncias possíveis

; | mina? | aberto? | bandeira? | válido? |
; |---|---|---|---|
; | #f | #f | #f | sim |
; | #f | #f | #t | sim |
; | #f | #t | #f | sim |
; | #f | #t | #t | NÃO |
; | #t | #f | #f | sim |
; | #t | #f | #t | sim |
; | #t | #t | #f | sim |
; | #t | #t | #t | NÃO |

;  - 2 estados inválidos! (aberto com bandeira não existe)
;  - só 3 das 4 combinações de aberto?/bandeira? são válidas: aberto, fechado, fechado com bandeira
;  - solução: juntar aberto? e bandeira? num campo estado com esses 3 valores

;; Estado é um dos valores
;; - "aberto"
;; - "fechado"
;; - "com-bandeira"

(struct quadrado (mina? estado) #:transparent)
;; Representa um quadrado no jogo campo minado
;;   mina? : Bool - #t se tem uma mina no quadrado, #f caso contrário
;;   estado: Estado - o estado do quadrado

;  - agora 2 × 3 = 6 instâncias, exatamente os 6 estados válidos

; Função q determina como o quadrado fica depois de uma ação do usuário (abrir, adicionar bandeira, remover bandeira)

;; Acao é um dos valores
;; - "abrir"
;; - "adicionar-bandeira"
;; - "remover-bandeira"

; Especificação
;  - entradas: um quadrado e uma ação; saída: um quadrado
;  - só o estado pode mudar, e depende do estado atual E da ação
;  - depende de 2 valores enumerados → pelo menos 3 × 3 = 9 exemplos (faz uma tabela pra não esquecer nenhum)

; | estado / ação | abrir | adicionar | remover |
; |---|---|---|---|
; | aberto | - | - | - |
; | fechado | aberto | com-bandeira | - |
; | com-bandeira | - | - | fechado |

; ("-" = não muda nada)


; Implementação
;  - 1 valor enumerado → seleção com uma condição pra cada valor
;  - 2 valores enumerados → seleção de 2 níveis (um cond dentro do outro) OU uma seleção com uma condição pra cada par
;  - olhando a tabela, só 3 casos mudam o quadrado → não precisa escrever os 9 casos, dá pra simplificar antes de escrever!

(define (atualiza-quadrado q acao) 
    (define estado (quadrado-estado q)) ;;estado atual do quadrado
        (cond ;;combinações possíveis
            [(and (equal? estado "fechado") (equal? acao "abrir")) ;;se o quadrado esta fechado e vamos abrir
                (struct-copy quadrado q [estado "aberto"])] ;;cria uma copia do quadrado alterando o estado para aberto

            [(and (equal? estado "fechado") (equal? acao "adicionar-bandeira")) ;;se o quadrado esta fechado e vamos adicionar uma bandeira
                (struct-copy quadrado q [estado "com-bandeira"])];; cria uma copia do quadrado alterando o estado para com bandeira

            [(and (equal? estado "com-bandeira") (equal? acao "remover-bandeira")) ;;se o quadrado esta com bandeira e vamos remover a bandeira
                (struct-copy quadrado q [estado "fechado"])] ;;cria uma copia do estado alterando para fechado

            [else q])) ;senao, retorna o proprio quadrado


(check-equal? (atualiza-quadrado (quadrado #f "aberto") "abrir") (quadrado #f "aberto"))
; (struct-copy quadrado q [estado "aberto"])
;;o quadrado esta aberto e não tem uma mina, e ele está tendando abrir, logo ele cai no else e retorna o proprio quadrado (ele ta tentando abrir um quadrado ja aberto)

(check-equal? (atualiza-quadrado (quadrado #f "fechado") "abrir") (quadrado #f "aberto"))
;; o quadrado esta fechado e não tem uma mina, ele esta tentando abrir, logo ele cai na 1 condição, retorna uma copia do quadrado aberto

(check-equal? (atualiza-quadrado (quadrado #f "fechado") "adicionar-bandeira") (quadrado #f "com-bandeira"))
;; o quadrado esta fechado e não tem uma mina, ele esta tendando adicionar uma bandeira, logo ele cai na 2 condicao, retorna uma copia do quadrado com bandeira

(check-equal? (atualiza-quadrado (quadrado #f "com-bandeira") "remover-bandeira") (quadrado #f "fechado"))
;; o quadrado esta com bandeira e não tem uma mina, ele esta tentando remover uma bandeira, logo ele cai na 3 condicao, retorna uma copia do quadrado fechado

(check-equal? (atualiza-quadrado (quadrado #f "com-bandeira") "abrir") (quadrado #f "com-bandeira"))
;; o quadrado esta com bandeira e não tem uma mina, ele esta tentando abrir, logo ele cai no else e retorna o proprio quadrado (primeiro precisa remover a bandeira)

(check-equal? (atualiza-quadrado (quadrado #f "aberto") "adicionar-bandeira") (quadrado #f "aberto"))
;; o quadrado esta aberto e não tem uma mina, ele esta tentando adicionar bandeira, logo ele cai no else e retorna o proprio quadrado (ta tentando adicionar bandeira em quadrado ja aberto)

(check-equal? (atualiza-quadrado (quadrado #f "aberto") "remover-bandeira") (quadrado #f "aberto"))
;; o quadrado esta aberto e não tem uma mina, ele esta tentando remover bandeira, logo ele cai no else e retorna o proprio quadrado (ta tentando remover bandeira em quadrado q não tem bandeira e já esta aberto)

(check-equal? (atualiza-quadrado (quadrado #f "fechado") "remover-bandeira") (quadrado #f "fechado"))
;; o quadrado esta fechado e não tem uma mina, ele esta tentando remover bandeira, logo ele cai no else e retorna o proprio quadrado (ta tentando remover bandeira aonde não adicionaram ainda)

(check-equal? (atualiza-quadrado (quadrado #t "aberto") "abrir") (quadrado #t "aberto"))
;; o quadrado tem uma mina e já está aberto.
;; O usuário tenta abrir novamente, cai no else e retorna o próprio quadrado.

(check-equal? (atualiza-quadrado (quadrado #t "fechado") "abrir") (quadrado #t "aberto"))
;; o quadrado tem uma mina e está fechado.
;; O usuário tenta abrir, cai na 1ª condição e retorna uma cópia do quadrado aberto.