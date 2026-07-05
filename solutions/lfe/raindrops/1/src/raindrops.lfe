(defmodule raindrops
    (export (convert 1)))

(defun convert (n)
  (let ((sounds (++ (if (== 0 (rem n 3)) "Pling" "")
                    (if (== 0 (rem n 5)) "Plang" "")
                    (if (== 0 (rem n 7)) "Plong" ""))))
    (if (== sounds "")
        (integer_to_list n)
        sounds)))