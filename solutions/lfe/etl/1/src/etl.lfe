(defmodule etl
  (export (transform 1)))

;;; ETL (Extract-Transform-Load) module for Lexiconia game
;;; 
;;; Transforms score-to-letters mappings into letter-to-score mappings
;;; with automatic letter case normalization and score aggregation.

(defun transform (old)
  "Transform score-to-letters mappings into normalized letter-to-score mappings.
   
   Input: List of tuples in format #(score [letters...]) or #(letter [score])
   Output: Sorted list of tuples with appropriate grouping and formatting
   
   The core algorithm uses maps to automatically handle grouping and concatenation."
  (let ((score-map (build-score-map old)))
    (lists:sort (maps:to_list score-map))))

(defun build-score-map (old)
  "Build a map from lowercase letters to their scores/values.
   
   Uses efficient fold operation with maps for O(log n) performance."
  (lists:foldl #'process-entry/2 #m() old))

(defun process-entry
  "Process a single entry, extracting key-value pairs for the map."
  (((tuple value keys) acc)
   (lists:foldl 
     (lambda (key acc) 
       (add-key-value key value acc)) 
     acc 
     keys)))

(defun add-key-value (key value acc)
  "Add a key-value pair to the accumulator map.
   
   Handles the core ETL logic:
   - Normalizes keys to lowercase  
   - Concatenates values for duplicate keys (enables automatic grouping)
   - Uses string operations for proper formatting"
  (let* ((lower-key (string:to_lower key))
         (existing-value (maps:get lower-key acc ""))
         (new-value (if (=:= existing-value "")
                        value
                        (++ existing-value value))))
    (maps:put lower-key new-value acc)))
        