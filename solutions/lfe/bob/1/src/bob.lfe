(defmodule bob
  (export (response-for 1)))

(defun response-for (input)
  (let ((trimmed (string:trim input)))
    (cond
      ; Check for silence (empty after trimming)
      ((== (length trimmed) 0) "Fine. Be that way!")
      ; Check for yelling question
      ((and (is-question? trimmed) (is-yelling? input))
       "Calm down, I know what I'm doing!")
      ; Check for just yelling
      ((is-yelling? input) "Whoa, chill out!")
      ; Check for just a question
      ((is-question? trimmed) "Sure.")
      ; Everything else
      ('true "Whatever."))))

(defun is-question? (text)
  (case text
    ("" 'false)
    (_  (== (lists:last text) #\?))))

(defun is-yelling? (text)
  (let ((has-letters (has-letters? text))
        (all-upper (== text (string:to_upper text))))
    (and has-letters all-upper)))

(defun has-letters? (text)
  (lists:any (lambda (c) 
               (or (and (>= c #\a) (=< c #\z))
                   (and (>= c #\A) (=< c #\Z))))
             text))