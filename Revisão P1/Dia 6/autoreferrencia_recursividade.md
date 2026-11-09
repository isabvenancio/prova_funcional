## Autorreferência e recursividade

### Introdução
Problema: somar uma sequência de números. Como representar e processar uma quantidade ARBITRÁRIA de dados?
 - tipos de dados com autorreferência: definidos em termos deles mesmos
 - funções recursivas pra processar esses dados


### Listas
É o tipo com autorreferência mais comum nas linguagens funcionais

1ª ideia: estrutura com 2 campos, primeiro (1º item) e resto (o resto da lista, q é uma lista)
```racket
(struct lista (primeiro resto) #:transparent)

(define ldn (lista 4 (lista 2 (lista 8 ???))))
```
 - problema: não tem fim! lista definida em termos de outra lista, q é definida em termos de outra...
 - precisa de um jeito de criar uma lista diretamente, sem ser em termos de outra → a lista vazia

Uma ListaDeNúmeros é um dos valores
 - (vazia); ou
 - (link Número ListaDeNúmeros), onde link é uma estrutura com 2 campos: primeiro e resto

```racket
(struct vazia () #:transparent)
(struct link (primeiro resto) #:transparent)
;; Uma ListaDeNúmeros é um dos valores
;;     - (vazia); ou
;;     - (link Numero ListaDeNúmeros)

> (define ldn1 (link 3 (vazia)))          ; lista com o 3
> (define ldn2 (link 8 (link 7 (vazia)))) ; lista com 8 e 7
> (link-primeiro ldn2)
8
> (link-resto ldn2)
(link 7 (vazia))
> (link-resto ldn1)
(vazia)
> (link-primeiro (link-resto ldn1))
link-primeiro: contract violation  ; vazia não tem primeiro!

> (define ldn3 (link 4 ldn2))  ; lista a partir de uma lista existente
> ldn3
(link 4 (link 8 (link 7 (vazia))))
```


### Modelo de função pra listas
A forma do dado de entrada sugere a forma do corpo da função
 - ListaDeNúmeros tem 2 casos → condicional com 2 casos (vazia ou link)
 - (link-primeiro ldn) é um número (atômico) → processa direto
 - (link-resto ldn) é uma lista (união) → processa fazendo análise de casos → chamada recursiva!

```racket
(define (fn-para-ldn ldn)
  (cond
    [(vazia? ldn) ...]
    [else
     (... (link-primeiro ldn)
          (fn-para-ldn (link-resto ldn)))]))
```

Relação entre a definição do dado e o modelo
 - a definição tem 2 casos, o modelo tb
 - a autorreferência na definição sugere uma chamada recursiva no modelo


### Exemplo: soma
```racket
;; ListaDeNúmeros -> Número
;; Soma os valores de ldn.
(examples
 (check-equal? (soma (vazia)) 0)
 (check-equal? (soma (link 3 (vazia))) 3)                    ; (+ 3 0)
 (check-equal? (soma (link 2 (link 5 (vazia)))) 7)           ; (+ 2 (+ 5 0))
 (check-equal? (soma (link 4 (link 1 (link 3 (vazia))))) 8)) ; (+ 4 (+ 1 (+ 3 0)))
```

Implementação a partir do modelo
 1. copia o modelo e muda o nome da função (na definição E na chamada recursiva)
 2. caso vazio: olhando os exemplos → 0
 3. caso não vazio: PONTO CRUCIAL → mesmo a função não estando completa, assume q ela produz a resposta certa pro resto da lista
 4. olha os exemplos pra ver como compor o resultado com o q tem:
    - (link 3 (vazia)) → tem 3 (primeiro) e 0 (soma do resto) → (+ 3 0)
    - (link 2 (link 5 (vazia))) → tem 2 e 5 → (+ 2 5)
    - (link 4 (link 1 (link 3 (vazia)))) → tem 4 e 4 → (+ 4 4)

```racket
(define (soma ldn)
  (cond
    [(vazia? ldn) 0]
    [else
     (+ (link-primeiro ldn)
        (soma (link-resto ldn)))]))
```


