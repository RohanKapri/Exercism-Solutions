(defmodule yacht
  (export (score 2)
          (count-value 2)
          (get-counts 1)
          (is-yacht? 1)
          (is-little-straight? 1)
          (is-big-straight? 1)
          (is-full-house? 1)
          (is-four-of-a-kind? 1)
          (get-four-of-a-kind-value 1)
          (get-value-with-count 2)))

;; Helper function to count occurrences of a value in a list
(defun count-value (value dice)
  (length (lists:filter (lambda (x) (=:= x value)) dice)))

;; Helper function to get counts of all dice values
(defun get-counts (dice)
  (lists:map (lambda (value) (count-value value dice)) '(1 2 3 4 5 6)))

;; Helper function to check if all dice are the same (Yacht)
(defun is-yacht? (dice)
  (let ((first-die (car dice)))
    (lists:all (lambda (die) (=:= die first-die)) dice)))

;; Helper function to check if dice form a little straight (1-2-3-4-5)
(defun is-little-straight? (dice)
  (let ((sorted-dice (lists:sort dice)))
    (=:= sorted-dice '(1 2 3 4 5))))

;; Helper function to check if dice form a big straight (2-3-4-5-6)
(defun is-big-straight? (dice)
  (let ((sorted-dice (lists:sort dice)))
    (=:= sorted-dice '(2 3 4 5 6))))

;; Helper function to check if dice form a full house (three of one, two of another)
(defun is-full-house? (dice)
  (let ((counts (get-counts dice)))
    (andalso (lists:member 3 counts)
             (lists:member 2 counts))))

;; Helper function to check if dice have four of a kind
(defun is-four-of-a-kind? (dice)
  (let ((counts (get-counts dice)))
    (or (lists:member 4 counts)
        (lists:member 5 counts))))

;; Helper function to get the value that appears four or more times
(defun get-four-of-a-kind-value (dice)
  (let ((counts (get-counts dice)))
    (cond
      ((lists:member 5 counts) (get-value-with-count dice 5))
      ((lists:member 4 counts) (get-value-with-count dice 4))
      ('true 0))))

;; Helper function to get the value that appears exactly count times
(defun get-value-with-count (dice count)
  (let ((values '(1 2 3 4 5 6)))
    (lists:foldl (lambda (value acc)
                    (if (=:= (count-value value dice) count)
                        value
                        acc))
                  0 values)))

;; Main scoring function
(defun score (dice category)
  (case category
    ('ones (* 1 (count-value 1 dice)))
    ('twos (* 2 (count-value 2 dice)))
    ('threes (* 3 (count-value 3 dice)))
    ('fours (* 4 (count-value 4 dice)))
    ('fives (* 5 (count-value 5 dice)))
    ('sixes (* 6 (count-value 6 dice)))
    ('full-house (if (is-full-house? dice)
                     (lists:sum dice)
                     0))
    ('four-of-a-kind (if (is-four-of-a-kind? dice)
                         (* 4 (get-four-of-a-kind-value dice))
                         0))
    ('little-straight (if (is-little-straight? dice)
                          30
                          0))
    ('big-straight (if (is-big-straight? dice)
                       30
                       0))
    ('choice (lists:sum dice))
    ('yacht (if (is-yacht? dice)
                50
                0))))
   