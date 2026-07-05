(defmodule matching-brackets
  (export (paired? 1)))

(defun paired? (string)
  "Check if brackets, braces, and parentheses are properly paired and nested.
   Uses a fold-based approach with expected closing bracket tracking."
  (== '() (lists:foldl #'check-char/2 '() string)))

(defun check-char
  "Process each character, maintaining a stack of expected closing brackets.
   Opening brackets push their corresponding closing bracket onto the stack.
   Closing brackets must match the top of the stack to be valid."
  ;; Opening brackets: push expected closing bracket onto stack
  ((#\( stack) (cons #\) stack))
  ((#\[ stack) (cons #\] stack))
  ((#\{ stack) (cons #\} stack))
  
  ;; Closing brackets: must match expected bracket at top of stack
  ((#\) (cons #\) tail)) tail)
  ((#\] (cons #\] tail)) tail)
  ((#\} (cons #\} tail)) tail)
  
  ;; Unmatched closing brackets: poison the stack with error marker
  ((#\) _) '(unmatched))
  ((#\] _) '(unmatched))
  ((#\} _) '(unmatched))
  
  ;; Non-bracket characters: ignore by returning stack unchanged
  ((_ stack) stack))
            