;;; line-up.el --- Line Up (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun ticket (name number)
  (let ((suffix
         (if (member (mod number 100) '(11 12 13))
             "th"
           (cl-case (mod number 10)
             (1 "st")
             (2 "nd")
             (3 "rd")
             (otherwise "th")))))
    (format "%s, you are the %d%s customer we serve today. Thank you!"
               name number suffix)))


(provide 'line-up)
;;; line-up.el ends here
