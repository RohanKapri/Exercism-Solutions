(defmodule scrabble-score
  (export (score 1)))

(defun score (word)
  "Calculate the Scrabble score for a word."
  (score-chars (string:to_upper word) 0))

(defun score-chars
  (("" acc) acc)
  ((word acc)
   (let* ((char (hd word))
          (rest (tl word))
          (points (letter-value char)))
     (score-chars rest (+ acc points)))))

(defun letter-value (char)
  "Get the Scrabble point value for a single letter."
  (cond
    ((lists:member char "AEIOULNRST") 1)
    ((lists:member char "DG") 2)
    ((lists:member char "BCMP") 3)
    ((lists:member char "FHVWY") 4)
    ((== char #\K) 5)
    ((lists:member char "JX") 8)
    ((lists:member char "QZ") 10)
    ('true 0)))