;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#lang racket 
(require rackunit)
;#reader(lib "htdp-beginner-reader.ss" "lang")((modname percentual-ir-if) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (percentual-if salario)
  (if (<= salario 5000)
      0
      (if (<= salario 10000)
          0.1
          (if (<= salario 15000)
              0.2 
              0.3))))

(percentual-if 3000)
(percentual-if 8000)
(percentual-if 13000)
(percentual-if 18000)


(define (percentual-if-check salario)
    (if (<= salario 5000)
        0
        (if (<= salario 10000)
            0.1
            (if (<= salario 15000)
                0.2
                0.3))))

(check-equal? (percentual-if-check 3000) 0)
(check-equal? (percentual-if-check 8000) 0.1)
(check-equal? (percentual-if-check 13000) 0.2)
(check-equal? (percentual-if-check 18000) 0.3)