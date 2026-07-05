(defmodule armstrong-numbers
  (export (armstrong-number? 1)))

(defun armstrong-number? (n)
  (let* ((digit-string (integer_to_list n))
         (digits (lists:map (lambda (c) (- c 48)) digit-string))
         (num-digits (length digits))
         (armstrong-sum (lists:foldl 
                          (lambda (digit acc) 
                            (+ acc (trunc (math:pow digit num-digits))))
                          0 
                          digits)))
    (== armstrong-sum n)))