(defmodule collatz-conjecture
  (export (steps 1)))

(defun steps (n)
  (cond 
    ((=< n 0) (error "Only positive integers are allowed"))
    ((=:= n 1) 0)
    ((=:= (rem n 2) 0) (+ 1 (steps (div n 2))))
    ('true (+ 1 (steps (+ (* n 3) 1))))))