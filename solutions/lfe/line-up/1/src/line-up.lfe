(defmodule line-up
  (export (format 2)))

(defun ordinal-suffix (n)
  "Return the ordinal suffix for a number."
  (let ((last-two (rem n 100))
        (last-one (rem n 10)))
    (cond
      ;; Special cases for 11, 12, 13
      ((and (>= last-two 11) (=< last-two 13)) "th")
      ;; Numbers ending in 1 -> "st"
      ((== last-one 1) "st")
      ;; Numbers ending in 2 -> "nd"
      ((== last-one 2) "nd")
      ;; Numbers ending in 3 -> "rd"
      ((== last-one 3) "rd")
      ;; Everything else -> "th"
      ('true "th"))))

(defun format (name number)
  "Format a customer name and number into an ordinal sentence."
  (++ name ", you are the " 
      (integer_to_list number)
      (ordinal-suffix number)
      " customer we serve today. Thank you!"))
    