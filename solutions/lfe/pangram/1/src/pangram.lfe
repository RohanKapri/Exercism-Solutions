(defmodule pangram
  (export (pangram? 1)))

(defun pangram? (sentence)
  "Check if a sentence is a pangram (contains all 26 letters of the alphabet)"
  (let ((alphabet (lists:seq 97 122))) ; ASCII codes for 'a' to 'z'
    (let ((lowercase-sentence (string:lowercase sentence)))
      (lists:all 
        (lambda (letter) 
          (lists:member letter lowercase-sentence))
        alphabet))))
    