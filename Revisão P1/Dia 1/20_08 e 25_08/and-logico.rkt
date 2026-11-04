;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#lang racket 
(require rackunit)
;#reader(lib "htdp-beginner-reader.ss" "lang")((modname and-logico) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (and-logico a b)
  (if (equal? a #t)
      #t
      b))

(and-logico #f #f)
(and-logico #f #t)
(and-logico #t #f)
(and-logico #t #t)

(define (and-logico2 a b)
  (if (equal? a #t)
    #t
    b))

(check-equal? (and-logico2 #f #f) #f)
(check-equal? (and-logico2 #t #t) #t)
(check-equal? (and-logico2 #t #f) #t)
(check-equal? (and-logico2 #f #t) #t)