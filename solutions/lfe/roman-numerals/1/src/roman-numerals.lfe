(defmodule roman-numerals
  (export (roman 1)))

(defun roman (n)
  "Convert an Arabic numeral to Roman numeral.
   Input: Integer from 1 to 3999
   Output: String representing the Roman numeral"
  (cond
    ((or (< n 1) (> n 3999))
     (error 'badarg))
    ('true
     (let ((roman-values '((1000 "M") (900 "CM") (500 "D") (400 "CD") 
                           (100 "C") (90 "XC") (50 "L") (40 "XL") 
                           (10 "X") (9 "IX") (5 "V") (4 "IV") (1 "I"))))
       (roman-helper n roman-values "")))))

(defun roman-helper
  "Recursive helper function"
  ((0 _ acc) acc)
  ((n '() acc) acc)  ; Safety clause
  ((n values acc)
   (let* ((current-pair (car values))
          (num-value (car current-pair))
          (roman-symbol (cadr current-pair)))
     (cond
       ((>= n num-value)
        ;; Use this symbol and continue with same values
        (roman-helper (- n num-value) 
                      values 
                      (++ acc roman-symbol)))
       ('true
        ;; Skip to next value
        (roman-helper n (cdr values) acc))))))
    