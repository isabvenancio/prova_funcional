## Fundamentos

### Introdução
O paradigma funcional é baseado na definição e aplicação de funções
 - cada função é um conjunto de expressões q mapeia valores de entrada para valores de saída
 - expressão: entidade sintática q quando avaliada produz um valor
 - a ideia é ir construindo a definição de expressão e a regra de avaliação aos poucos (versão 0.1, 0.2, 0.3, 1.0)


### Expressão (versão 0.1)
Uma expressão é
 - um literal; ou
 - uma função primitiva

Literais de tipos primitivos
 - números exatos: inteiros (1345), racionais (1/3), complexos com parte real e imaginária exatas
 - números inexatos: ponto flutuante (2.65), complexos com parte real ou imaginária inexata
 - booleano: #t (verdadeiro) e #f (falso)
 - strings: "Seu nome"
 - e muitos outros tipos

Funções primitivas
 - aritméticas: +, -, *, /
 - relacionais: >, >=, <, <=, =
 - strings: string-length, string-append, number->string, string->number
 - muitas outras

Avaliação
 - literal → valor q o literal representa
 - função primitiva → sequência de instruções de máquina associada com a função
 - a expressão é definida por 2 casos, então a regra de avaliação tb tem 2 casos

```racket
> #t
#t
> 231
231
> "Banana"
"Banana"
> +
#<procedure:+>
```

o q falta? uma forma de combinar expressões para formar novas expressões


### Combinações
Uma combinação é uma lista não vazia de expressões entre parênteses
 - a expressão mais à esquerda é o operador
 - as outras são os operandos
 - valor: resultado da aplicação do valor (função) do operador aos valores dos operandos

```racket
> (+ 12 56)
68
> (> 4 5)
#f
> (string-append "Apenas " "um " "teste")
"Apenas um teste"
```

Notação prefixa e expressões S
 - notação prefixa: operador fica à esquerda dos operandos
 - no Racket isso é feito com expressões S (s-exp), q representam listas aninhadas (árvores)

Vantagens das s-exps
 - operadores aritméticos são tratados como qualquer função e aceitam número variado de argumentos → (* 2 8 10 1) = 160
 - combinações aninham fácil, sem se preocupar com prioridade das operações → (+ (* 3 5) (- 10 6) 5) = 24
 - um programa inteiro pode ser uma sequência de s-exp, então fica mais fácil fazer programas q processam outros programas (Racket é homoicônica)

Desvantagens
 - é diferente da forma q a gente aprendeu
 - pode precisar de mais parênteses


### Expressão (versão 0.2)
Uma expressão é
 - um literal; ou
 - uma função primitiva; ou
 - uma combinação

Avaliação
 - literal → valor q o literal representa
 - função primitiva → instruções de máquina da função
 - combinação → avalia cada expressão da combinação (reduz cada uma pra um valor) → resultado da aplicação da função aos argumentos

Observações importantes
 - 3 casos na definição, 3 casos na regra de avaliação
 - autorreferência: a combinação contém outras expressões, ou seja, a definição refere-se a si mesma → permite criar expressões de tamanho arbitrário
 - recursão: avaliar uma combinação chama o processo de avaliação para as suas expressões, ou seja, o processo é definido em termos de si mesmo → permite avaliar expressões de tamanho arbitrário
 - autorreferência na definição geralmente implica em recursão no processamento
 - esses conceitos explicam como o Racket funciona e tb são fundamentais pra criar programas no paradigma funcional

Exemplo de avaliação passo a passo (sempre reduz a expressão mais interna da esquerda)
```racket
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6)) ; (* 2 4) -> 8
(+ (* 3 (+ 8 (+ 3 5))) (+ (- 10 7) 6))      ; (+ 3 5) -> 8
(+ (* 3 (+ 8 8)) (+ (- 10 7) 6))            ; (+ 8 8) -> 16
(+ (* 3 16) (+ (- 10 7) 6))                 ; (* 3 16) -> 48
(+ 48 (+ (- 10 7) 6))                       ; (- 10 7) -> 3
(+ 48 (+ 3 6))                              ; (+ 3 6) -> 9
(+ 48 9)                                    ; (+ 48 9) -> 57
57
```


### Definições
Servem para dar nome a objetos computacionais (dados ou funções)
 - é a forma de abstração mais elementar
 - em Racket é feito com o define

```racket
(define x 10)
(define y (+ x 24))
> y
34
```

