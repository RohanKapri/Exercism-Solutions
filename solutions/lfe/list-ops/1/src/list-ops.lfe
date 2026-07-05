(defmodule list-ops
  (export (append 2) 
          (concat 1) 
          (filter 2)
          (length 1)
          (map 2)
          (foldl 3)
          (foldr 3)
          (reverse 1))
  (compile (no_auto_import (length 1))))

;; append - add all items in the second list to the end of the first list
(defun append
  (('() lst2) lst2)
  (((cons h t) lst2) (cons h (list-ops:append t lst2))))

;; concat - combine all items in all lists into one flattened list
(defun concat
  (('()) '())
  (((cons h t)) (list-ops:append h (list-ops:concat t))))

;; filter - return list of items for which predicate returns true
(defun filter
  (('() _pred) '())
  (((cons h t) pred) 
   (if (funcall pred h)
       (cons h (list-ops:filter t pred))
       (list-ops:filter t pred))))

;; length - return total number of items in list
(defun length
  (('()) 0)
  (((cons _h t)) (+ 1 (list-ops:length t))))

;; map - return list of results of applying function to all items
(defun map
  (('() _func) '())
  (((cons h t) func) (cons (funcall func h) (list-ops:map t func))))

;; foldl - fold (reduce) each item into accumulator from the left
(defun foldl
  (('() acc _func) acc)
  (((cons h t) acc func) (list-ops:foldl t (funcall func acc h) func)))

;; foldr - fold (reduce) each item into accumulator from the right
(defun foldr
  (('() acc _func) acc)
  (((cons h t) acc func) (funcall func (list-ops:foldr t acc func) h)))

;; reverse - return list with all original items in reversed order
(defun reverse
  (('()) '())
  ((lst) (reverse-helper lst '())))

;; Helper function for reverse using accumulator
(defun reverse-helper
  (('() acc) acc)
  (((cons h t) acc) (reverse-helper t (cons h acc))))