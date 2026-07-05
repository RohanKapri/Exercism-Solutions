(defmodule series
  (export (from-string 2)))

(defun from-string
  "Extract all contiguous substrings of length slice-length from series.
  Returns a list of substrings or throws an error for invalid input."
  ((slice-length series) (when (=< slice-length 0))
   (error 'invalid-slice-length))
  ((slice-length series) (when (== series ""))
   (error 'empty-series))
  ((slice-length series) (when (> slice-length (length series)))
   (error 'slice-too-large))
  ((slice-length series)
   (extract-slices slice-length series 1 (- (+ (length series) 1) slice-length))))

(defun extract-slices
  "Recursively extract slices from the series string.
  Args: slice-length, series, start-position, remaining-count"
  ((_slice-length _series _start 0)
   '())
  ((slice-length series start count)
   (cons (string:substr series start slice-length)
         (extract-slices slice-length series (+ start 1) (- count 1)))))
     