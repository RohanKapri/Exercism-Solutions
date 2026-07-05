(defmodule resistor-color-trio
  (export (label 1)))

;; Metric prefix constants
(defmacro KILO () 1000)
(defmacro MEGA () 1000000)
(defmacro GIGA () 1000000000)

(defmacro POWERS-OF-10 ()
  #(1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000))

(defun color-code (color)
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

(defun power-of-10 (n)
  (element (+ n 1) (POWERS-OF-10)))

(defun label
  "Calculate resistor value and return formatted label."
  (((cons c1 (cons c2 (cons c3 _))))
   (let* ((first (color-code c1))
          (second (color-code c2))
          (third (color-code c3))
          (base-value (+ (* first 10) second))
          (multiplier (power-of-10 third))
          (ohms (* base-value multiplier)))
     (format-with-prefix ohms))))

(defun format-with-prefix (ohms)
  "Format ohms with appropriate metric prefix."
  (cond
    ;; Gigaohms (10^9)
    ((andalso (>= ohms (GIGA)) (== (rem ohms (GIGA)) 0))
     (++ (integer_to_list (div ohms (GIGA))) " gigaohms"))
    ;; Megaohms (10^6)
    ((andalso (>= ohms (MEGA)) (== (rem ohms (MEGA)) 0))
     (++ (integer_to_list (div ohms (MEGA))) " megaohms"))
    ;; Kiloohms (10^3)
    ((andalso (>= ohms (KILO)) (== (rem ohms (KILO)) 0))
     (++ (integer_to_list (div ohms (KILO))) " kiloohms"))
    ;; Plain ohms
    ('true
     (++ (integer_to_list ohms) " ohms"))))
                