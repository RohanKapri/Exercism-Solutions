(defmodule clock
  (export (create 2)
          (equal? 2)
          (minutes-add 2)
          (minutes-delete 2)
          (to-string 1)))

;; Create a clock with given hours and minutes
;; Validates that hours are 0-23 and minutes are 0-59
(defun create (hours minutes)
  (if (or (< hours 0) (>= hours 24) (< minutes 0) (>= minutes 60))
      (error 'function_clause)
      `#(,hours ,minutes)))

;; Convert clock to string format "HH:MM"
(defun to-string (clock)
  (let ((`#(,hours ,minutes) clock))
    (++ (pad-zero hours) ":" (pad-zero minutes))))

;; Helper function to pad single digits with leading zero
(defun pad-zero (n)
  (if (< n 10)
      (++ "0" (integer_to_list n))
      (integer_to_list n)))

;; Check if two clocks represent the same time
(defun equal? (clock1 clock2)
  (=:= clock1 clock2))

;; Add minutes to a clock, handling day overflow
(defun minutes-add (clock minutes-to-add)
  (let ((`#(,hours ,minutes) clock))
    (let* ((total-minutes (+ (* hours 60) minutes minutes-to-add))
           (normalized-minutes (rem total-minutes (* 24 60)))
           (final-minutes (if (< normalized-minutes 0)
                              (+ normalized-minutes (* 24 60))
                              normalized-minutes))
           (new-hours (div final-minutes 60))
           (new-minutes (rem final-minutes 60)))
      `#(,new-hours ,new-minutes))))

;; Subtract minutes from a clock, handling day underflow
(defun minutes-delete (clock minutes-to-delete)
  (minutes-add clock (- minutes-to-delete)))
          