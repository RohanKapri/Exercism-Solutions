;;; matrix.el --- Matrix (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun make-row (row)
  (vconcat (mapcar #'string-to-number (split-string row " "))))


(defun make-matrix (string)
  (vconcat (mapcar #'make-row (split-string string  "\n"))))

(defun row (string index)
  (aref (make-matrix string) (1- index)))


(defun column (string index)
  (let ((index-1 (1- index)))
    (vconcat (mapcar (lambda (row) (aref row index-1)) (make-matrix string)))))


(provide 'matrix)
;;; matrix.el ends here