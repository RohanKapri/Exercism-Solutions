(defmodule two-fer
  (export (two-fer 1)))

(defun two-fer (name)
  (if (== name "")
    "One for you, one for me."
    (++ "One for " name ", one for me.")))