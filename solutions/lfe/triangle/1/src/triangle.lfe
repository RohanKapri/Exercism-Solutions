(defmodule triangle
  (export (kind 3)))

(defun kind (a b c)
  "Determine if a triangle is equilateral, isosceles, or scalene"
  (cond
    ;; Check if it's a valid triangle first
    ((not (is-valid-triangle a b c)) 'false)
    ;; Check for equilateral (all three sides equal)
    ((and (== a b) (== b c)) 'equilateral)
    ;; Check for isosceles (at least two sides equal)
    ((or (== a b) (== b c) (== a c)) 'isosceles)
    ;; Otherwise it's scalene (all sides different)
    ('true 'scalene)))

(defun is-valid-triangle (a b c)
  "Check if three sides can form a valid triangle"
  (and
    ;; All sides must be positive
    (> a 0) (> b 0) (> c 0)
    ;; Triangle inequality: sum of any two sides > third side
    (> (+ a b) c)
    (> (+ b c) a)
    (> (+ a c) b)))