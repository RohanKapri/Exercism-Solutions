(defmodule nucleotide-count
  (export (counts 1)))

(defun counts (dna)
  (cl:reduce
    (lambda (nucleotide acc)
      (let ((letter (list nucleotide))) ;; convert integer to string
        (case (lists:keyfind letter 1 acc)
          ((tuple nucleotide-found count)
           (lists:keystore nucleotide-found 1 acc
                           (tuple nucleotide-found (+ 1 count))))
          ('false (error "Invalid nucleotide")))))
    dna
    'initial-value
    `(#("A" 0) #("C" 0) #("G" 0) #("T" 0))))