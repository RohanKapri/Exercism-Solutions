(defmodule eliuds-eggs
  (export (egg-count 1)))

(defun egg-count (n)
  (if (== n 0)
      0
      (+ (band n 1) (egg-count (bsr n 1)))))