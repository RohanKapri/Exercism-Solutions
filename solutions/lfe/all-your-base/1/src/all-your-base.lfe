(defmodule all-your-base
  (export (rebase 3)))

(defun rebase (input-base digits output-base)
  "Convert digits from input-base to output-base"
  ;; Validate bases
  (cond 
    ((< input-base 2) (error 'invalid-base))
    ((< output-base 2) (error 'invalid-base))
    ('true 'ok))
  
  ;; Remove leading zeros
  (let ((clean-digits (remove-leading-zeros digits)))
    ;; Handle empty or all-zero case
    (if (=:= clean-digits '())
        '(0)
        (progn
          ;; Validate digits are in valid range for input base
          (validate-digits clean-digits input-base)
          ;; Convert to decimal then to output base
          (let ((decimal-value (to-decimal clean-digits input-base)))
            (from-decimal decimal-value output-base))))))

(defun remove-leading-zeros (digits)
  "Remove leading zeros from a list of digits"
  (case digits
    ('() '())
    ((cons 0 rest) (remove-leading-zeros rest))
    (_ digits)))

(defun validate-digits (digits base)
  "Validate that all digits are valid for the given base"
  (lists:foreach
    (lambda (digit)
      (cond
        ((< digit 0) (error 'invalid-digit))
        ((>= digit base) (error 'invalid-digit))
        ('true 'ok)))
    digits))

(defun to-decimal (digits base)
  "Convert digits in given base to decimal"
  (to-decimal-helper digits base 0))

(defun to-decimal-helper (digits base acc)
  "Helper function for to-decimal"
  (case digits
    ('() acc)
    ((cons digit rest)
     (to-decimal-helper rest base (+ (* acc base) digit)))))

(defun from-decimal (number base)
  "Convert decimal number to digits in given base"
  (if (=:= number 0)
      '(0)
      (from-decimal-helper number base '())))

(defun from-decimal-helper (number base acc)
  "Helper function for from-decimal"
  (if (=:= number 0)
      acc
      (let ((quotient (div number base))
            (remainder (rem number base)))
        (from-decimal-helper quotient base (cons remainder acc)))))
       