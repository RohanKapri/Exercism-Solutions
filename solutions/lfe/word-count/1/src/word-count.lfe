(defmodule word-count
  (export (count 1)))

(defun count (string)
  "Count word occurrences in a string, returning a dict."
  (let* ((lowercase (string:lowercase string))
         (words (extract-words lowercase)))
    (count-words words (dict:new))))

(defun extract-words (string)
  "Extract words from a string, handling apostrophes in contractions."
  (let ((normalized (normalize-string string)))
    (lists:filter
      (lambda (word) (not (is-empty? word)))
      (string:tokens normalized " "))))

(defun normalize-string (string)
  "Replace punctuation (except apostrophes in contractions) with spaces."
  (lists:foldl
    (lambda (char acc)
      (cond
        ;; Keep alphanumeric characters
        ((is-alphanumeric? char) (++ acc (list char)))
        ;; Keep apostrophes that are part of contractions (not at edges)
        ((== char #\') (++ acc (list char)))
        ;; Replace all other characters with spaces
        ('true (++ acc " "))))
    ""
    string))

(defun is-alphanumeric? (char)
  "Check if a character is alphanumeric."
  (or (and (>= char #\a) (=< char #\z))
      (and (>= char #\A) (=< char #\Z))
      (and (>= char #\0) (=< char #\9))))

(defun is-empty? (string)
  "Check if a string is empty."
  (== string ""))

(defun count-words (words dict)
  "Count words and build a dict."
  (lists:foldl
    (lambda (word acc)
      (let ((cleaned (clean-word word)))
        (if (not (is-empty? cleaned))
          (dict:update cleaned
                      (lambda (count) (+ count 1))
                      1
                      acc)
          acc)))
    dict
    words))

(defun clean-word (word)
  "Remove leading and trailing apostrophes from a word."
  (strip-apostrophes word))

(defun strip-apostrophes (word)
  "Strip leading and trailing apostrophes from a word."
  (strip-trailing-apostrophe (strip-leading-apostrophe word)))

(defun strip-leading-apostrophe (word)
  "Remove leading apostrophes."
  (case word
    ('() "")
    ("" "")
    (_ (case (lists:nth 1 word)
         (#\' (strip-leading-apostrophe (lists:nthtail 1 word)))
         (_ word)))))

(defun strip-trailing-apostrophe (word)
  "Remove trailing apostrophes."
  (case word
    ('() "")
    ("" "")
    (_ (case (lists:last word)
         (#\' (strip-trailing-apostrophe (lists:droplast word)))
         (_ word)))))
    