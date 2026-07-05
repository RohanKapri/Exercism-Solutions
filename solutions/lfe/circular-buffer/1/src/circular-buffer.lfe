(defmodule circular-buffer
  (export (create 1)
          (read 1)
          (size 1)
          (write 2)
          (write-attempt 2)))

;; State: #(capacity current-size read-pos write-pos buffer)
;; buffer is a tuple of size capacity

(defun create (capacity)
  "Create a circular buffer process with given capacity"
  (spawn (lambda () (buffer-loop capacity 0 0 0 (make-tuple capacity)))))

(defun read (pid)
  "Read the oldest value from the buffer"
  (call-buffer pid 'read))

(defun size (pid)
  "Get the current size of the buffer"
  (call-buffer pid 'size))

(defun write (pid value)
  "Write a value to the buffer, overwriting oldest if full"
  (call-buffer pid (tuple 'write value)))

(defun write-attempt (pid value)
  "Attempt to write a value, fail if buffer is full"
  (call-buffer pid (tuple 'write-attempt value)))

;; Helper function to make synchronous calls to the buffer process
(defun call-buffer (pid message)
  (! pid (tuple (self) message))
  (receive
    (response response)))

;; Helper function to create a tuple of given size filled with 'undefined
(defun make-tuple (size)
  (make-tuple-helper size 'undefined '()))

(defun make-tuple-helper
  ((0 _ acc)
   (list_to_tuple acc))
  ((size fill acc)
   (make-tuple-helper (- size 1) fill (cons fill acc))))

;; Main buffer process loop
(defun buffer-loop (capacity current-size read-pos write-pos buffer)
  (receive
    ((tuple from 'read)
     (if (== current-size 0)
         (progn
           (! from (tuple 'error 'empty))
           (buffer-loop capacity current-size read-pos write-pos buffer))
         (let* ((value (element (+ read-pos 1) buffer))
                (new-read-pos (rem (+ read-pos 1) capacity))
                (new-size (- current-size 1)))
           (! from (tuple 'ok value))
           (buffer-loop capacity new-size new-read-pos write-pos buffer))))
    
    ((tuple from 'size)
     (! from (tuple 'ok capacity))
     (buffer-loop capacity current-size read-pos write-pos buffer))
    
    ((tuple from (tuple 'write value))
     (if (< current-size capacity)
         ;; Buffer not full, just add the value
         (let* ((new-buffer (setelement (+ write-pos 1) buffer value))
                (new-write-pos (rem (+ write-pos 1) capacity))
                (new-size (+ current-size 1)))
           (! from 'ok)
           (buffer-loop capacity new-size read-pos new-write-pos new-buffer))
         ;; Buffer is full, overwrite oldest value
         (let* ((new-buffer (setelement (+ write-pos 1) buffer value))
                (new-write-pos (rem (+ write-pos 1) capacity))
                (new-read-pos (rem (+ read-pos 1) capacity)))
           (! from 'ok)
           (buffer-loop capacity current-size new-read-pos new-write-pos new-buffer))))
    
    ((tuple from (tuple 'write-attempt value))
     (if (< current-size capacity)
         ;; Buffer not full, add the value
         (let* ((new-buffer (setelement (+ write-pos 1) buffer value))
                (new-write-pos (rem (+ write-pos 1) capacity))
                (new-size (+ current-size 1)))
           (! from 'ok)
           (buffer-loop capacity new-size read-pos new-write-pos new-buffer))
         ;; Buffer is full, return error
         (progn
           (! from (tuple 'error 'full))
           (buffer-loop capacity current-size read-pos write-pos buffer))))))
   