## Árvores e processamento simultâneo

### Árvores binárias
```
        3
      /   \
     4     7
    /     / \
   3     8   9
            /
           10
```

Uma ÁrvoreBinária é
 - empty; ou
 - (no Número ÁrvoreBinária ÁrvoreBinária), onde no é uma estrutura com os campos valor, esq e dir

```racket
(struct no (valor esq dir) #:transparent)

;; modelo
(define (fn-para-ab t)
  (cond
    [(empty? t) ...]
    [else
     (... (no-valor t)
          (fn-para-ab (no-esq t))
          (fn-para-ab (no-dir t)))]))
```
 - 2 autorreferências na definição (esq e dir) → 2 chamadas recursivas no modelo


### Exemplo: altura da árvore
Altura = distância entre a raiz e o descendente mais afastado
 - o enunciado diz q uma árvore com um nó só tem altura 0, mas a especificação final usa altura 1 pra um nó e 0 pra árvore vazia
 - fazendo os exemplos apareceu a dúvida: qual a altura da árvore vazia? → decidiu 0 e atualizou o propósito

```racket
;;        t4       3
;;               /   \
;;   t3         4     7       t2
;;             /     / \
;;            3     8   9     t1
;;                     /
;;               t0   10

(define t0 (no 10 empty empty))
(define t1 (no 9 t0 empty))
(define t2 (no 7 (no 8 empty empty) t1))
(define t3 (no 4 (no 3 empty empty) empty))
(define t4 (no 3 t3 t2))

;; ÁrvoreBinária -> Natural
;; Devolve a altura da árvore binária. A altura de uma árvore binária é a
;; distância da raiz a seu descendente mais afastado. Uma árvore com um
;; único nó tem altura 1. Uma árvore vazia tem altura 0.
(examples
 (check-equal? (altura empty) 0)
 (check-equal? (altura t0) 1)
 (check-equal? (altura t1) 2)
 (check-equal? (altura t2) 3)
 (check-equal? (altura t3) 2)
 (check-equal? (altura t4) 4))

(define (altura t)
  (cond
    [(empty? t) 0]
    [else (add1 (max (altura (no-esq t))
                     (altura (no-dir t))))]))
```
 - o valor do nó não importa aqui, só a maior altura entre as subárvores + 1


### Listas aninhadas
Lista q contém listas, q contêm listas etc
```racket
> (list 1 4 (list 5 empty (list 2) 9) 10)
'(1 4 (5 () (2) 9) 10)
```

Uma ListaAninhada é
 - empty; ou
 - (cons ListaAninhada ListaAninhada); ou
 - (cons Número ListaAninhada)

```racket
;; modelo
(define (fn-para-ladn ldn)
  (cond
    [(empty? ldn) ...]
    [(list? (first ldn))           ; o primeiro é uma lista → recursão nele tb
     (... (fn-para-ladn (first ldn))
          (fn-para-ladn (rest ldn)))]
    [else                          ; o primeiro é um número
     (... (first ldn)
          (fn-para-ladn (rest ldn)))]))
```


### Exemplo: soma*
Somar todos os números de uma lista aninhada
```racket
;; ListaAninhada -> Número
;; Devolve a soma de todos os elementos de ldn.
(examples
 (check-equal? (soma* empty) 0)
 (check-equal? (soma* (list (list 1 (list empty 3)) (list 4 5) 4 6 7)) 30))

(define (soma* ldn)
  (cond
    [(empty? ldn) 0]
    [(list? (first ldn))
     (+ (soma* (first ldn))
        (soma* (rest ldn)))]
    [else
     (+ (first ldn)
        (soma* (rest ldn)))]))
```


### Exemplo: aplaina
Transformar uma lista aninhada numa lista sem aninhamento, com os mesmos elementos na mesma ordem
```racket
;; ListaAninhada -> ListaDeNúmeros
;; Devolve uma versão não aninhada de ldn, isto é, uma lista com os mesmos
;; elementos de ldn, mas sem aninhamento.
(examples
 (check-equal? (aplaina empty) empty)
 (check-equal? (aplaina (list (list 1 (list empty 3)) (list 4 5) 4 6 7))
               (list 1 3 4 5 4 6 7)))

(define (aplaina ldn)
  (cond
    [(empty? ldn) empty]
    [(list? (first ldn))
     (append (aplaina (first ldn))    ; junta as duas listas aplainadas
             (aplaina (rest ldn)))]
    [else
     (cons (first ldn)
           (aplaina (rest ldn)))]))
```


### Processamento simultâneo
Função q recebe 2 argumentos e os 2 são de tipos com autorreferência. 3 possibilidades:
 1) tratar um dos argumentos como atômico e usar o modelo do outro
 2) processar os dois de forma sincronizada
 3) considerar todos os casos possíveis


### Caso 1: concatenação
Concatenar duas listas de números
```racket
;; ListaDeNúmeros ListaDeNúmeros -> ListaDeNúmeros
;; Produz uma nova lista com os elementos de lsta seguidos
;; dos elementos de lstb.
(examples
 (check-equal? (concatena empty (list 10 4 6))
               (list 10 4 6))
 (check-equal? (concatena (list 3) (list 10 4 6))
               (list 3 10 4 6))
 (check-equal? (concatena (list 7 3) (list 10 4 6))
               (list 7 3 10 4 6)))
```
 - pelo propósito e exemplos, qual dá pra tratar como atômico (não precisa decompor)? lstb
 - então usa o modelo pra processar lsta (lstb só vai junto)

