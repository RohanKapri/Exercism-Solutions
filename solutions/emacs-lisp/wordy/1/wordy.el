;;; wordy.el --- Wordy (exercism)  -*- lexical-binding: t; -*-

(require 'cl-lib)

(define-error 'parse-error
              "Invalid questoin.")

(defun answer (question)
  (let ((len-1 (1- (length question))))
    (unless (string= (substring question 0 8) "What is ")
      (signal 'parse-error '("The qustion does not start correctly.")))
    (unless (= (aref question len-1) ??)
      (signal 'parse-error '("The question does not end with a question mark.")))
    (let ((tokens (split-string (substring question 8 len-1))))
      (cl-flet ((get-integer ()
                  (if (and tokens
                           (string-match-p "^[+-]?[[:digit:]]+$" (car tokens)))
                      (string-to-number (pop tokens))
                    (signal 'parse-error
                            '("A nonnumeric word is given where a number is expected."))))
                (get-operator ()
                  (pcase (pop tokens)
                    ("plus" #'+)
                    ("minus" #'-)
                    ("multiplied"
                     (if (and tokens
                              (string= (pop tokens) "by"))
                         #'*
                       (signal 'parse-error
                               '("Multiplied is not accompanied by 'by'."))))
                    ("divided"
                     (if (and tokens
                              (string= (pop tokens) "by"))
                         #'/
                       (signal 'parse-error
                               '("Divided is not accompanied by 'by'."))))
                    (_ (signal 'parse-error
                               '("An unexpected word is given where an operation word is expected."))))))
        ;; The first token must be a number.
        (let ((value (get-integer)))
          (while tokens
            (setf value (funcall (get-operator) value (get-integer))))
          value)))))
    (provide 'wordy)

;;; wordy.el ends here