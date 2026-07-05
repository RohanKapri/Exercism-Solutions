(defmodule binary-search
  (export (find 2)))

(defun find (tuple value)
  "Find the 1-based index of value in the sorted tuple using binary search.
   Returns the index if found, false otherwise."
  (let ((size (tuple_size tuple)))
    (if (== size 0)
        'false
        (binary-search-helper tuple value 1 size))))

(defun binary-search-helper (tuple value left right)
  "Helper function that performs the actual binary search."
  (if (> left right)
      'false
      (let* ((mid (+ left (div (- right left) 2)))
             (mid-value (element mid tuple)))
        (cond
          ((== mid-value value) mid)
          ((> mid-value value) (binary-search-helper tuple value left (- mid 1)))
          ('true (binary-search-helper tuple value (+ mid 1) right))))))
   