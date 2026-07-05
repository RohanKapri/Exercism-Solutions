(defmodule flower-field
  (export (annotate 1))
  (compile (inline (get-cell 3) (is-flower 1) (char-to-digit 1))))

(defun annotate (board)
  (cond
    ((== board '()) '())
    ((== board '("")) '(""))
    ('true (annotate-board-fast board))))

(defun annotate-board-fast (board)
  (let* ((rows (length board))
         (cols (cond ((> rows 0) (length (car board)))
                     ('true 0)))
         
         (board-tuple (list_to_tuple 
                        (lists:map 
                          (lambda (row) (list_to_tuple row))
                          board))))
    (lists:map
      (lambda (r)
        (process-row board-tuple r rows cols))
      (lists:seq 0 (- rows 1)))))

(defun process-row (board-tuple row-idx rows cols)
  (lists:map
    (lambda (col-idx)
      (process-cell board-tuple row-idx col-idx rows cols))
    (lists:seq 0 (- cols 1))))

(defun process-cell (board-tuple row col rows cols)
  (let ((cell (get-cell board-tuple row col)))
    (cond
      ((is-flower cell) #\*)
      ('true 
       (let ((count (count-adjacent board-tuple row col rows cols)))
         (cond
           ((== count 0) 32)
           ('true (char-to-digit count))))))))

;; Inline helper functions
(defun get-cell (board-tuple row col)
  (element (+ col 1) (element (+ row 1) board-tuple)))

(defun is-flower (cell)
  (== cell #\*))

(defun char-to-digit (n)
  (+ 48 n))

(defun count-adjacent (board-tuple row col rows cols)
  (let ((check (lambda (r c acc)
                 (cond
                   ;; Out of bounds
                   ((orelse (< r 0) (>= r rows) (< c 0) (>= c cols)) 
                    acc)
                   ;; Check if flower
                   ('true
                    (cond
                      ((is-flower (get-cell board-tuple r c))
                       (+ acc 1))
                      ('true acc)))))))
    ;; Unroll all 8 neighbor checks
    (funcall check (- row 1) (- col 1)
      (funcall check (- row 1) col
        (funcall check (- row 1) (+ col 1)
          (funcall check row (- col 1)
            (funcall check row (+ col 1)
              (funcall check (+ row 1) (- col 1)
                (funcall check (+ row 1) col
                  (funcall check (+ row 1) (+ col 1) 0))))))))))