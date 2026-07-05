(defmodule resistor-color
  (export (color-code 1)
          (colors 0)))

;; Ordered list of resistor colors (indexes map directly to codes).
(defun colors ()
  (list "black"
        "brown"
        "red"
        "orange"
        "yellow"
        "green"
        "blue"
        "violet"
        "grey"
        "white"))

;; Look up the numeric code for a given color.
(defun color-code (Color)
  (let ((Pairs (lists:zip (colors) (lists:seq 0 9))))
    (proplists:get_value Color Pairs)))