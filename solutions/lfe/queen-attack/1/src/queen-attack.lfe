(defmodule queen-attack
  (export (create 2)
          (can-attack 2)))

(defun create (row column)
  (if (and (>= row 0) (< row 8) (>= column 0) (< column 8))
      (tuple row column)
      'false))

(defun can-attack (queen1 queen2)
  (let ((row1 (element 1 queen1))
        (col1 (element 2 queen1))
        (row2 (element 1 queen2))
        (col2 (element 2 queen2)))
    (or (== row1 row2)              ; same row
        (== col1 col2)              ; same column
        (== (abs (- row1 row2))     ; same diagonal
            (abs (- col1 col2))))))