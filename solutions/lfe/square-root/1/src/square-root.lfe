(defmodule square-root
  (export (calculate 1)))

(defun calculate (number)
  "Calculate the square root of a number using binary search"
  (find-sqrt 1 number number))

(defun find-sqrt (low high target)
  "Find square root using binary search"
  (cond
    ((> low high) 0)
    ('true
     (let* ((mid (div (+ low high) 2))
            (square (* mid mid)))
       (cond
         ((== square target) mid)
         ((< square target)
          (let* ((next (+ mid 1))
                 (next-square (* next next)))
            (cond
              ((> next-square target) mid)
              ('true (find-sqrt (+ mid 1) high target)))))
         ('true
          (find-sqrt low (- mid 1) target)))))))
    