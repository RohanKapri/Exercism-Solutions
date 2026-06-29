;;; bottle-song.el --- Bottle Song (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'cl-lib)

(defconst *number-spellings*
  ["no" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"])

(defun verse (bottles)
  (let ((num-word0 (aref *number-spellings* bottles))
        (num-word1 (aref *number-spellings* (1- bottles)))
        (s0 "s")
        (s1 "s"))
    (cond
     ((= bottles 1) (setf s0 ""))
     ((= bottles 2) (setf s1 "")))
    (list (format "%s green bottle%s hanging on the wall,"
                  (capitalize num-word0) s0)
          (format "%s green bottle%s hanging on the wall,"
                  (capitalize num-word0) s0)
          "And if one green bottle should accidentally fall,"
          (format "There'll be %s green bottle%s hanging on the wall."
                  num-word1 s1))))


(defun recite (start-bottles take-down)
  "Returns the song verses from START-BOTTLES down to (1+ (- START-BOTTLES TAKE-DOWN))."
  (let* ((head (list nil))
         (tail head))
    (setf (cdr tail) (verse start-bottles)
          tail (cddddr tail))
    (let ((i 1))
      (while (< i take-down)
        (setf (cdr tail) (list "")
              tail (cdr tail)
              (cdr tail) (verse (- start-bottles i))
              tail (cddddr tail))
        (cl-incf i)))
    (cdr head)))


(provide 'bottle-song)
;;; bottle-song.el ends here
