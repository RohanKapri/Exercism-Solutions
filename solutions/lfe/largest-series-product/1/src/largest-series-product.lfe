(defmodule largest-series-product
  (export (from-string 2)))

(defun char-to-digit
  "Convert a character to its digit value, error if not a digit"
  ((char)
   (if (and (>= char 48) (=< char 57))
     (- char 48)
     (error "Invalid character in digits"))))

(defun prod
  "Calculate product of a list of numbers"
  ((list)
   (lists:foldl (lambda (x prod) (* x prod)) 1 list)))

(defun windows
  "Generate sliding windows of specified size from a list"
  ((list 0) '(()))  ; Special case: empty window
  ((list size)
   (if (< (length list) size) 
     '()  ; No windows possible
     (lists:map (lambda (start) 
                  (lists:sublist list (+ start 1) size)) 
                (lists:seq 0 (- (length list) size))))))

(defun from-string
  "Find the largest product of adjacent digits in a string with given span length"
  ((digits span)
   (cond
     ; Handle negative span
     ((< span 0)
      (error "Span cannot be negative"))
     
     ; Handle empty product (span = 0)
     ((== span 0) 1)
     
     ; Handle empty string with non-zero span
     ((and (== digits "") (> span 0))
      (error "Cannot have empty string with non-zero span"))
     
     ; Handle span longer than string length
     ((> span (length digits))
      (error "Span cannot be longer than string length"))
     
     ; Main logic
     ('true
      (let* ((digit-list (lists:map #'char-to-digit/1 digits))
             (window-list (windows digit-list span)))
        (if (== window-list '())
          0  ; Safe fallback (shouldn't happen with validation)
          (lists:max (lists:map #'prod/1 window-list))))))))
             