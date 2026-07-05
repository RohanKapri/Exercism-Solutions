(defmodule allergies
  (export (allergies 1)
          (allergic-to? 2)))

;;; --------------------------
;;; Internal helpers
;;; --------------------------

(defun allergen-value
  (('eggs)         1)
  (('peanuts)      2)
  (('shellfish)    4)
  (('strawberries) 8)
  (('tomatoes)     16)
  (('chocolate)    32)
  (('pollen)       64)
  (('cats)         128)
  ;; Unknown allergen names get value 0 so they never match:
  ((_)             0))

(defun mask8
  "Keep only the low 8 bits; ignore any higher-bit allergens."
  ((score) (band score 255)))

;;; --------------------------
;;; Public API
;;; --------------------------

(defun allergic-to?
  "Return true/false if score indicates an allergy to the given Allergen."
  ((allergen score)
   (let* ((masked (mask8 score))
          (val    (allergen-value allergen)))
     (/= 0 (band masked val)))))

(defun allergies
  "Return the ordered list of allergens represented in score
   (limited to the 8 known allergens)."
  ((score)
   (let* ((masked (mask8 score))
          (all-allergens '(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)))
     ;; Filter allergens whose bit is set using lists:filter
     (lists:filter (lambda (allergen)
                     (/= 0 (band masked (allergen-value allergen))))
                   all-allergens))))
   