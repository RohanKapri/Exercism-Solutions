(defmodule rotational-cipher
  (export (rotate 2)))

(defun rotate (text key)
  "Rotate text by key positions using Caesar cipher"
  (lists:map
    (lambda (char)
      (cond
        ;; Lowercase letters a-z (97-122)
        ((and (>= char 97) (=< char 122))
         (+ 97 (rem (+ (- char 97) key) 26)))
        ;; Uppercase letters A-Z (65-90)
        ((and (>= char 65) (=< char 90))
         (+ 65 (rem (+ (- char 65) key) 26)))
        ;; Non-alphabetic characters remain unchanged
        ('true char)))
    text))
   