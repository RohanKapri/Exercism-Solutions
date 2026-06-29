;;; high-scores.el --- High Scores (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'cl-lib)

(defun latest (scores)
  (car (last scores)))

(defun personal-best (scores)
  (apply #'max scores))


(defun personal-top-three (scores)
  (let ((first most-negative-fixnum)
        (second most-negative-fixnum)
        (third most-negative-fixnum)
        (count 0))
    (dolist (score scores)
      (cl-incf count)
      (cond
       ((<= score third) t)
       ((<= score second)
        (setf third score))
       ((<= score first)
        (setf third second)
        (setf second score))
       (t
        (setf third second)
        (setf second first)
        (setf first score))))
    (cl-case count
      (0 nil)
      (1 (list first))
      (2 (list first second))
      (t (list first second third)))))


(provide 'high-scores)
;;; high-scores.el ends here
