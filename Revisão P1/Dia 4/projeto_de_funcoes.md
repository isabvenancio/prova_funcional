## Projeto de funções

### O que é
Um processo para projetar funções (inspirado no livro How to Design Programs - HtDP)
 - volta no problema da Márcia (álcool ou gasolina) da aula passada: como projetar esse programa?

Etapas (cada uma tem um objetivo e depende das anteriores)
 - Análise: identificar o problema a ser resolvido
 - Definição dos tipos de dados: definir como as informações serão representadas
 - Especificação: especificar com precisão o q a função deve fazer
 - Implementação: implementar a função de acordo com a especificação
 - Verificação: verificar se a implementação está de acordo com a especificação
 - Revisão: identificar e fazer melhorias na especificação e implementação

Às vezes precisa mudar a ordem (ex: na implementação aparece uma condição nova e tem q voltar e alterar a especificação), mas NUNCA ir direto pra implementação!

E programas?
 - um programa é composto de várias funções, então decompõe o programa em funções e aplica o processo em cada uma
 - primeiro treina com problemas de uma função só, depois problemas mais elaborados


### Análise
Perguntas
 - quais informações são relevantes e quais podem ser descartadas?
 - existe alguma omissão?
 - existe alguma ambiguidade?
 - quais conhecimentos do domínio do problema são necessários?
 - o q deve ser feito?

Resultado (Márcia): determinar o combustível q será usado. Se o preço do álcool for até 70% do preço da gasolina, usa álcool, senão gasolina


### Definição dos tipos de dados
Perguntas
 - quais são as informações envolvidas no problema?
 - como as informações serão representadas?

```racket
;; Preco é um número positivo

;; Combustivel é um dos valores
;; - "Alcool"
;; - "Gasolina"
```

 - Racket tem vinculação dinâmica de tipos e não tem apelido de tipos nem tipos enumerados, então os "tipos" ficam em comentários
 - aqui os tipos servem como documentação


### Especificação
Tem 3 partes
 - assinatura da função
 - propósito (o q a função faz)
 - exemplos de entrada e saída

```racket
;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser utilizado no abastecimento.
;; Produz "Alcool" se preco-alcool for menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(define (seleciona-combustivel preco-alcool preco-gasolina) ...)
```

Exemplos
 - álcool 3.00, gasolina 4.00 → "Gasolina" (3.00 ≤ 0.7 × 4.00 é falso)
 - álcool 2.90, gasolina 4.20 → "Alcool" (2.90 ≤ 0.7 × 4.20 é verdadeiro)
 - álcool 3.50, gasolina 5.00 → exatamente 70%, a especificação original não dizia o q fazer!
   - fazendo os exemplos aparece a ambiguidade, aí tem q tomar uma decisão e deixar o propósito mais preciso (decidiu q exatamente 70% tb é álcool → "menor ou igual")

Propósito
 - descreve O QUÊ a função faz, e não COMO (o como é a implementação; às vezes precisa dizer, mas é raro)
 - tb informa as garantias da saída e as restrições sobre os parâmetros
 - ex. número par → o quê: verifica se um número é par / como: resto da divisão por 2 comparado com 0, ou divisão inteira × 2 comparado com o número
 - ex. ordenação → o quê: ordena os elementos de uma lista em ordem não decrescente / como: seleção, inserção, intercalação etc

Como saber se a especificação está boa: um outro desenvolvedor, sem acesso ao problema original nem à análise, tem as informações necessárias pra fazer uma implementação e verificação inicial? se sim tá boa, se não tá incompleta


### Implementação
Perguntas
 - precisa de conhecimento específico do domínio? → enumera o q vai ser usado
 - existem casos distintos? → enumera os casos
 - é uma composição de funções? → pensamento desejoso: faz a composição supondo q as funções já existem
 - os dados de entrada têm autorreferência? → analisa os casos base e com autorreferência e chama a função recursivamente nos casos apropriados

Márcia: tem 2 formas de resposta ("Alcool" e "Gasolina"), então precisa de uma condição pra distinguir

```racket
(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```


### Verificação
A implementação está de acordo com a especificação? usa os exemplos da especificação pra conferir

