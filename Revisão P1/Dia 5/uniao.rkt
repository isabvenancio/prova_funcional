#lang racket
(require rackunit)

;;Problema: mostrar uma mensagem sobre o estado de uma tarefa. A tarefa pode estar em execução, ter sido concluída (com duração e mensagem de sucesso) ou ter falhado (com código e mensagem de erro)

(struct estado-tarefa (executando duracao msg_sucesso codigo_err msg_err))

; - problema: estados inválidos! o q seria (estado-tarefa #t 10 "Ótimo desempenho" 123 "Falha na conexão")?

; São 3 casos excludentes (se tá num, não deve guardar info dos outros, senão dá estado inconsistente)
;  - em execução
;  - sucesso, com duração e mensagem
;  - falha, com código e mensagem
;  - isso se expressa com união de tipos

; Uniões e estruturas (relação com conjuntos)
;  - estrutura = tipo produto: valores possíveis = produto cartesiano dos valores de cada campo
;  - união = tipo soma: valores possíveis = união dos valores de cada tipo (classe de valores) da união
;  - tipo algébrico de dado = tipo soma de tipos produto
;  - entender isso ajuda a definir os tipos (como no quadrado e no estado da tarefa)

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

; Especificação
;  - quantos exemplos? pelo menos um pra cada classe de valor
;  - (o exercício não especifica muito a saída, o foco é o projeto de dados, então usa a criatividade)

; Implementação
;  - mesmo sem saber os detalhes, dá pra montar a estrutura do corpo só olhando o tipo: 3 casos, cada um com seus seletores

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


;; EstadoTarefa -> String
;; Produz uma string amigável para o usuário para descrever o estado da tarefa.
(check-equal? (msg-usuario "Executando")
               "A tarefa está em execução.")
(check-equal? (msg-usuario (sucesso 12 "Os resultados estão corretos"))
               "Tarefa concluída (12s): Os resultados estão corretos.")
(check-equal? (msg-usuario (erro 123 "Número inválido '12a'"))
               "A tarefa falhou (err 123): Número inválido '12a'.")