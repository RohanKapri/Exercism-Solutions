#lang racket

(provide slices)

(define (slices series slice-length)
  (define len (string-length series))
  (cond
    [(<= slice-length 0)
     (error "slice length must be positive")]
    [(> slice-length len)
     (error "slice length cannot be greater than series length")]
    [else
     (for/list ([i (in-range 0 (add1 (- len slice-length)))])
       (substring series i (+ i slice-length)))]))