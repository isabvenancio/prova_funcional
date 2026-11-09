## Tipos de dados

### Introdução
Definição dos tipos de dados é a 2ª etapa do projeto de funções: identifica as informações do problema e como elas vão ser representadas no programa
 - até agora parecia simples/desnecessária pq as informações eram "simples"
 - mas é muito importante: em muitos casos os tipos de dados guiam o resto das etapas do projeto

Tipo de dado = conjunto de valores q uma variável pode assumir
 - Booleano = {verdadeiro, falso}
 - Combustível = {alcool, gasolina}
 - Natural = {0, 1, 2, ...}
 - Inteiro = {..., -2, -1, 0, 1, 2, ...}
 - String = {"", "a", "b", ...}
 - String q começa com a = {"a", "aa", "ab", ...}


### Requisitos de um tipo de dado
Como saber se um tipo é adequado pra representar uma informação? ex: quantidade de pessoas num planeta
 - inteiro: NÃO, pq pode ser negativo → permite representar valores inválidos
 - unsigned int (C): NÃO, o máximo é 4.294.967.295 e a Terra tem mais gente q isso → nem todos os valores válidos podem ser representados
 - natural: SIM, cada natural é um valor válido e cada valor válido pode ser representado por um natural

Diretrizes pro projeto de tipos de dados
 - faça os valores válidos representáveis
 - faça os valores inválidos irrepresentáveis


### Estruturas
Até agora os tipos eram atômicos (não podem ser decompostos). Estruturas (dados compostos) servem pra quando 2 ou mais valores devem ficar juntos
 - ex: registro de um aluno, placar de um jogo, informações de um produto

Em Racket usa a forma especial struct → (struct <id-estrutura> (<id-campo-1> ...))

```racket
(struct ponto (x y))

;; construção (o construtor tem o mesmo nome da estrutura)
(define p1 (ponto 3 4))
(define p2 (ponto 8 2))

;; seletores
> (ponto-x p1)
3
> (ponto-y p1)
4

;; teste de tipo
> (ponto? p1)
#t
> (ponto? "ola")
#f
```

