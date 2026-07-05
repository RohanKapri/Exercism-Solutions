(defmodule knapsack
  (export (maximum-value 2)))

(include-lib "include/item.lfe")

(defun maximum-value (items capacity)
  "Solve 0/1 knapsack using space-optimized DP.
   Time: O(n*W), Space: O(W) where n=items, W=capacity.
   Returns maximum value achievable."
  (cond
    ((== items '()) 0)
    ((=< capacity 0) 0)
    ('true (knapsack-dp items capacity))))

(defun knapsack-dp (items capacity)
  "Core DP implementation with 1D array."
  (let ((dp (lists:duplicate (+ capacity 1) 0)))
    (process-items items dp)))

(defun process-items
  "Process each item and update the DP array."
  (('() dp)
   (lists:last dp))
  (((cons item rest) dp)
   (let* ((weight (item-weight item))
          (value (item-value item))
          (new-dp (update-dp-array dp weight value (length dp))))
     (process-items rest new-dp))))

(defun update-dp-array (dp item-weight item-value capacity)
  "Update DP array for single item, processing right-to-left to avoid reuse."
  (update-dp-reverse dp item-weight item-value capacity (- capacity 1)))

(defun update-dp-reverse (dp item-weight item-value capacity w)
  "Process weights from right to left.
   This ensures we don't use the same item multiple times in one iteration."
  (if (< w item-weight)
    dp
    (let* ((without-item (lists:nth (+ w 1) dp))
           (with-item-prev (lists:nth (- (+ w 1) item-weight) dp))
           (with-item (+ item-value with-item-prev))
           (best-value (max without-item with-item))
           (new-dp (replace-at-index dp w best-value)))
      (update-dp-reverse new-dp item-weight item-value capacity (- w 1)))))

(defun replace-at-index (lst idx value)
  "Replace element at 0-based index with new value."
  (replace-at-index-helper lst idx value 0 '()))

(defun replace-at-index-helper
  "Helper function for replace-at-index."
  (('() _idx _value _current acc)
   (lists:reverse acc))
  (((cons head tail) idx value current acc)
   (if (== current idx)
     (replace-at-index-helper tail idx value (+ current 1) (cons value acc))
     (replace-at-index-helper tail idx value (+ current 1) (cons head acc)))))
                         