```racket
> (seleciona-combustivel 3.00 4.00)
"Gasolina"
> (seleciona-combustivel 2.90 4.20)
"Alcool"
> (seleciona-combustivel 3.50 5.00)
"Alcool"
```

Funcionar pra alguns exemplos NÃO garante q a função está correta. Então pq fazer exemplos?
 - 1º objetivo: ajudar o projetista a entender como a função funciona
 - 2º objetivo: ilustrar o funcionamento pra especificação ficar mais clara
 - depois servem como verificação inicial: não provam q funciona, mas aumentam a confiança
 - dá pra ampliar a verificação com testes de propriedades, fuzzing etc, mas na disciplina vamos usar só os exemplos

Exemplos como código
 - em vez de escrever em linguagem natural e testar na mão na janela de interações, escreve os exemplos em código pra rodar automaticamente
 - biblioteca da disciplina: no DrRacket "File -> Install Package…", endereço https://github.com/malbarbo/racket-test-examples.git, "Install"
 - outra opção: rackunit (já vem com a linguagem, não precisa instalar nada, e a saída dos testes é mais simples)

```racket
#lang racket

(require examples)

;; Preco Preco -> Combustivel
;; Encontra o combustivel que deve ser utilizado no abastecimento.
;; Produz "Alcool" se preco-alcool menor ou igual a 70% do preco-gasolina,
;; produz "Gasolina" caso contrário.
(examples
 (check-equal? (seleciona-combustivel 3.00 4.00) "Gasolina")
 (check-equal? (seleciona-combustivel 2.90 4.20) "Alcool")
 (check-equal? (seleciona-combustivel 3.50 5.00) "Alcool"))

(define (seleciona-combustivel preco-alcool preco-gasolina)
  (if (<= preco-alcool (* 0.7 preco-gasolina))
      "Alcool"
      "Gasolina"))
```

Saída: `3 success(es) 0 failure(s) 0 error(s) 3 test(s) run`

Pq um teste pode falhar?
 - o teste está errado
 - a implementação está errada
 - os dois estão errados


### Revisão
 - dá pra melhorar a especificação e o código?
 - dá pra simplificar eliminando casos especiais (generalizando)?
 - dá pra criar abstrações (definição de constantes e funções)?
 - dá pra renomear os objetos?


### Exemplo: aumento de salário
Aumento depende do salário atual: até R$ 1200 → 10%, entre 1200 e 3000 → 7%, entre 3000 e 8000 → 3%, acima de 8000 → sem aumento. Calcular o novo salário

Análise: salário ≤ 1200 → 10%, > 1200 e ≤ 3000 → 7%, > 3000 e ≤ 8000 → 3%, > 8000 → sem aumento

Tipos e especificação
```racket
;; Salario é um número positivo com duas casas decimais

;; Salario -> Salario
;; Calcula o novo salário a partir de um percetual de aumento determinado
;; a partir de salario-atual da seguinte forma:
;; - salario-atual <= 1200, aumento de 10%
;; - 1200 < salario-atual <= 3000, aumento de 7%
;; - 3000 < salario-atual <= 8000, aumento de 3%
;; - 8000 < salario-atual, sem aumento
(define (novo-salario salario-atual) ...)
```

Exemplos
 - além do resultado esperado, coloca um comentário de COMO o resultado foi obtido → ajuda muito na implementação
 - coloca exemplos dos casos limite tb (1200, 3000, 8000, 8000.01)

```racket
(examples
 ; salario-atual <= 1200
 (check-equal? (novo-salario 1000.00) 1100.00) ; (* 1000.00 1.10)
 (check-equal? (novo-salario 1200.00) 1320.00)
 ; salario-atual <= 3000
 (check-equal? (novo-salario 2000.00) 2140.00) ; (* 2000.00 1.07)
 (check-equal? (novo-salario 3000.00) 3210.00)
 ; salario-atual <= 8000
 (check-equal? (novo-salario 5000.00) 5150.00) ; (* 5000.00 1.03)
 (check-equal? (novo-salario 8000.00) 8240.00)
 ; salario-atual > 8000
 (check-equal? (novo-salario 8000.01) 8000.01)) ; 8000.01
```