(define <nome> <exp>) → associa <nome> ao valor da avaliação de <exp>
 - ambiente: memória q guarda as associações entre nomes e objetos
 - definição NÃO é combinação (expressão), então não segue a regra de avaliação de expressões
 - (define x 10) não é aplicar a função define a 2 argumentos, é só associar o valor 10 ao nome x

Programa em Racket = sequência de definições e expressões


### Definição de função
Sintaxe: (define (<nome> <parametro>...) <exp>)

```racket
(define (quadrado x)
  (* x x))

(define (soma-quadrados a b)
  (+ (quadrado a) (quadrado b)))

> (quadrado (+ 2 6))
64
> (soma-quadrados (+ 2 2) 3)
25
```

 - funções compostas (definidas pelo usuário) são usadas igual às primitivas
 - agora nomes podem aparecer em expressões → precisa atualizar a definição de expressão


### Modelo de substituição
Expressão (versão 0.3)
 - literal; ou
 - função primitiva; ou
 - nome; ou
 - combinação

Avaliação
 - literal → valor q ele representa
 - função primitiva → instruções de máquina da função
 - nome → valor associado ao nome no ambiente
 - combinação
   - avalia cada expressão da combinação
   - se o operador é uma função composta, avalia o corpo dela substituindo cada parâmetro formal pelo argumento correspondente
   - senão, aplica a função primitiva aos argumentos

Esse jeito de calcular a aplicação de funções compostas é o modelo de substituição (dá pra ver no Stepper do DrRacket, botão "Step")

```racket
(define (f a) (soma-quadrados (+ a 1) (* a 2)))

(f 5)                            ; substitui (f 5) pelo corpo de f com a = 5
(soma-quadrados (+ 5 1) (* 5 2)) ; reduz (+ 5 1) -> 6
(soma-quadrados 6 (* 5 2))       ; reduz (* 5 2) -> 10
(soma-quadrados 6 10)            ; substitui pelo corpo
(+ (quadrado 6) (quadrado 10))   ; substitui (quadrado 6) pelo corpo
(+ (* 6 6) (quadrado 10))        ; -> 36
(+ 36 (quadrado 10))             ; substitui (quadrado 10) pelo corpo
(+ 36 (* 10 10))                 ; -> 100
(+ 36 100)                       ; -> 136
136
```

Ordem aplicativa x ordem normal
 - ordem aplicativa: primeiro avalia os argumentos, depois aplica a função (é o padrão do Racket)
 - ordem normal: primeiro substitui, só avalia os operandos quando (e se) forem necessários → tipo de avaliação preguiçosa (Haskell usa)
 - no exemplo acima, em ordem normal fica (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2))) e as expressões repetidas são avaliadas mais de uma vez, mas o resultado é o mesmo: 136


### Exercício 1 (custo do combustível)
Entrada: distância (400 km), preço do litro (R$ 5), rendimento (10 km/l)
 - litros = distância / rendimento → 400/10 = 40
 - custo = litros × preço → 40 × 5 = 200

```racket
(define (custo-combustivel distancia preco-do-litro rendimento)
  (* (/ distancia rendimento) preco-do-litro))

> (custo-combustivel 400 5 10)
200
```

### Exercício 2 (álcool ou gasolina)
Abastecer com álcool se o preço dele for até 70% do preço da gasolina, senão gasolina
 - com o q vimos até aqui não dá pra resolver! falta uma expressão condicional


### Condicional (if)
Forma geral: (if <predicado> <consequente> <alternativa>)

```racket
> (if (> 4 2) (+ 10 2) (* 7 3))
12
> (if (= 10 12) (+ 10 2) (* 7 3))
21
```

 - no Racket o if é uma expressão (produz um valor); na maioria das outras linguagens é uma sentença (muda o estado do programa)
 - o if NÃO é uma função: se fosse, os dois ramos seriam avaliados antes (regra das funções). Ele avalia só o consequente ou só a alternativa
 - o if é uma forma especial, com regra de avaliação própria (Racket tem poucas formas especiais → sintaxe fácil de aprender)

Regra de avaliação do if
 - se o predicado não é um valor, avalia ele e substitui pelo valor
 - se o predicado é #t, substitui o if inteiro pelo consequente e avalia
 - se o predicado é #f, substitui o if inteiro pela alternativa e avalia

```racket
(define (abs x)
  (if (>= x 0)
      x
      (- x)))

(abs -4)
(if (>= -4 0) -4 (- -4)) ; predicado não é valor, avalia
(if #f -4 (- -4))        ; #f, fica a alternativa
(- -4)
4
```


