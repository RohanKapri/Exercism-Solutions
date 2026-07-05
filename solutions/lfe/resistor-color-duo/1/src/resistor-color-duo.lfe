(defmodule resistor-color-duo
  (export (value 1)))

(defun color-to-number (color)
  (case color
    ("black" 0)
    ("brown" 1)
    ("red" 2)
    ("orange" 3)
    ("yellow" 4)
    ("green" 5)
    ("blue" 6)
    ("violet" 7)
    ("grey" 8)
    ("white" 9)))

(defun value (colors)
  (let* ((first-color (car colors))
         (second-color (cadr colors))
         (first-digit (color-to-number first-color))
         (second-digit (color-to-number second-color)))
    (+ (* first-digit 10) second-digit)))
    