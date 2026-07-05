(defmodule grade-school
  (export (add 3)
          (get 2)
          (new 0)
          (sort 1)))

;; Create a new empty school roster
(defun new ()
  '())

;; Add a student to a grade in the school roster
(defun add (student grade school)
  (case (lists:keyfind grade 1 school)
    ('false
     ;; Grade doesn't exist, create new entry
     (cons `#(,grade (,student)) school))
    (`#(,grade ,students)
     ;; Grade exists, check if student is already in the grade
     (case (lists:member student students)
       ('true school)  ;; Student already exists, return unchanged
       ('false
        ;; Add student to existing grade
        (lists:keyreplace grade 1 school `#(,grade ,(cons student students))))))))

;; Get all students in a specific grade
(defun get (grade school)
  (case (lists:keyfind grade 1 school)
    ('false '())  ;; Grade doesn't exist, return empty list
    (`#(,grade ,students) students)))

;; Sort the school roster by grade, with students sorted alphabetically within each grade
(defun sort (school)
  (let ((sorted-school (lists:keysort 1 school)))
    (lists:map
      (lambda (grade-entry)
        (let ((`#(,grade ,students) grade-entry))
          `#(,grade ,(lists:sort students))))
      sorted-school)))
    