### Listas pré-definidas no Racket
 - empty no lugar de (vazia)
 - cons no lugar de link
 - first no lugar de link-primeiro
 - rest no lugar de link-resto
 - empty? verifica se é vazia
 - cons? verifica se NÃO é vazia
 - list? verifica se um valor é uma lista

Uma ListaDeNúmeros é um dos valores
 - empty; ou
 - (cons Número ListaDeNúmeros)

```racket
;; Modelo de funções para ListaDeNúmeros
(define (fn-para-ldn ldn)
  (cond
    [(empty? ldn) ...]
    [else
     ... (first ldn)
     ... (fn-para-ldn (rest ldn)) ...]))
```

```racket
> (define ldn2 (cons 8 (cons 7 empty)))
> ldn2
'(8 7)
> (first ldn2)
8
> (rest ldn2)
'(7)
> (rest (rest ldn2))
'()
> (define ldn3 (cons 4 ldn2))
> ldn3
'(4 8 7)
```

Forma conveniente de criar listas: (list <a1> <a2> ... <an>) é o mesmo q (cons <a1> (cons <a2> ... (cons <an> empty)))
```racket
> (list 4 5 6 -2 20)
'(4 5 6 -2 20)
```


### Exemplo: contém
Verificar se um valor está numa lista

```racket
;; ListaDeNúmeros Número -> Booleano
;; Produz #t se v está em ldn; #f caso contrário.
(examples
 (check-equal? (contem? empty 3) #f)
 (check-equal? (contem? (cons 3 empty) 3) #t)
 (check-equal? (contem? (cons 3 empty) 4) #f)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 4) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 10) #t)
 (check-equal? (contem? (cons 4 (cons 10 (cons 3 empty))) 8) #f))
```

Implementação
 - parte do modelo, ajusta o nome e adiciona o parâmetro v (na definição, na chamada recursiva e como valor disponível nos 2 casos)
 - lista vazia → #f
 - não vazia: tem (first ldn), v e (contem? (rest ldn) v)
   - se (first ldn) = v → #t direto, independente da chamada recursiva
   - senão, a resposta é a mesma de (contem? (rest ldn) v)

```racket
(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
     (if (= v (first ldn))
         #t
         (contem? (rest ldn) v))]))

;; revisão
(define (contem? ldn v)
  (cond
    [(empty? ldn) #f]
    [else
     (or (= v (first ldn))
         (contem? (rest ldn) v))]))
```


### Exemplo: remove negativos
```racket
;; ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista removendo os valores negativos de ldn.
(examples
 (check-equal? (remove-negativos empty) empty)
 (check-equal? (remove-negativos (cons -1 (cons 2 (cons -3 empty))))
               (cons 2 empty))
 (check-equal? (remove-negativos (cons 3 (cons 4 (cons -2 empty))))
               (cons 3 (cons 4 empty))))

(define (remove-negativos ldn)
  (cond
    [(empty? ldn) empty]
    [else
     (if (< (first ldn) 0)
         (remove-negativos (rest ldn))          ; negativo: ignora
         (cons (first ldn)                      ; senão: mantém
               (remove-negativos (rest ldn))))]))
```
Revisão: fica de exercício


### Exemplo: soma x
Somar x em cada elemento da lista

```racket
;; ListaDeNúmeros Número -> ListaDeNúmeros
;; Produz uma nova lista somando x a cada elemento de ldn.
(examples
 (check-equal? (soma-x empty 4) empty)
 (check-equal? (soma-x (cons 4 (cons 2 empty)) 5)
               (cons 9 (cons 7 empty)))
 (check-equal? (soma-x (cons 3 (cons -1 (cons 4 empty))) -2)
               (cons 1 (cons -3 (cons 2 empty)))))

(define (soma-x ldn x)
  (cond
    [(empty? ldn) empty]
    [else
     (cons (+ x (first ldn))
           (soma-x (rest ldn) x))]))
```


### Exemplo: junta com "," e "e"
Juntar uma lista de strings (não vazias) separando com ", " e " e " de acordo com o português
 - o propósito parece difícil de escrever → faz os exemplos primeiro!

 - empty → ""
 - (list "maça") → "maça"
 - (list "banana" "maça") → "banana e maça"
 - (list "mamão" "banana" "maça") → "mamão, banana e maça"
 - (list "aveia" "mamão" "banana" "maça") → "aveia, mamão, banana e maça"

