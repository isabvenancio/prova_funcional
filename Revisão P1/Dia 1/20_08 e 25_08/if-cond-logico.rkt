;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.

#lang racket
(require rackunit)
;; #reader(lib "htdp-beginner-reader.ss" "lang")((modname e-logico) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (e-logico-cond a b)
  (cond
    [(equal? a #f) #f]
    [else b]))

(define (e-logico-if a b)
  (if (equal? a #f)
      #f
      b))

(e-logico-cond #t #t)
(e-logico-cond #t #f)
(e-logico-cond #f #t)
(e-logico-cond #f #f)

(e-logico-if #t #t)
(e-logico-if #t #f)
(e-logico-if #f #t)
(e-logico-if #f #f)


(define (cond-logico a b)
    (cond
        [(equal? a #f) #f]
        [else b]))

(define (if-logico a b)
    (if (equal? a #f)
        #f
        b))

(check-equal? (cond-logico #t #t) #t)
(check-equal? (cond-logico #t #f) #f)
(check-equal? (cond-logico #f #t) #f)
(check-equal? (cond-logico #f #f) #f)

(check-equal? (if-logico #t #t) #t)
(check-equal? (if-logico #t #f) #f)
(check-equal? (if-logico #f #t) #f)
(check-equal? (if-logico #f #f) #f)
