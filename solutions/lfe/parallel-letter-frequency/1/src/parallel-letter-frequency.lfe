(defmodule parallel-letter-frequency
  (export (frequency 2)
          (do-work 1)
          (dict 1)))

(defun frequency
  (((cons h t) dict)
   (let ((char
          (cond
            ;; A-Z -> a-z
            ((andalso (>= h #\A)
                      (=< h #\Z))
             (+ h 32))
            ;; a-z
            ((andalso (>= h #\a)
                      (=< h #\z))
             h)
            ;; ignore everything else
            ('true
             'ignore))))
     (case char
       ('ignore
        (frequency t dict))
       (_
        (frequency
         t
         (dict:update_counter char 1 dict))))))
  ((() dict)
   dict))

(defun do-work
  ((dict)
   dict))

(defun dict
  ((strings)
   (lists:foldl
    (lambda (string acc)
      (frequency string acc))
    (dict:new)
    strings)))