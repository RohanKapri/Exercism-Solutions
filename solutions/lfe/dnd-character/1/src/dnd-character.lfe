(defmodule dnd-character
  (export (new-character 0)
          (ability 0)
          (modifier 1)
          (get-strength 1)
          (get-dexterity 1)
          (get-constitution 1)
          (get-intelligence 1)
          (get-wisdom 1)
          (get-charisma 1)
          (get-hitpoints 1)))

;; Calculate ability modifier from ability score
;; Subtract 10, divide by 2, and round down
(defun modifier (score)
  (floor (/ (- score 10) 2)))

;; Generate a random ability score by rolling 4 dice and summing the 3 highest
(defun ability ()
  (let* ((dice (list (rand:uniform 6)
                     (rand:uniform 6)
                     (rand:uniform 6)
                     (rand:uniform 6)))
         (sorted (lists:sort dice))
         (top-three (lists:nthtail 1 sorted)))
    (lists:sum top-three)))

;; Create a new character with all abilities generated
(defun new-character ()
  (let ((strength (ability))
        (dexterity (ability))
        (constitution (ability))
        (intelligence (ability))
        (wisdom (ability))
        (charisma (ability)))
    (tuple strength dexterity constitution intelligence wisdom charisma)))

;; Getter functions for character abilities
(defun get-strength (char)
  (element 1 char))

(defun get-dexterity (char)
  (element 2 char))

(defun get-constitution (char)
  (element 3 char))

(defun get-intelligence (char)
  (element 4 char))

(defun get-wisdom (char)
  (element 5 char))

(defun get-charisma (char)
  (element 6 char))

;; Calculate hitpoints: 10 + constitution modifier
(defun get-hitpoints (char)
  (+ 10 (modifier (get-constitution char))))