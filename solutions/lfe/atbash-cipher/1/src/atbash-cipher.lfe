(defmodule atbash-cipher
  (export (encode 1)
          (decode 1)
          (dbg 2)
          (chunk-every 2)
          ))


(defun dbg (label value)
  (io:format "~s: ~p~n" (list label value))
  value)
; Please implement the exported function(s).

(defun encode (str)
  (let ((chunks (chunk-every  (transcode str) 5)))
    (lists:flatten (lists:join " " chunks))))

(defun decode (str) (transcode str))

(defun transcode (str) (lists:filtermap #'cipher/1 str))

(defun cipher
  ([char] (when (=< #\A char) (=< char #\Z))
   `#(true ,(- #\Z (- char #\a))))
  ([char] (when (=< #\a char) (=< char #\z))
   `#(true ,(- #\z (- char #\a))))
  ([char] (when (=< #\0 char) (=< char #\9))
   `#(true ,char))
  ([_char]
   'false))


(defun chunk-every (lst count)
  (chunk-every-helper lst count []))
(defun chunk-every-helper (lst count acc)
  (if (< (length lst) count)
      (if (== lst [])
          (lists:reverse acc)
          (lists:reverse (cons lst acc)))
      (let* (((tuple chunk rest) (lists:split count lst)))
        (chunk-every-helper rest count (cons chunk acc)))))