As respostas são calculadas do mesmo jeito? NÃO, os 3 primeiros têm uma forma específica, não recursiva → precisa de 3 casos base

```racket
;; ListaDeStrings -> String
;; Se a lista é vazia, devolve "".
;; Se a lista tem apenas um elemento, devolve esse elemento.
;; Senão, junta as strings de lst, separando-as com ", ", com exceção da
;; última string, que é separada com " e ".
(define (junta-virgula-e lst)
  (cond
    [(empty? lst) ""]
    [(empty? (rest lst)) (first lst)]
    [(empty? (rest (rest lst)))
     (string-append (first lst) " e " (second lst))]
    [else
     (string-append (first lst) ", " (junta-virgula-e (rest lst)))]))
```


### Números naturais
Natural é atômico ou composto?
 - atômico: em operações aritméticas, comparações etc
 - composto: quando precisa fazer uma iteração baseada no valor do número

Um Natural é
 - 0; ou
 - (add1 n), onde n é um Natural

Funções pré-definidas
 - add1 → compõe um natural a partir de outro (tipo o cons) → (add1 8) = 9
 - sub1 → decompõe (tipo o rest) → (sub1 8) = 7
 - zero? → verifica se é 0 (tipo o empty?)

```racket
;; modelo
(define (fn-para-natural n)
  (cond
    [(zero? n) ...]
    [else
     (... n
          (fn-para-natural (sub1 n)))]))
```


### Exemplo: soma naturais
Somar os naturais de 0 até n
```racket
;; Natural -> Natural
;; Soma todos os números naturais de 0 até n
(examples
 (check-equal? (soma-nat 0) 0)
 (check-equal? (soma-nat 1) 1)  ; (+ 1 0)
 (check-equal? (soma-nat 2) 3)  ; (+ 2 1 0)
 (check-equal? (soma-nat 3) 6)) ; (+ 3 2 1 0)

(define (soma-nat n)
  (cond
    [(zero? n) 0]
    [else
     (+ n (soma-nat (sub1 n)))]))
```


### Exemplo: lista de números
Dado n, devolver (list 1 2 ... n-1 n)
```racket
;; Natural -> ListaDeNúmeros
;; Cria uma lista com os valores 1 2 ... n-1 n
(examples
 (check-equal? (lista-num 0) empty)
 (check-equal? (lista-num 1) (cons 1 empty))
 (check-equal? (lista-num 2) (cons 1 (cons 2 empty)))
 (check-equal? (lista-num 3) (cons 1 (cons 2 (cons 3 empty)))))

(define (lista-num n)
  (cond
    [(zero? n) empty]
    [else
     (cons-fim n (lista-num (sub1 n)))]))
```
 - n tem q ir no FIM da lista do resto → pensamento desejoso: usa cons-fim (ainda não existe) e projeta ela depois

```racket
;; Número ListaDeNúmeros -> ListaDeNúmeros
;; Adiciona n ao final de ldn.
(examples
 (check-equal? (cons-fim 3 empty)
               (cons 3 empty))
 (check-equal? (cons-fim 4 (cons 3 empty))
               (cons 3 (cons 4 empty)))
 (check-equal? (cons-fim 1 (cons 3 (cons 4 empty)))
               (cons 3 (cons 4 (cons 1 empty)))))

(define (cons-fim n ldn)
  (cond
    [(empty? ldn) (cons n empty)]
    [else
     (cons (first ldn)
           (cons-fim n (rest ldn)))]))
```


### Inteiros
Às vezes o caso base não é 0 → generaliza a definição de natural com um limite inferior a

Um Inteiro>=a é
 - a; ou
 - (add1 n), onde n é um Inteiro>=a

```racket
(define (fn-para-inteiro>=a n)
  (cond
    [(<= n a) ...]
    [else
     (... n
          (fn-para-inteiro>=a (sub1 n)))]))
```


### Limitações do modelo
Cada tipo com autorreferência tem um modelo q é ponto de partida, mas às vezes ele não ajuda
 - palíndromo (lista igual lida dos dois lados): pra (list 5 4 1 4), o modelo sugere ver se (list 4 1 4) é palíndromo → isso não ajuda a saber se a lista toda é
 - número primo (exatamente 2 divisores, 1 e n): pra 13, o modelo sugere ver se 12 é primo → não ajuda em nada