Implementação
 - quantas formas distintas de resposta? 4 (olhando os comentários dos exemplos)
 - mais de uma forma de resposta → seleção (cond), com um caso pra cada forma → 4 casos
 - pra cada caso: qual condição caracteriza? qual a forma da resposta? (ex: 1º caso → (<= salario-atual 1200) e (* salario-atual 1.1))

```racket
(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.1)]
    [(and (< 1200 salario-atual) (<= salario-atual 3000)) (* salario-atual 1.07)]
    [(and (< 3000 salario-atual) (<= salario-atual 8000)) (* salario-atual 1.03)]
    [(> salario-atual 8000) salario-atual]))
```

Verificação: `7 success(es) 0 failure(s) 0 error(s) 7 test(s) run`

Revisão
 - eliminar condições redundantes (se chegou no 2º caso, já se sabe q é > 1200)
 - comentar os números "mágicos"

```racket
(define (novo-salario salario-atual)
  (cond
    [(<= salario-atual 1200) (* salario-atual 1.10)] ; 10% de aumento
    [(<= salario-atual 3000) (* salario-atual 1.07)] ; 7% de aumento
    [(<= salario-atual 8000) (* salario-atual 1.03)] ; 3% de aumento
    [else salario-atual]))                           ; sem aumento
```

Depois da revisão, verificar de novo!


### Exemplo: massa do tubo de ferro
O Jorge quer saber a massa de tubos de ferro sem balança, mas tem um paquímetro (mede diâmetro interno, externo e altura)

Conhecimento de domínio
 - o problema parece difícil pq precisa de conhecimento de uma área q talvez a gente não tenha
 - solução: alguém (ou livros) q ensine o domínio; os interessados no software geralmente indicam essas pessoas
 - o desenvolvedor resolve problemas dos outros, então tem q estar disposto a estudar outras áreas

Análise
 - dimensões → volume → massa
 - volume = π((diametro_externo − diametro_interno)/2)² × altura
 - massa = volume × densidade
 - densidade do ferro = 7874 kg/m³

Tipos e especificação
```racket
;; Comprimento é um número positivo dado em metros.
;; Massa é um número positivo dado em quilogramas.

;; Comprimento Comprimento Comprimento -> Massa
;; Calcula a massa de um tubo de ferro a partir das suas dimensões.
;; Requer que (> diametro-externo diametro-interno)
(define (massa-tubo-ferro diametro-externo diametro-interno altura) ...)

(examples
 ; (* pi (sqr (/ (- 0.05 0.03) 2)) 0.1 7874)
 (check-equal? (massa-tubo-ferro 0.05 0.03 0.1) 0.2472436))
```

Implementação
 - precisa de seleção? não, só tem uma forma de resposta (sempre a mesma expressão, a da análise)

```racket
(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (* 3.14
     (sqr (/ (- diametro-externo diametro-interno) 2))
     altura
     7874)) ; densidade do ferro
```

Verificação → FALHOU: actual 0.24724360000000015, expected 0.2472436
 - comparar igualdade de ponto flutuante quase nunca dá certo!
 - usa check-= q permite uma margem de erro

```racket
(examples
 (check-= (massa-tubo-ferro 0.05 0.03 0.1) 0.2472436 0.00000001))
```

Revisão
 - definir constantes pros números "mágicos"
 - separar o cálculo do volume em etapas (define dentro da função)

```racket
(define PI 3.14)              ; na prática precisa de mais casas decimais!
(define DENSIDADE-FERRO 7874) ; em kg/m^3

(define (massa-tubo-ferro diametro-externo diametro-interno altura)
  (define area-da-base (* PI (sqr (/ (- diametro-externo diametro-interno) 2))))
  (define volume (* area-da-base altura))
  (* volume DENSIDADE-FERRO))
```

Verificar de novo!

Outras funções de verificação na documentação do rackunit: https://docs.racket-lang.org/rackunit/api.html


### Exemplo: ajuste de texto
Exibir um texto num número máximo de caracteres. Se não cabe, mostra só a parte inicial + "...". O texto pode ser alinhado à direita, à esquerda ou centralizado

Análise: ajustar um texto a um tamanho específico, usando "..." se precisar abreviar, e alinhar à direita, esquerda ou centro

