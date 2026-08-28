;;; rational-numbers.el --- Rational Numbers (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'cl-lib)

(defun reducerational (r)
  (when (cl-minusp (cdr r))
    (setf r (cons (- (car r)) (- (cdr r)))))
  (let ((common-factor (cl-gcd (car r) (cdr r))))
    (cons (floor (car r) common-factor)
          (floor (cdr r) common-factor))))

(defun add (r1 r2)
  (reducerational
   (cons
    (+ (* (car r1) (cdr r2)) (* (cdr r1) (car r2)))
    (* (cdr r1) (cdr r2)))))

(defun sub (r1 r2)
  (add r1 (cons (- (car r2)) (cdr r2))))

(defun mul (r1 r2)
  (reducerational
   (cons
    (* (car r1) (car r2))
    (* (cdr r1) (cdr r2)))))

(defun div (r1 r2)
  (mul r1 (cons (cdr r2) (car r2))))

(defun absrational (r)
  (reducerational
   (cons
    (abs (car r))
    (abs (cdr r)))))

(defun exprational (r n)
  (when (cl-minusp n)
    (setf n (- n))
    (setf r (cons (cdr r) (car r))))
  (let ((result '(1 . 1)))
    (while (cl-plusp n)
      (when (= (logand n 1) 1)
        (setf result (mul result r)))
      (setf r (mul r r))
      (setf n (ash n -1)))
    result))

(defun expreal (x r)
  (expt (expt x (car r)) (/ 1.0 (cdr r))))


(provide 'rational-numbers)
;;; rational-numbers.el ends here