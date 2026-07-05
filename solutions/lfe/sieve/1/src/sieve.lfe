(defmodule sieve
  (export (primes 1) (primes-optimized 1) (is-prime? 1)))

(defun primes (limit)
  "Sieve with input validation"
  (cond 
    ((not (is_integer limit)) (error 'badarg))
    ((< limit 0) (error 'badarg))
    ((< limit 2) '())
    ((=:= limit 2) '(2))
    ('true (sieve (lists:seq 2 limit)))))

(defun primes-optimized (limit)
  "Only processes up to sqrt(limit)"
  (cond 
    ((< limit 2) '())
    ((=:= limit 2) '(2))
    ('true 
     (let ((sqrt-limit (trunc (math:sqrt limit))))
       (sieve-opt (lists:seq 2 limit) sqrt-limit '())))))

(defun sieve
  (('()) '())
  (((cons prime rest))
   (cons prime (sieve (filter-multiples prime rest)))))

(defun sieve-opt
  (('() _ acc) (lists:reverse acc))
  (((cons prime rest) sqrt-limit acc)
   (if (=< prime sqrt-limit)
     (sieve-opt (filter-multiples-tail prime rest) sqrt-limit (cons prime acc))
     (lists:append (lists:reverse acc) (cons prime rest)))))

(defun filter-multiples (prime rest)
  "Original filter using lists:filter"
  (lists:filter (lambda (x) (/= (rem x prime) 0)) rest))

(defun filter-multiples-tail (prime candidates)
  "Tail-recursive filter"
  (filter-acc prime candidates '()))

(defun filter-acc
  ((_ '() acc) (lists:reverse acc))
  ((prime (cons n rest) acc)
   (if (=:= 0 (rem n prime))
     (filter-acc prime rest acc)
     (filter-acc prime rest (cons n acc)))))

(defun is-prime? (n)
  "Single number prime test"
  (cond
    ((< n 2) 'false)
    ((=:= n 2) 'true)
    ((=:= 0 (rem n 2)) 'false)
    ('true (check-divisors n 3))))

(defun check-divisors (n divisor)
  (cond
    ((> (* divisor divisor) n) 'true)
    ((=:= 0 (rem n divisor)) 'false)
    ('true (check-divisors n (+ divisor 2)))))