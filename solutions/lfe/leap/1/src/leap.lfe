(defmodule leap
  (export (leap-year 1)))

(defun leap-year (year)
  (cond
    ((=:= (rem year 400) 0) 'true)
    ((=:= (rem year 100) 0) 'false)
    ((=:= (rem year 4) 0) 'true)
    ('true 'false)))
 