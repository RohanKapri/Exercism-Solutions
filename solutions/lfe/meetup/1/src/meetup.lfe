(defmodule meetup
  (export (schedule 4)))

(defun schedule (year month weekday descriptor)
  "Find the date of a meetup given year, month, weekday, and schedule descriptor.
   Returns a tuple {year, month, day} representing the exact meetup date."
  (let* ((days-in-month (calendar:last_day_of_the_month year month))
         (candidates (get-candidates year month weekday days-in-month))
         (day (select-day candidates descriptor)))
    (tuple year month day)))

(defun get-candidates (year month weekday days-in-month)
  "Get all days in the month that match the specified weekday."
  (let ((target-weekday (weekday-to-int weekday)))
    (lists:filter
      (lambda (day)
        (=:= (calendar:day_of_the_week year month day) target-weekday))
      (lists:seq 1 days-in-month))))

(defun select-day (candidates descriptor)
  "Select the appropriate day from candidates based on the descriptor."
  (case descriptor
    ('first  (hd candidates))
    ('second (hd (tl candidates)))
    ('third  (hd (tl (tl candidates))))
    ('fourth (hd (tl (tl (tl candidates)))))
    ('teenth (find-teenth candidates))
    ('last   (lists:last candidates))))

(defun find-teenth (candidates)
  "Find the day in the teenth range (13-19) from the candidates."
  (hd (lists:filter 
        (lambda (day) 
          (and (>= day 13) (=< day 19))) 
        candidates)))

(defun weekday-to-int (weekday)
  "Convert weekday atom to integer (Monday=1, ..., Sunday=7)."
  (case weekday
    ('monday 1)
    ('tuesday 2)
    ('wednesday 3)
    ('thursday 4)
    ('friday 5)
    ('saturday 6)
    ('sunday 7)))
               