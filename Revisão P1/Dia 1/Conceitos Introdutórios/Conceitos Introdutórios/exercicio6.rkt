#| Criar uma função que receba os valores da diagonal maior, diagonal menor e
calcule e retorne a área de um losango. A =D. d/ 2 Onde A é a área, D é a diagonal maior e d a diagonal menor|#

#lang racket

(define (area_losango D d)
    (/ (* D d) 2))

(area_losango 4 2)