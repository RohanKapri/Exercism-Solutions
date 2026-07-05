(defmodule sum-of-multiples
  (export (sum-of-multiples 2)))

(defun sum-of-multiples (factors limit)
  "Calculate the sum of unique multiples of factors below limit"
  (if (or (== factors ()) (=< limit 1))
      0
      (let ((multiples (get-all-multiples factors limit)))
        (lists:sum (remove-duplicates multiples)))))

(defun get-all-multiples (factors limit)
  "Get all multiples of all factors below limit"
  (lists:append 
    (lists:map 
      (lambda (factor) (get-multiples-for-factor factor limit))
      factors)))

(defun get-multiples-for-factor (factor limit)
  "Get all multiples of a single factor below limit"
  (if (or (== factor 0) (=< limit 1))
      ()
      (get-multiples-for-factor factor limit 1 ())))

(defun get-multiples-for-factor (factor limit multiplier acc)
  "Helper function to build list of multiples"
  (let ((multiple (* factor multiplier)))
    (if (>= multiple limit)
        acc
        (get-multiples-for-factor factor limit (+ multiplier 1) (cons multiple acc)))))

(defun remove-duplicates (lst)
  "Remove duplicates from a list"
  (lists:usort lst))
           