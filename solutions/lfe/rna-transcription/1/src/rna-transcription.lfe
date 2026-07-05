(defmodule rna-transcription
  (export (to-rna 1)))

;; Map each DNA nucleotide to its RNA complement.
(defun complement (c)
  (cond
    ((=:= c (hd "G")) (hd "C"))
    ((=:= c (hd "C")) (hd "G"))
    ((=:= c (hd "T")) (hd "A"))
    ((=:= c (hd "A")) (hd "U"))
    ;; If an unexpected character shows up, crash with a helpful reason.
    ('true (error (tuple 'invalid_nucleotide c)))))

;; Convert a DNA string (list of codepoints) to its RNA complement.
(defun to-rna (dna)
  (lists:map #'complement/1 dna))
  