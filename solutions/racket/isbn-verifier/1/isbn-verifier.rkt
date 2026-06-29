#lang racket

(provide isbn?)

(define (isbn? isbn)
  (let ([ls (isbn->list isbn)]) (and (valid-len? ls) (valid-chars? ls) (valid-sum? ls))))

(define (valid-len? ls)
  (eq? 10 (length ls)))

(define (valid-chars? ls)
  (andmap char-numeric? (map second (takef ls (lambda (l) (> (car l) 1))))))

(define (valid-sum? ls)
  (= 0 (remainder (foldl + 0 (map atoi ls)) 11)))

(define (isbn->list isbn)
  (zip-index (list->string (filter-not (lambda (c) (char=? #\- c)) (string->list isbn)))))

(define (zip-index ls)
  (stream->list (for/stream ([a (in-naturals)] [b ls]) (list (- 10 a) b))))

(define (atoi c)
  (match c
    [(list 1 #\X) 10]
    [(list idx val) (* idx (- (char->integer val) (char->integer #\0)))]))