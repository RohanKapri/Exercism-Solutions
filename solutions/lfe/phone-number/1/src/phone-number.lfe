(defmodule phone-number
  (export (clean 1)))

(defun digit? (c)
  (and (>= c #\0)
       (=< c #\9)))

(defun valid-char? (c)
  (or (digit? c)
      (=:= c 32)      ; space
      (=:= c #\-)
      (=:= c #\.)
      (=:= c #\()
      (=:= c #\))
      (=:= c #\+)))

(defun extract-digits
  (((cons h t) acc)
   (cond
     ((digit? h)
      (extract-digits t (cons h acc)))
     ((valid-char? h)
      (extract-digits t acc))
     ('true
      'invalid)))
  ((() acc)
   (lists:reverse acc)))

(defun clean (input)
  (let ((digits (extract-digits input '())))
    (case digits
      ('invalid
       'false)
      (_
       (let ((number
              (cond
                ((and (=:= (length digits) 11)
                      (=:= (car digits) #\1))
                 (cdr digits))
                ((=:= (length digits) 10)
                 digits)
                ('true
                 'invalid))))
         (case number
           ('invalid
            'false)
           (_
            (let ((area (car number))
                  (exchange (lists:nth 4 number)))
              (if (or (< area #\2)
                      (< exchange #\2))
                  'false
                  number)))))))))