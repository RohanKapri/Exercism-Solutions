(defmodule darts
  (export (score 2)))

(defun score (x y)
  (let ((distance (math:sqrt (+ (* x x) (* y y)))))
    (cond 
      ((=< distance 1) 10)
      ((=< distance 5) 5)
      ((=< distance 10) 1)
      ('true 0))))
 