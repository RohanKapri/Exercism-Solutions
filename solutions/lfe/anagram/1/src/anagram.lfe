(defmodule anagram
  (export (find 2)))

(defun find (target candidates)
  (lists:filter 
    (lambda (candidate) (is-anagram? target candidate))
    candidates))

(defun is-anagram? (target candidate)
  (let ((target-norm (normalize target))
        (candidate-norm (normalize candidate)))
    (and (=/= target-norm candidate-norm)
         (=:= (lists:sort target-norm) (lists:sort candidate-norm)))))

(defun normalize (word)
  (lists:map 
    (lambda (char)
      (if (and (>= char 65) (=< char 90))   
          (+ char 32)                       ; convert to lowercase
          char))
    word))