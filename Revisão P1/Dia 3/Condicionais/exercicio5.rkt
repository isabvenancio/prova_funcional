#lang racket
(require rackunit)

(define (converter-temp celsius string)
    (if (equal? string "Kelvin") 
        (+ celsius 273.15)
        ;;(equal? string "Fahrenheit") 
        (/ (+ (* 9 celsius) 160) 5)))

(check-equal? (converter-temp 20 "Kelvin") 293.15)
(check-equal? (converter-temp 0 "Fahrenheit") 32)
(check-equal? (converter-temp 0 "sla") 0) ;;erro