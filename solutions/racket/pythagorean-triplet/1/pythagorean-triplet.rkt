#lang racket

(provide triplets-with-sum)

(define (triplets-with-sum p)
  (for*/list ([a (add1 p)]
              [b (add1 (- p a))]
              #:when (let ([c (- p a b)])
                       (and (< a b)
                            (< b c)
                            (= (+ (* a a) (* b b))
                               (* c c)))))
    (list a b (- p a b))))