(defmodule kindergarten-garden
  (export (plants 2)))

(defun plants (diagram student)
  "Determine which plants belong to a student based on the garden diagram.
   Each student gets 4 plants: 2 from the first row and 2 from the second row."
  (let* ((rows (parse-diagram diagram))
         (student-pos (student-position student))
         (plant-indices (get-plant-positions student-pos))
         (student-plants (extract-student-plants rows plant-indices)))
    (lists:map #'plant-name/1 student-plants)))

(defun parse-diagram (diagram)
  "Parse the garden diagram into two rows of plant codes."
  (let ((token-list (string:tokens diagram "\n")))
    (case (length token-list)
      (2 token-list)
      (_ (error "Invalid diagram format")))))

(defun student-position (student)
  "Get the zero-based position of a student in alphabetical order.
   Uses case-insensitive matching for robustness."
  (let ((normalized-name (string:to_lower student)))
    (case normalized-name
      ("alice" 0)   ("bob" 1)     ("charlie" 2)  ("david" 3)
      ("eve" 4)     ("fred" 5)    ("ginny" 6)    ("harriet" 7)
      ("ileana" 8)  ("joseph" 9)  ("kincaid" 10) ("larry" 11)
      (_ (error (lists:append "Unknown student: " student))))))

(defun get-plant-positions (student-pos)
  "Calculate the 1-based indices for a student's plants in each row."
  (let ((start-idx (+ (* student-pos 2) 1)))
    (list start-idx (+ start-idx 1))))

(defun extract-student-plants (rows plant-indices)
  "Extract the plant codes for a student from both rows."
  (let* ((row1 (car rows))
         (row2 (cadr rows))
         (idx1 (car plant-indices))
         (idx2 (cadr plant-indices))
         (first-row-plants (list (lists:nth idx1 row1) (lists:nth idx2 row1)))
         (second-row-plants (list (lists:nth idx1 row2) (lists:nth idx2 row2))))
    (lists:append first-row-plants second-row-plants)))

(defun plant-name (plant-code)
  "Convert a single-character plant code to its full name."
  (case plant-code
    (#\R "radishes")
    (#\C "clover") 
    (#\G "grass")
    (#\V "violets")
    (_ (error (lists:append "Unknown plant code: " (list plant-code))))))
        