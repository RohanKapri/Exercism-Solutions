(defmodule game-of-life
  (export (tick 1)))

;; Main entry point
(defun tick (matrix)
  (case matrix
    ('() '())
    (_ (let* ((rows (length matrix))
              (cols (length (car matrix)))
              (tup (matrix-to-tuple matrix)))
         (tick-with-tuple tup rows cols)))))

;; Convert list-of-lists to nested tuples
(defun matrix-to-tuple (matrix)
  (list_to_tuple (lists:map #'list_to_tuple/1 matrix)))

;; Process the grid using nested tuples
(defun tick-with-tuple (tup rows cols)
  (list-comp ((<- row (lists:seq 0 (- rows 1))))
    (list-comp ((<- col (lists:seq 0 (- cols 1))))
      (next-state-tuple tup row col rows cols))))

;; cell access from nested tuples
(defun get-cell-tuple (tup row col rows cols)
  (if (and (>= row 0) (< row rows) (>= col 0) (< col cols))
    (element (+ col 1) (element (+ row 1) tup))
    0))

;; Count neighbors using tuple lookup
(defun count-neighbors-tuple (tup row col rows cols)
  (+ (get-cell-tuple tup (- row 1) (- col 1) rows cols)
     (get-cell-tuple tup (- row 1) col rows cols)
     (get-cell-tuple tup (- row 1) (+ col 1) rows cols)
     (get-cell-tuple tup row (- col 1) rows cols)
     (get-cell-tuple tup row (+ col 1) rows cols)
     (get-cell-tuple tup (+ row 1) (- col 1) rows cols)
     (get-cell-tuple tup (+ row 1) col rows cols)
     (get-cell-tuple tup (+ row 1) (+ col 1) rows cols)))

;; Compute next state using tuple access
(defun next-state-tuple (tup row col rows cols)
  (let ((current (get-cell-tuple tup row col rows cols))
        (neighbors (count-neighbors-tuple tup row col rows cols)))
    (cond
      ((and (== current 1) (or (== neighbors 2) (== neighbors 3))) 1)
      ((and (== current 0) (== neighbors 3)) 1)
      ('true 0))))