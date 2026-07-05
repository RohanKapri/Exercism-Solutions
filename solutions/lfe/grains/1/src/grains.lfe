(defmodule grains
  (export (square 1)
          (total 0)))

(defun square (n)
  (bsl 1 (- n 1)))

(defun total ()
  (- (bsl 1 64) 1))