Tipos e especificação
```racket
;; Alinhamento é um dos valores
;; - "direita"
;; - "esquerda"
;; - "centro"

;; String Number Alinhamento -> String
;; Produz uma nova string a partir de s que tem exatamente num-chars
;; caracteres e é alinhada de acordo com o alinhamento.
(define (ajusta-string s num-chars alinhamento) ...)
```

Essa especificação é precisa o bastante pra implementar ou usar a função? NÃO

Exemplos (com as condições e a forma de calcular comentadas)
```racket
(examples
 ; (= (string-length s) num-chars)
 (check-equal? (ajusta-string "casa" 4 "direita") "casa")
 (check-equal? (ajusta-string "casa" 4 "esquerda") "casa")
 (check-equal? (ajusta-string "casa" 4 "centro") "casa")
 ; (> (string-length s) num-chars)
 ; (string-append (substring "casa verde" 0 (- 7 3)) "...")
 (check-equal? (ajusta-string "casa verde" 7 "direita") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "esquerda") "casa...")
 (check-equal? (ajusta-string "casa verde" 7 "centro") "casa...")
 (check-equal? (ajusta-string "casa verde" 9 "direita") "casa v...")
 ; (and (< (string-length s) num-chars) (equal? alinhamento "direita"))
 ; (string-append (make-string (- 9 (string-length "casa")) #\space) "casa")
 (check-equal? (ajusta-string "casa" 9 "direita") "     casa")
 ; (and (< (string-length s) num-chars) (equal? alinhamento "esquerda"))
 ; (string-append "casa" (make-string (- 9 (string-length "casa")) #\space))
 (check-equal? (ajusta-string "casa" 9 "esquerda") "casa     ")
 ; (and (< (string-length s) num-chars) (equal? alinhamento "centro"))
 ; (string-append (make-string num-espacos-inicio #\space)
 ;                "casa"
 ;                (make-string num-espacos-fim #\space))
 ; onde
 ; num-espacos-inicio é (quotient (- 9 (string-length "casa")) 2)
 ; num-espacos-fim é (- 9 (string-length "casa") num-espacos-inicio)
 (check-equal? (ajusta-string "casa" 9 "centro") "  casa   ")
 (check-equal? (ajusta-string "casa" 10 "centro") "   casa   "))
```

Propósito detalhado (melhorado depois de entender com os exemplos)
 - se s tem exatamente num-chars caracteres → produz s
 - se s tem mais q num-chars → s é truncada e "..." é adicionado no final
 - se s tem menos q num-chars → adiciona espaços (no início se "direita", no fim se "esquerda", nos dois se "centro"); no centro, se a quantidade de espaços for ímpar, o fim fica com 1 espaço a mais q o início

Implementação
```racket
(define (ajusta-string s num-chars alinhamento)
  (cond
    [(= (string-length s) num-chars) s]
    [(> (string-length s) num-chars)
     (string-append (substring s 0 (- num-chars 3)) "...")]
    [else
     (define num-espacos (- num-chars (string-length s)))
     (cond
       [(equal? alinhamento "direita")
        (string-append (make-string num-espacos #\space) s)]
       [(equal? alinhamento "esquerda")
        (string-append s (make-string num-espacos #\space))]
       [else
        (define num-espacos-inicio (quotient num-espacos 2))
        (define num-espacos-fim (- num-espacos num-espacos-inicio))
        (string-append
         (make-string num-espacos-inicio #\space)
         s
         (make-string num-espacos-fim #\space))])]))
```

Verificação: ok
Revisão: fica de exercício

Implementação alternativa (decomposição)
 - a especificação tem um "e" ("tem exatamente num-chars caracteres E é alinhada") → a função faz duas coisas
 - decompõe nessas duas coisas usando pensamento desejoso (supõe q as funções existem)

```racket
(define (ajusta-string s num-chars alinhamento)
  (alinha (limita s num-chars)
          num-chars
          alinhamento))
```

 - coloca as funções novas numa lista de trabalho com uma especificação inicial e projeta cada uma seguindo as mesmas etapas

```racket
;; String Number -> String
;; Produz uma nova string a partir de s com no máximo num-chars.
;; ...
(define (limita s num-chars) ...)

;; String Number Alinhamento -> String
;; Produz uma nova string a partir de s alinhada de acordo com o alinhamento.
;; ...
(define (alinha s num-chars alinhamento) ...)
```
