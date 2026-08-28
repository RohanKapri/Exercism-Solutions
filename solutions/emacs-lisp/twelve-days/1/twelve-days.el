;;; twelve-days.el --- Twelve Days (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defconst twelve-days--nouns
  [nil
   "and a Partridge in a Pear Tree."
   "two Turtle Doves,"
   "three French Hens,"
   "four Calling Birds,"
   "five Gold Rings,"
   "six Geese-a-Laying,"
   "seven Swans-a-Swimming,"
   "eight Maids-a-Milking,"
   "nine Ladies Dancing,"
   "ten Lords-a-Leaping,"
   "eleven Pipers Piping,"
   "twelve Drummers Drumming,"])

(defconst twelve-days--nums-th
  [nil
   "first"
   "second"
   "third"
   "fourth"
   "fifth"
   "sixth"
   "seventh"
   "eighth"
   "ninth"
   "tenth"
   "eleventh"
   "twelfth"])

(defun recite (m n)
  (let ((res nil)
        (gifts nil)
        (i 1))
    (while (<= i n)
      (push (aref twelve-days--nouns i) gifts)
      (when (>= i m)
        (push
         (format
          "On the %s day of Christmas my true love gave to me: %s"
          (aref twelve-days--nums-th i)
          (if (= i 1)
              "a Partridge in a Pear Tree."
            (string-join gifts " ")))
         res))
      (cl-incf i))
    (nreverse res)))

(provide 'twelve-days)
;;; twelve-days.el ends here