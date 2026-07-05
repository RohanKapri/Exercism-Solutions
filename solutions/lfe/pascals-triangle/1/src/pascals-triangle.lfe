(defmodule pascals-triangle
  (export (rows 1) (row 1) (coefficient 2)))

(defun rows (n)
  "Generate the first n rows of Pascal's triangle using functional approach"
  (cond
    ((=< n 0) '())
    ('true (lists:map #'row/1 (lists:seq 1 n)))))

(defun row
  "Generate a specific row of Pascal's triangle (1-indexed)"
  ((1) '(1))
  ((n) (generate-row-from-previous (row (- n 1)))))

(defun generate-row-from-previous (prev-row)
  "Generate next row values by summing adjacent pairs from padded previous row"
  (let ((padded-row (lists:append '(0) (lists:append prev-row '(0)))))
    (lists:map #'sum-pair/1 (consecutive-pairs padded-row))))

(defun consecutive-pairs (row)
  "Generate consecutive pairs from a list using sliding window"
  (cond
    ((or (== row '()) (== (cdr row) '())) '())
    ('true (cons (list (car row) (car (cdr row)))
                 (consecutive-pairs (cdr row))))))

(defun sum-pair (pair)
  "Sum the elements in a pair - more efficient than lists:sum for pairs"
  (+ (car pair) (car (cdr pair))))

(defun coefficient (n k)
  "Calculate binomial coefficient C(n,k) = n! / (k! * (n-k)!)
   This is the value at position k in row (n+1) of Pascal's triangle"
  (cond
    ((or (< k 0) (> k n)) 0)
    ((or (== k 0) (== k n)) 1)
    ('true (let ((k-adj (if (> k (- n k)) (- n k) k)))  ; Use symmetry for efficiency
             (factorial-ratio n k-adj)))))

(defun factorial-ratio (n k)
  "Calculate n! / k! / (n-k)! efficiently without computing full factorials"
  (lists:foldl (lambda (i acc) (/ (* acc (+ n 1 (- i))) i))
               1
               (lists:seq 1 k)))
    