```racket
(define (concatena lsta lstb)
  (cond
    [(empty? lsta) lstb]
    [else
     (cons (first lsta)
           (concatena (rest lsta) lstb))]))
```


### Caso 2: soma ponderada
Soma ponderada a partir de uma lista de números e uma lista de pesos
```racket
;; ListaDeNúmeros ListaDeNúmeros -> Número
;; Calcula a soma ponderada dos valores de lst considerando que cada
;; elemento de lst tem como peso o elemento correspondente em pesos.
;; Requer que lst e pesos tenham o mesmo tamanho
(examples
 (check-equal? (soma-ponderada empty empty) 0)
 (check-equal? (soma-ponderada (list 4) (list 2)) 8)             ; (+ 0 (* 4 2))
 (check-equal? (soma-ponderada (list 3 4) (list 5 2)) 23)        ; (+ (* 3 5) (* 4 2))
 (check-equal? (soma-ponderada (list 5 3 4) (list 1 5 2)) 28))   ; (+ (* 5 1) (* 3 5) (* 4 2))
```

O requisito de mesmo tamanho ajuda no corpo
 - se lst é vazia, pesos tb é
 - se não são vazias, tem (first lst), (rest lst), (first pesos) e (rest pesos)
 - na chamada recursiva, (rest lst) e (rest pesos) continuam com o mesmo tamanho → processa as duas sincronizadas

```racket
(define (soma-ponderada lst pesos)
  (cond
    [(empty? lst) 0]
    [else
     (+ (* (first lst) (first pesos))
        (soma-ponderada (rest lst) (rest pesos)))]))
```


### Caso 3: prefixo
Verificar se lsta é prefixo de lstb (lstb começa com lsta)
```racket
;; Lista Lista -> Boolean
;; Devolve #t se lsta é prefixo de lstb, #f caso contrário.
(define (prefixo? lsta lstb) #f)
```

Exemplos
 - pelo menos um exemplo pra cada combinação das definições das entradas
 - lsta pode ser empty ou cons, lstb tb
 - pra não esquecer nenhum caso → faz uma tabela!

| lsta \ lstb | empty | (cons ...) |
|---|---|---|
| empty | OK | OK |
| (cons ...) | OK | OK |

```racket
(examples
 (check-equal? (prefixo? empty empty) #t)
 (check-equal? (prefixo? empty (list 3 2 1)) #t)
 (check-equal? (prefixo? (list 3 2 1) empty) #f)
 (check-equal? (prefixo? (list 3 4) (list 3 4)) #t)
 (check-equal? (prefixo? (list 3 4) (list 3 5)) #f)
 (check-equal? (prefixo? (list 3 4) (list 3 4 6 8)) #t)
 (check-equal? (prefixo? (list 3 5) (list 3 4 6 8)) #f)
 (check-equal? (prefixo? (list 3 4 5) (list 3 4)) #f))
```

Implementação
 - dá pra começar com um modelo com os 4 casos, mas fica complicado demais:

```racket
(define (prefixo? lsta lstb)
  (cond
    [(and (empty? lsta) (empty? lstb)) ...]
    [(and (empty? lsta) (cons? lstb)) ... lstb ...]
    [(and (cons? lsta) (empty? lstb)) ... lsta ...]
    [else ... lsta ... lstb ...]))
```

 - melhor: preenche a tabela com as respostas olhando os exemplos

| lsta \ lstb | empty | (cons ...) |
|---|---|---|
| empty | #t | #t |
| (cons ...) | #f | primeiros iguais e recursão |

 - simplificando: se lsta é vazia, é sempre #t (independente de lstb) → a 1ª linha vira um caso só
 - os casos são escolhidos por ordem de simplicidade

```racket
(define (prefixo? lsta lstb)
  (cond
    [(empty? lsta) #t]
    [(empty? lstb) #f]
    [else
     (and (equal? (first lsta) (first lstb))
          (prefixo? (rest lsta) (rest lstb)))]))
```


### Exemplo: k-ésimo
Encontrar o elemento na posição k de uma lista (lista × natural, os dois com autorreferência)
```racket
;; ListaDeNúmeros Natural -> Número
;; Devolve o elemento na posição k da lst.
;; O primeiro elemento está na posição 0.
(define (lista-ref lst k) 0)
```

Tabela de exemplos (lst pode ser empty ou cons; k pode ser 0 ou (add1 ...))

| lst \ k | 0 | (add1 ...) |
|---|---|---|
| empty | erro | erro |
| (cons ...) | (first lst) | recursão |

```racket
(examples
 (check-exn exn:fail? (thunk (lista-ref empty 0)))
 (check-exn exn:fail? (thunk (lista-ref empty 2)))
 (check-equal? (lista-ref (list 3 2 8) 0) 3)
 (check-equal? (lista-ref (list 3 2 8 10) 2) 8)
 (check-exn exn:fail? (thunk (lista-ref (list 3 2 8 10) 4))))
```
 - check-exn verifica se a chamada gera um erro (exn:fail?); thunk embrulha a chamada numa função sem argumentos pra ela não ser avaliada antes da hora
 - lista vazia → erro, independente de k (a linha inteira vira um caso)

```racket
(define (lista-ref lst k)
  (cond
    [(empty? lst) (error "Lista vazia")]
    [(zero? k) (first lst)]
    [else (lista-ref (rest lst) (sub1 k))]))
```