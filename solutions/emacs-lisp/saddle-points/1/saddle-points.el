;;; saddle-points.el --- Saddle Points (exercism)  -*- lexical-binding: t; -*-
(require 'cl-lib)

(defun make-matrix (matrix)
  (vconcat (mapcar #'vconcat matrix)))

(defun aref2d (arr i j)
  (aref (aref arr i) j))

(defun every (pred seq)
  (seq-reduce (lambda (a x) (and a (funcall pred x)))
              seq t))

(defun saddle-points (matrix)
  (let* ((matrix (make-matrix matrix))
         (m (length matrix))
         (n (length (aref matrix 0)))
         (m-1 (1- m))
         (n-1 (1- n))
         (saddle-points '())
         (i m-1))
    (while (>= i 0)
      (let ((j n-1))
        (while (>= j 0)
          (let ((matrix-i-j (aref2d matrix i j)))
            (when (and (every (lambda (k) (>= matrix-i-j (aref2d matrix i k)))
                              (number-sequence 0 n-1))
                       (every (lambda (k) (<= matrix-i-j (aref2d matrix k j)))
                              (number-sequence 0 m-1)))
              (push (cons (1+ i) (1+ j)) saddle-points))
            (cl-decf j))))
      (cl-decf i))
    saddle-points))


(provide 'saddle-points)
;;; saddle-points.el ends here
