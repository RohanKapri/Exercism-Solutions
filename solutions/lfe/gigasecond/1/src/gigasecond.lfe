(defmodule gigasecond
  (export (from 1)))

(defun from (input)
  (let* ((datetime (case input
                     ; Handle date-only input - default time to 00:00:00
                     ((tuple year month day)
                      (tuple (tuple year month day) (tuple 0 0 0)))
                     ; Handle datetime input
                     ((tuple (tuple year month day) (tuple hour minute second))
                      (tuple (tuple year month day) (tuple hour minute second)))))
         (seconds (calendar:datetime_to_gregorian_seconds datetime))
         (gigasecond 1000000000)
         (new-seconds (+ seconds gigasecond)))
    (calendar:gregorian_seconds_to_datetime new-seconds)))