(defmodule difference-of-squares
  (export (square-of-sum 1)
          (sum-of-squares 1)
          (difference-of-squares 1)))

;; square_of_sum(n) = (n(n+1)/2)^2
(defun square-of-sum (n)
  (let ((sum (div (* n (+ n 1)) 2)))
    (* sum sum)))

;; sum_of_squares(n) = n(n+1)(2n+1)/6
(defun sum-of-squares (n)
  (div
    (* (* n (+ n 1)) (+ (* 2 n) 1))
    6))

;; difference(n) = square_of_sum(n) - sum_of_squares(n)
(defun difference-of-squares (n)
  (- (square-of-sum n) (sum-of-squares n)))