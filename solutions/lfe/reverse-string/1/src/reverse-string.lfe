(defmodule reverse
    (export (string 1)))

(defun string (str)
  "Reverse a string by manually reversing the list of characters"
  (reverse-helper str '()))

(defun reverse-helper
  ;; Base case: empty list returns the accumulator
  (('() acc) acc)
  ;; Recursive case: move head to accumulator and process tail
  (((cons head tail) acc)
   (reverse-helper tail (cons head acc))))