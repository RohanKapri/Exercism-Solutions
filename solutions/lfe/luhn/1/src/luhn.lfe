(defmodule luhn
  (export (valid? 1)))

;; =============================================================================
;; Constants
;; =============================================================================

(defun ascii-digit-0 () 48)    ; ASCII value of '0'
(defun ascii-digit-9 () 57)    ; ASCII value of '9'
(defun ascii-space () 32)      ; ASCII value of space
(defun luhn-modulus () 10)     ; Modulus for Luhn checksum
(defun digit-subtractor () 9)  ; Value to subtract when doubled digit > 9

;; =============================================================================
;; Public API
;; =============================================================================

(defun valid? (input)
  "Determine whether a number is valid according to the Luhn formula.
   
   The input is provided as a string. Strings of length 1 or less are invalid.
   Spaces are allowed and stripped, but all other non-digit characters are disallowed.
   
   Examples:
   - (valid? \"4539 3195 0343 6467\") => true (valid credit card)
   - (valid? \"059\") => true (simple valid number)
   - (valid? \"1\") => false (too short)
   - (valid? \"059a\") => false (contains non-digit)"
  (cond
    ;; Guard: input must be a list (string)
    ((not (is_list input)) 'false)
    ;; Guard: empty input is invalid
    ((== input '()) 'false)
    ;; Process the input
    ('true (process-input input))))

;; =============================================================================
;; Input Processing and Validation
;; =============================================================================

(defun process-input (input)
  "Process and validate input string, then apply Luhn algorithm."
  (case (parse-and-validate input)
    ('invalid 'false)
    ((tuple 'valid digits) (apply-luhn-algorithm digits))))

(defun parse-and-validate (input)
  "Parse input string, strip spaces, validate format, and convert to digit list.
   Returns: {valid, [digits]} | invalid"
  (let ((cleaned (strip-spaces input)))
    (cond
      ;; Too short after cleaning
      ((=< (length cleaned) 1) 'invalid)
      ;; Contains non-digit characters
      ((not (all-digits? cleaned)) 'invalid)
      ;; Valid - convert to digit list
      ('true (tuple 'valid (chars-to-digits cleaned))))))

(defun strip-spaces (str)
  "Remove all space characters from string."
  (lists:filter (lambda (c) (/= c (ascii-space))) str))

(defun all-digits? (str)
  "Check if all characters in string are digits (0-9)."
  (lists:all (lambda (c) 
               (andalso (>= c (ascii-digit-0)) 
                        (=< c (ascii-digit-9)))) str))

(defun chars-to-digits (chars)
  "Convert list of digit characters to list of integers."
  (lists:map (lambda (c) (- c (ascii-digit-0))) chars))

;; =============================================================================
;; Luhn Algorithm Implementation
;; =============================================================================

(defun apply-luhn-algorithm (digits)
  "Apply the Luhn algorithm to a list of digits.
   
   Algorithm:
   1. Start from the rightmost digit
   2. Double every second digit from right to left
   3. If doubled digit > 9, subtract 9
   4. Sum all digits
   5. Check if sum is divisible by 10"
  (let ((sum (luhn-sum (lists:reverse digits) 1)))
    (== 0 (rem sum (luhn-modulus)))))

(defun luhn-sum (digits position)
  "Calculate Luhn sum by processing digits from right to left.
   
   Args:
   - digits: List of digits (already reversed)
   - position: Current position (1-indexed from right)"
  (case digits
    ('() 0)
    ((cons digit rest)
     (let ((processed-digit (if (even-position? position)
                                (double-and-adjust digit)
                                digit)))
       (+ processed-digit (luhn-sum rest (+ position 1)))))))

(defun even-position? (position)
  "Check if position is even (for doubling every second digit)."
  (== 0 (rem position 2)))

(defun double-and-adjust (digit)
  "Double a digit and subtract 9 if result > 9.
   
   This is equivalent to: if (doubled > 9) then (doubled - 9) else doubled
   But can be optimized since we know the input is a single digit (0-9)."
  (let ((doubled (* digit 2)))
    (if (> doubled (digit-subtractor))
        (- doubled (digit-subtractor))
        doubled)))
                  