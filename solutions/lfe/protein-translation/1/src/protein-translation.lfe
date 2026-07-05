(defmodule protein-translation
  (export (proteins 1)))

(defun codon->protein (codon)
  "Translate a single codon to its corresponding amino acid or STOP"
  (case codon
    ("AUG" 'Methionine)
    ("UUU" 'Phenylalanine)
    ("UUC" 'Phenylalanine)
    ("UUA" 'Leucine)
    ("UUG" 'Leucine)
    ("UCU" 'Serine)
    ("UCC" 'Serine)
    ("UCA" 'Serine)
    ("UCG" 'Serine)
    ("UAU" 'Tyrosine)
    ("UAC" 'Tyrosine)
    ("UGU" 'Cysteine)
    ("UGC" 'Cysteine)
    ("UGG" 'Tryptophan)
    ("UAA" 'STOP)
    ("UAG" 'STOP)
    ("UGA" 'STOP)
    (_ 'invalid)))

(defun proteins (rna-sequence)
  "Translate RNA sequence into proteins"
  (if (== rna-sequence "")
    (tuple 'ok '())
    (translate-sequence rna-sequence '())))

(defun translate-sequence (rna-sequence acc)
  "Translate RNA sequence into proteins, processing codon by codon"
  (cond
    ((== (length rna-sequence) 0)
     (tuple 'ok (lists:reverse acc)))
    ((< (length rna-sequence) 3)
     (tuple 'error "Invalid codon"))
    ('true
     (let ((codon (lists:sublist rna-sequence 1 3))
           (rest (lists:nthtail 3 rna-sequence)))
       (let ((protein (codon->protein codon)))
         (case protein
           ('STOP (tuple 'ok (lists:reverse acc)))
           ('invalid (tuple 'error "Invalid codon"))
           (_ (translate-sequence rest (cons protein acc)))))))))
  