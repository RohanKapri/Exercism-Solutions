(defpackage :line-up
  (:use :cl)
  (:shadow format)
  (:export :format))

(in-package :line-up)

(defun ordinal (n)
  (let ((suffix (cond ((<= 10 (mod n 100) 19) "th")
                      (t (case (mod n 10)
                           (1 "st")
                           (2 "nd")
                           (3 "rd")
                           (otherwise "th")))) ))
    (cl:format nil "~D~A" n suffix)))

(defun format (name number)
  (cl:format nil "~A, you are the ~A customer we serve today. Thank you!" name (ordinal number)))