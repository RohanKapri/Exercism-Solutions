(defmodule hamming
  (export (distance 2)))

(defun distance (strand1 strand2)
  (if (=/= (length strand1) (length strand2))
      (error 'different_lengths)
      (hamming-distance strand1 strand2 0)))

(defun hamming-distance (strand1 strand2 count)
  (case (list strand1 strand2)
    ((list () ()) count)
    ((list (cons c1 rest1) (cons c2 rest2))
     (if (== c1 c2)
         (hamming-distance rest1 rest2 count)
         (hamming-distance rest1 rest2 (+ count 1))))))