O problema: a solução do problema original não sai da solução do subproblema gerado pela decomposição estrutural do dado

Opções
 - redefinir o problema pra q a solução do subproblema estrutural ajude
 - decompor em subproblema(s) de forma NÃO estrutural
 - fazer um plano (sequência de etapas) sem pensar em decompor em subproblemas do mesmo tipo


### Redefinição do problema (primo)
Novo problema: dados n e a ≤ n, quantos divisores de n são ≤ a?
 - se sei quantos divisores de n são ≤ a − 1, pra saber os ≤ a é só somar 1 se a divide n
 - n é primo se (= (num-divisores n n) 2)

```racket
;; Natural -> Boolean
;; Produz #t se n é um número primo, isto é, tem exatamente dois divisores
;; distintos (1 e n). Produz #f caso contrário.
(examples
 (check-equal? (primo? 1) #f)
 (check-equal? (primo? 2) #t)
 (check-equal? (primo? 6) #f)
 (check-equal? (primo? 7) #t)
 (check-equal? (primo? 10) #f))

(define (primo? n)
  ;; Natural Natural -> Natural
  ;; Calcula o número de divisores de n que são <= a.
  (define (num-divisores n a)
    (cond
      [(zero? a) 0]
      [(= (remainder n a) 0) (add1 (num-divisores n (sub1 a)))]
      [else (num-divisores n (sub1 a))]))
  (= (num-divisores n n) 2))
```


### Decomposição não estrutural (palíndromo 1)
Pra (list 4 1 5 1 4): q subproblema ajuda? tirar o 1º e o último elemento
 - se a lista sem os extremos é palíndromo, a lista é palíndromo se o 1º e o último forem iguais

```racket
;; Lista -> Booleano
;; Produz #t se lst é palindromo, isto é, tem os mesmos elementos
;; quando lida da direita para esquerda e da esquerda para direita.
;; Produz #f caso contrário.
(examples
 (check-equal? (palindromo? empty) #t)
 (check-equal? (palindromo? (list 2)) #t)
 (check-equal? (palindromo? (list 1 2)) #f)
 (check-equal? (palindromo? (list 3 3)) #t)
 (check-equal? (palindromo? (list 3 7 3)) #t)
 (check-equal? (palindromo? (list 3 7 3 3)) #f))

(define (palindromo? lst)
  (cond
    [(empty? lst) #t]
    [(empty? (rest lst)) #t]
    [else (and (equal? (first lst) (last lst))
               (palindromo? (sem-extremos lst)))]))
```
Exercício: implementar sem-extremos e revisar palindromo?

Recursão estrutural x generativa
 - estrutural: opera em subproblemas da decomposição estrutural do dado
 - generativa: opera em subproblemas arbitrários (não estruturais)
 - a generativa pode exigir um "insight", por isso tenta primeiro com recursão estrutural


### Plano (palíndromo 2)
Em vez de decompor num subproblema do mesmo tipo, faz uma sequência de etapas q resolvem problemas intermediários
 - ex: inverte a lista e compara com a original
 - precisaria projetar 2 funções novas (dá pra fazer com recursão estrutural)

```racket
(define (palindromo? lst)
  (equal? lst (reverse lst)))
```
Exercício: implementar equal? e reverse (aqui usou as pré-definidas)


### Revisão
Tipos com autorreferência → representar dados de tamanho arbitrário
 - processados com funções recursivas

Pra ser bem formada, uma definição com autorreferência precisa de
 - pelo menos um caso base (sem autorreferência): cria os valores iniciais
 - pelo menos um caso com autorreferência: cria valores novos a partir dos existentes

Às vezes é útil ver naturais e inteiros como compostos e definidos com autorreferência

Dois tipos de recursão
 - estrutural: na decomposição natural do dado (nas partes q são autorreferência na definição)
 - generativa: qualquer uma q não é estrutural

A estrutural só serve quando a solução pode ser expressa em termos da solução do subproblema estrutural. Senão
 - alterar o problema e usar recursão natural
 - usar recursão generativa
 - usar um plano (sequência de etapas)