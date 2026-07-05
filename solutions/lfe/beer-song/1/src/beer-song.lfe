(defmodule beer-song
  (export (verse 1) (sing 1) (sing 2)))

(defun format-bottle-count
  "Format bottle count with optional capitalization"
  ((0 'true) "No more")
  ((0 'false) "no more")
  ((n _) (integer_to_list n)))

(defun format-bottle-word
  "Return singular or plural form of 'bottle'"
  ((1) "bottle")
  ((_) "bottles"))

(defun format-bottle-phrase
  "Format complete bottle phrase with capitalization control"
  ((n capitalize?)
   (let ((count (format-bottle-count n capitalize?))
         (word (format-bottle-word n)))
     (++ count " " word))))

(defun verse-components (n)
  "Extract verse components to eliminate repetition"
  (case n
    (0 
     `#(,(format-bottle-phrase 0 'true)
        ,(format-bottle-phrase 0 'false)
        "Go to the store and buy some more, 99 bottles"))
    (_ 
     `#(,(format-bottle-phrase n 'true)
        ,(format-bottle-phrase n 'false)
        ,(++ "Take it down and pass it around, " (format-bottle-phrase (- n 1) 'false))))))

(defun format-verse-template
  "Single template for all verse types"
  ((first-phrase second-phrase action-phrase)
   (io_lib:format 
     "~s of beer on the wall, ~s of beer.~n~s of beer on the wall.~n"
     (list first-phrase second-phrase action-phrase))))

(defun verse (n)
  (let* ((components (verse-components n))
         (first-phrase (element 1 components))
         (second-phrase (element 2 components))
         (action-phrase (element 3 components)))
    (format-verse-template first-phrase second-phrase action-phrase)))

(defun valid-range? (from to)
  "Centralized range validation logic"
  (and (>= from to) (>= to 0)))

(defun generate-verse-sequence (from to)
  "Generate and format verse sequence"
  (let* ((sequence (lists:seq to from))
         (reversed-seq (lists:reverse sequence))
         (verses (lists:map #'verse/1 reversed-seq)))
    (string:concat (lists:join "\n" verses) "\n")))

(defun sing 
  "Sing the complete beer song from start down to 0"
  ((start)
   (if (>= start 0)
       (sing start 0)
       "")))

(defun sing 
  "Sing verses from 'from' down to 'to' (inclusive)"
  ((from to)
   (if (valid-range? from to)
       (generate-verse-sequence from to)
       "")))
                     