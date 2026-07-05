(defmodule strain
  (export (keep 2)
          (discard 2)))

;; keep : (A -> boolean()) -> [A] -> [A]
(defun keep (pred xs)
  (keep-acc pred xs '()))

(defun keep-acc
  ((pred '() acc)
   (lists:reverse acc))
  ((pred (cons h t) acc)
   (if (funcall pred h)
       (keep-acc pred t (cons h acc))
       (keep-acc pred t acc))))

;; discard : (A -> boolean()) -> [A] -> [A]
;; Implemented via keep, using the negated predicate.
(defun discard (pred xs)
  (keep (lambda (x) (not (funcall pred x))) xs))