### Expressão (versão 1.0)
 - literal; ou
 - função primitiva; ou
 - nome; ou
 - forma especial; ou
 - combinação

Avaliação: igual à 0.3 + forma especial → avalia usando a regra de avaliação específica dela


### Condicional (cond)
Usado quando tem vários casos (pelo menos um), substitui ifs encadeados

```racket
(define (sinal x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [else -1]))
```

 - cada [<p> <e>] é uma cláusula (parênteses e colchetes são equivalentes no Racket)
 - 1ª expressão da cláusula: predicado (interpretado como verdadeiro ou falso)
 - 2ª expressão: consequente

Regra de avaliação do cond
 - se o 1º predicado não é valor, avalia e substitui pelo valor
 - se o 1º predicado é #t ou else, substitui o cond inteiro pelo 1º consequente e avalia
 - se o 1º predicado é #f, remove a 1ª cláusula
 - se não tem mais cláusula, erro

```racket
(sinal 0)
(cond [(> 0 0) 1] [(= 0 0) 0] [else -1]) ; avalia (> 0 0)
(cond [#f 1] [(= 0 0) 0] [else -1])      ; #f, remove a cláusula
(cond [(= 0 0) 0] [else -1])             ; avalia (= 0 0)
(cond [#t 0] [else -1])                  ; #t, fica o consequente
0
```


### Exercício e-logico / ou-logico
e-logico: se x é #t, o resultado é o valor de y; senão é #f
 - (equal? a #t) é o mesmo q a (se a for booleano)
 - (if y #t #f) é o mesmo q y (se y for booleano)

```racket
(define (e-logico x y)
  (if x y #f))

(define (ou-logico x y)
  (if x #t y))
```

Limitação de fazer isso como função
 - por ser função, todos os argumentos são avaliados antes, então não dá pra fazer avaliação em curto-circuito
 - curto-circuito: no e, se o 1º é #f nem precisa avaliar o 2º; no ou, se o 1º é #t nem precisa avaliar o 2º
 - permite condições dependentes, tipo x != 0 e 10 / x == 2
 - por isso o and e o or do Racket são formas especiais


### Operadores lógicos
Predicados podem ser compostos com as formas especiais and e or e a função not

not
 - (not exp) produz #t quando exp é #f, e #f caso contrário
 - (not (> 5 2)) → #f

and → (and <e1> ... <en>)
 - sem expressões → #t
 - se a 1ª expressão não é valor, avalia e substitui
 - se a 1ª é #f → #f
 - se a 1ª é #t → remove ela e continua com o resto
 - obs: o stepper do Racket é um pouco diferente (não elimina os #t)

```racket
(and (> 4 2) #t (= 3 3))
(and #t #t (= 3 3))
(and #t (= 3 3))
(and (= 3 3))
(and #t)
(and)
#t
```

or → (or <e1> ... <en>)
 - sem expressões → #f
 - se a 1ª expressão não é valor, avalia e substitui
 - se a 1ª é #t → #t
 - se a 1ª é #f → remove ela e continua com o resto
 - obs: o stepper do Racket não elimina os #f

```racket
(or (< 4 2) #t (= 3 3))
(or #f #t (= 3 3))
(or #t (= 3 3))
#t
```


### Igualdade
Igualdade = determinar se dois objetos são "os mesmos"
 - é diferente da igualdade numérica (=), q só vê se os valores são numericamente iguais → (= 2 2.0) é #t
 - principais funções: equal? e eq?

equal?
 - cada tipo define sua implementação; em geral são equal? se referenciam o mesmo objeto ou se o conteúdo é o mesmo
 - strings: mesmo tamanho e mesma sequência de caracteres → (equal? "banana" "banana") é #t
 - estruturas compostas (listas): checa recursivamente
   - (equal? (list 3 (list 4 2) 5) (list 3 (list 4 2) 5)) → #t
   - (equal? (list 3 2.0 1) (list 3 2 1)) → #f (2.0 não é equal? a 2)

eq?
 - (eq? v1 v2) é #t se v1 e v2 referenciam o mesmo objeto
 - é rápido pq só compara referências, mas pode não ser adequado pq não fica claro quando objetos novos são criados
 - (eq? 2 2) → #t, (eq? (+ 3 5) (+ 5 3)) → #t, (eq? 2 2.0) → #f
 - (eq? (expt 2 100) (expt 2 100)) → #f e (eq? (integer->char 955) (integer->char 955)) → #f, pq foram criados objetos distintos pro mesmo valor