Funções criadas automaticamente pelo struct
 - construtor: id-estrutura → ponto
 - predicado (verifica se é do tipo): id-estrutura? → ponto?
 - seletores: id-estrutura-id-campo → ponto-x, ponto-y
 - são funções comuns, usadas como qualquer outra (> ponto → #<procedure:ponto>)

Estruturas transparentes
 - por padrão o interpretador não mostra os campos (pra preservar o encapsulamento) → (ponto (+ 1 2) 4) mostra #<ponto>
 - com #:transparent mostra no mesmo formato da criação → (ponto 3 4)
 - #:transparent tb muda o equal?
   - sem: dois pontos só são equal? se forem o MESMO ponto → (equal? (ponto 3 4) (ponto 3 4)) é #f
   - com: são equal? se os campos são iguais → #t

```racket
(struct ponto (x y) #:transparent)
```

Junto com a definição da estrutura, descreve o propósito e os campos

```racket
(struct ponto (x y))
;; Ponto representa um ponto no plano cartesiano
;;    x : Número - a coordenada x
;;    y : Número - a coordenada y
```


### Alterando dados estruturados
Não tem como alterar um campo! paradigma funcional = sem mudança de estado
 - em vez de modificar, cria uma cópia com o campo alterado

```racket
> (define p1 (ponto 3 4))
> (define p2 (ponto (ponto-x p1) 5))
> p2
(ponto 3 5)
```

Limitações desse jeito
 - com muitos campos, pra mudar um só tem q copiar todos os outros na mão
 - se adicionar/remover campos da estrutura, tem q mudar todas as "cópias" no código

Solução: forma especial struct-copy

```racket
> (define p2 (struct-copy ponto p1 [y 5]))
> p2
(ponto 3 5)
> (define p4 (struct-copy ponto p2 [y 9] [x 6])) ; dá pra mudar mais de um campo
> p4
(ponto 6 9)
```

Exemplo: distância de um ponto até a origem
```racket
;; Ponto -> Número
;; Calcula a distância do ponto p a origem.
;; A distância de um ponto (x, y) até a origem é calculada
;; pela raiz quadrada de x^2 + y^2.
(examples
 (check-equal? (distancia-origem (ponto 0 7)) 7)
 (check-equal? (distancia-origem (ponto 1 0)) 1)
 ;; (sqrt (+ (sqr 3) (sqr 4)))
 (check-equal? (distancia-origem (ponto 3 4)) 5))

(define (distancia-origem p)
  (sqrt (+ (sqr (ponto-x p))
           (sqr (ponto-y p)))))
```


### Enumerações
Exemplo contagem: enquete onde cada resposta é uma cor (verde, vermelho, azul ou branco); receber a contagem atual + uma nova resposta e produzir a contagem atualizada

Análise: atualizar a contagem considerando uma nova resposta (verde, vermelho, azul ou branco)

Tipos
 - resposta → tipo enumerado (Racket não suporta, então fica em comentário)
 - contagem → estrutura com um campo pra cada tipo de resposta

```racket
;; Resposta é um dos valores:
;; - "verde"
;; - "vermelho"
;; - "azul"
;; - "branco"

(struct contagem (verde vermelho azul branco) #:transparent)
;; Uma contagem das respostas de cada cor
;;    verde    : Número - número de respostas verde
;;    vermelho : Número - número de respostas vermelho
;;    azul     : Número - número de respostas azul
;;    branco   : Número - número de respostas branco
```

Especificação
```racket
;; Resposta Contagem -> Contagem
;; Atualiza a contagem cont considerando a nova resposta res.
(examples
 (check-equal? (atualiza-contagem "verde" (contagem 4 5 1 2))
               (contagem 5 5 1 2))
 ;; (struct-copy contagem (contagem 4 5 1 2)
 ;;              [verde (add1 (contagem-verde (contagem 4 5 1 2)))])
 (check-equal? (atualiza-contagem "vermelho" (contagem 4 5 1 2))
               (contagem 4 6 1 2))
 ...)
```

Funções q processam tipos enumerados
 - quantos exemplos? pelo menos um pra cada valor da enumeração
 - como começar a implementação? um caso pra cada valor da enumeração, depois completa cada um olhando os exemplos

```racket
(define (atualiza-contagem res cont)
  (cond
    [(equal? res "verde")
     (struct-copy contagem cont [verde (add1 (contagem-verde cont))])]
    [(equal? res "vermelho")
     (struct-copy contagem cont [vermelho (add1 (contagem-vermelho cont))])]
    [(equal? res "azul")
     (struct-copy contagem cont [azul (add1 (contagem-azul cont))])]
    [(equal? res "branco")
     (struct-copy contagem cont [branco (add1 (contagem-branco cont))])]))
```


### Exemplo: campo minado
Campo de quadrados q podem ter minas escondidas
 - abre quadrados clicando; objetivo é abrir todos os q não têm mina; abriu mina → perdeu
 - quadrado aberto mostra quantas minas tem ao redor (máx 8); se for 0, abre todos ao redor
 - pode colocar/remover bandeira num quadrado fechado (sinaliza possível mina e impede de abrir)
 - projetar um tipo pra representar um quadrado (não precisa guardar o nº de bombas ao redor, dá pra calcular)

1ª tentativa: 3 itens relacionados → estrutura, cada um com 2 estados → booleano

```racket
(struct quadrado (mina? aberto? bandeira?) #:transparent)
;;   mina?     : Bool - #t se tem uma mina no quadrado
;;   aberto?   : Bool - #t se o quadrado está aberto
;;   bandeira? : Bool - #t se tem uma bandeira no quadrado
```

Segue as diretrizes? 3 campos × 2 valores = 2 × 2 × 2 = 8 instâncias possíveis

| mina? | aberto? | bandeira? | válido? |
|---|---|---|---|
| #f | #f | #f | sim |
| #f | #f | #t | sim |
| #f | #t | #f | sim |
| #f | #t | #t | NÃO |
| #t | #f | #f | sim |
| #t | #f | #t | sim |
| #t | #t | #f | sim |
| #t | #t | #t | NÃO |

 - 2 estados inválidos! (aberto com bandeira não existe)
 - só 3 das 4 combinações de aberto?/bandeira? são válidas: aberto, fechado, fechado com bandeira
 - solução: juntar aberto? e bandeira? num campo estado com esses 3 valores

```racket
;; Estado é um dos valores
;; - "aberto"
;; - "fechado"
;; - "com-bandeira"

(struct quadrado (mina? estado) #:transparent)
;; Representa um quadrado no jogo campo minado
;;   mina? : Bool - #t se tem uma mina no quadrado, #f caso contrário
;;   estado: Estado - o estado do quadrado
```

 - agora 2 × 3 = 6 instâncias, exatamente os 6 estados válidos


### Exemplo: ação no campo minado
Função q determina como o quadrado fica depois de uma ação do usuário (abrir, adicionar bandeira, remover bandeira)

```racket
;; Acao é um dos valores
;; - "abrir"
;; - "adicionar-bandeira"
;; - "remover-bandeira"
```

Especificação
 - entradas: um quadrado e uma ação; saída: um quadrado
 - só o estado pode mudar, e depende do estado atual E da ação
 - depende de 2 valores enumerados → pelo menos 3 × 3 = 9 exemplos (faz uma tabela pra não esquecer nenhum)

| estado / ação | abrir | adicionar | remover |
|---|---|---|---|
| aberto | - | - | - |
| fechado | aberto | com-bandeira | - |
| com-bandeira | - | - | fechado |

("-" = não muda nada)

```racket
(examples
 (check-equal? (atualiza-quadrado (quadrado #f "aberto") "abrir")
               (quadrado #f "aberto"))
 ; (struct-copy quadrado q [estado "aberto"])
 (check-equal? (atualiza-quadrado (quadrado #f "fechado") "abrir")
               (quadrado #f "aberto"))
 ...)
```

Implementação
 - 1 valor enumerado → seleção com uma condição pra cada valor
 - 2 valores enumerados → seleção de 2 níveis (um cond dentro do outro) OU uma seleção com uma condição pra cada par
 - olhando a tabela, só 3 casos mudam o quadrado → não precisa escrever os 9 casos, dá pra simplificar antes de escrever!

```racket
(define (atualiza-quadrado q acao)
  (define estado (quadrado-estado q))
  (cond
    [(and (equal? estado "fechado") (equal? acao "abrir"))
     (struct-copy quadrado q [estado "aberto"])]
    [(and (equal? estado "fechado") (equal? acao "adicionar-bandeira"))
     (struct-copy quadrado q [estado "com-bandeira"])]
    [(and (equal? estado "com-bandeira") (equal? acao "remover-bandeira"))
     (struct-copy quadrado q [estado "fechado"])]
    [else q]))
```


### Uniões
Problema: mostrar uma mensagem sobre o estado de uma tarefa. A tarefa pode estar em execução, ter sido concluída (com duração e mensagem de sucesso) ou ter falhado (com código e mensagem de erro)

Tentando com uma estrutura
```racket
(struct estado-tarefa (executando duracao msg_sucesso codigo_err msg_err))
```
 - problema: estados inválidos! o q seria (estado-tarefa #t 10 "Ótimo desempenho" 123 "Falha na conexão")?

São 3 casos excludentes (se tá num, não deve guardar info dos outros, senão dá estado inconsistente)
 - em execução
 - sucesso, com duração e mensagem
 - falha, com código e mensagem
 - isso se expressa com união de tipos

Uniões e estruturas (relação com conjuntos)
 - estrutura = tipo produto: valores possíveis = produto cartesiano dos valores de cada campo
 - união = tipo soma: valores possíveis = união dos valores de cada tipo (classe de valores) da união
 - tipo algébrico de dado = tipo soma de tipos produto
 - entender isso ajuda a definir os tipos (como no quadrado e no estado da tarefa)

Tipos
```racket
(struct sucesso (duracao msg))
;; Representa o estado de uma tarefa que finalizou a execução com sucesso
;; duracao: Número - tempo de execução em segundos
;; msg    : String - mensagem de sucesso gerada pela tarefa

(struct erro (codigo msg))
;; Representa o estado de uma tarefa que finalizou a execução com falha
;; codigo: Número - o código da falha
;; msg   : String - mensagem de erro gerada pela tarefa

;; EstadoTarefa é um dos valores:
;; - "Executando"              A tarefa está em execução
;; - (sucesso Número String)   A tarefa finalizou com sucesso
;; - (erro Número String)      A tarefa finalizou com falha
```

Especificação
 - quantos exemplos? pelo menos um pra cada classe de valor
 - (o exercício não especifica muito a saída, o foco é o projeto de dados, então usa a criatividade)

```racket
;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(examples
 (check-equal? (msg-usuario "Executando")
               "A tarefa está em execução.")
 (check-equal? (msg-usuario (sucesso 12 "Os resultados estão corretos"))
               "Tarefa concluída (12s): Os resultados estão corretos.")
 (check-equal? (msg-usuario (erro 123 "Número inválido '12a'"))
               "A tarefa falhou (err 123): Número inválido '12a'."))
```

Implementação
 - mesmo sem saber os detalhes, dá pra montar a estrutura do corpo só olhando o tipo: 3 casos, cada um com seus seletores

```racket
;; esqueleto a partir do tipo
(define (msg-usuario estado)
  (cond
    [(and (string? estado) (string=? estado "Executando")) ...]
    [(sucesso? estado)
     ... (sucesso-duracao estado)
     ... (sucesso-msg estado)]
    [(erro? estado)
     ... (erro-codigo estado)
     ... (erro-msg estado)]))

;; completo
(define (msg-usuario estado)
  (cond
    [(and (string? estado) (string=? estado "Executando"))
     "A tarefa está em execução."]
    [(sucesso? estado)
     (format "Tarefa concluída (~as): ~a."
             (sucesso-duracao estado)
             (sucesso-msg estado))]
    [(erro? estado)
     (format "A tarefa falhou (err ~a): ~a."
             (erro-codigo estado)
             (erro-msg estado))]))
```


### Uniões com verificação estática (Typed Racket)
Tipos algébricos modelam a informação de forma mais precisa (programa mais confiável), mas ficam MUITO mais úteis se a linguagem tiver verificação estática
 - ex: requisito novo, a tarefa pode ficar numa "Fila" antes de executar. Se EstadoTarefa é usado em vários lugares, como achar todos os lugares q precisam mudar?
 - em Racket não dá... em Typed Racket dá!

```racket
#lang typed/racket

(struct executando ())
(struct sucesso ([duracao : Number] [msg : String]))
(struct erro ([codigo : Number] [msg : String]))

(define-type EstadoTarefa
  (U executando sucesso erro))

(: msg-usuario (-> EstadoTarefa String))
(define (msg-usuario estado)
  (cond
    [(executando? estado) "A tarefa está em execução"]
    [(sucesso? estado)
     (format "A tarefa finalizou com sucesso (~as): ~a."
             (sucesso-duracao estado) (sucesso-msg estado))]
    [(erro? estado)
     (format "A tarefa falhou (erro ~a): ~a."
             (erro-codigo estado) (erro-msg estado))]))
```

Se mudar pra
```racket
(struct fila ())
(define-type EstadoTarefa (U fila executando sucesso erro))
```
o analisador estático acusa erro no cond, pq nem todos os casos são tratados (várias outras linguagens com verificador estático fazem o mesmo)


### Uniões em outras linguagens
Com o aumento do uso do paradigma funcional, várias linguagens (até as mais antigas, tipo Java e Python) ganharam suporte a tipos algébricos

Python
```python
from dataclasses import dataclass
from typing import Literal

@dataclass
class Sucesso:
    duracao: int
    msg: str

@dataclass
class Erro:
    codigo: int
    msg: str

EstadoTarefa = Literal["Executando"] | Sucesso | Erro

# com isinstance
def mensagem(estado: EstadoTarefa) -> str:
    if isinstance(estado, str):
        return 'A tarefa está em execução'
    elif isinstance(estado, Sucesso):
        return 'A tarefa finalizou com sucesso ({}s): {}'.format(estado.duracao, estado.msg)
    else:
        return 'A tarefa falhou (error {}): {}'.format(estado.codigo, estado.msg)

# com casamento de padrões (decompõe cada tipo produto nos seus componentes)
def mensagem(estado: EstadoTarefa) -> str:
    match estado:
        case str(estado):
            return 'A tarefa está em execução'
        case Sucesso(duracao, msg):
            return f'A tarefa finalizou com sucesso ({duracao}s): {msg}'
        case Erro(codigo, msg):
            return f'A tarefa falhou (error {codigo}): {msg}'
```

Rust (enum + casamento de padrões)
```rust
pub enum EstadoTarefa {
    Executando,
    Sucesso(u32, String),
    Erro(u32, String),
}

pub fn mensagem(estado: &EstadoTarefa) -> String {
    match estado {
        EstadoTarefa::Executando =>
            "A tarefa está em execução".to_string(),
        EstadoTarefa::Sucesso(duracao, msg) =>
            format!("A tarefa finalizou com sucesso ({duracao}s): {msg}"),
        EstadoTarefa::Erro(codigo, msg) =>
            format!("A tarefa falhou (erro {codigo}): {msg}"),
    }
}
```

Java (sealed interface + records + switch)
```java
sealed interface EstadoTarefa permits Executando, Sucesso, Erro {};
record Executando() implements EstadoTarefa {};
record Sucesso(int duracao, String msg) implements EstadoTarefa {};
record Erro(int erro, String msg) implements EstadoTarefa {};

static String mensagem(EstadoTarefa estado) {
    return switch (estado) {
        case Executando e -> "A tarefa está executando";
        case Sucesso s -> String.format("A tarefa foi concluída (%ds): %s", s.duracao(), s.msg());
        case Erro e -> String.format("A tarefa falhou (erro %d): %s", e.erro(), e.msg());
    };
}
```
 - a JEP 405 (em preview) permite usar padrões pra decompor records


### Revisão
Dois princípios pro projeto de tipos de dados
 - faça os valores válidos representáveis
 - faça os valores inválidos irrepresentáveis

Formas de definir novos tipos
 - estruturas (tipo produto)
 - enumerações (tipo soma)
 - uniões (tipo soma)

Os tipos guiam o projeto
 - tipo soma com N casos → pelo menos N exemplos
 - tipo soma com N casos → corpo com uma análise de N casos

Um analisador estático amplia muito a utilidade dos tipos algébricos, garantindo q o código trate todos os casos


### Referências
Básicas
 - vídeos Compound Data
 - vídeos Reference
 - vídeo Making Impossible States Impossible
 - seções 5.1 a 5.5 do Guia Racket

Leitura recomendada
 - Expression problem