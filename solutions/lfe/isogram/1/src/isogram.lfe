(defmodule isogram
  (export (isogram? 1)))

(defun isogram? (text)
  (let* ((lower-text (string:to_lower text))
         (letters (lists:filter 
                   (lambda (c) (and (/= c 32) (/= c 45))) 
                   lower-text)))
    (== (length letters) (length (lists:usort letters)))))
    