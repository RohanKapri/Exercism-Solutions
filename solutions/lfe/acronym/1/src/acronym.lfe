(defmodule acronym
  (export (abbreviate 1)))

(defun abbreviate (phrase)
  (let ((words (tokenize phrase)))
    (string:uppercase
      (lists:flatten
        (lists:map (lambda (word) (list (hd word))) 
                  (lists:filter (lambda (word) (> (length word) 0)) words))))))

(defun tokenize (phrase)
  ;; First replace hyphens with spaces (they are word separators)
  (let ((step1 (re:replace phrase "-" " " (list 'global (tuple 'return 'list)))))
    ;; Then remove all other punctuation except letters and spaces
    (let ((step2 (re:replace step1 "[^a-zA-Z ]" "" (list 'global (tuple 'return 'list)))))
      ;; Split on whitespace to get individual words
      (string:tokens step2 " "))))