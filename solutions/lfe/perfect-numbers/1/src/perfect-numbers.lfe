(defmodule perfect-numbers
  (export (classify 1)))

(defun classify (n)
  (cond
    ((=< n 0) 'false)
    ('true (let ((aliquot-sum (aliquot-sum n)))
             (cond
               ((== aliquot-sum n) 'perfect)
               ((> aliquot-sum n) 'abundant)
               ('true 'deficient))))))

(defun aliquot-sum (n)
  (aliquot-sum-helper n 1 0))

(defun aliquot-sum-helper (n i sum)
  (cond
    ((>= i n) sum)
    ((== (rem n i) 0) (aliquot-sum-helper n (+ i 1) (+ sum i)))
    ('true (aliquot-sum-helper n (+ i 1) sum))))
 