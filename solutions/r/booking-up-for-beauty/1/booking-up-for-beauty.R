library(lubridate)
schedule_appointment <- function(appointment) {
  lubridate::mdy_hms(appointment, tz = "UTC")
}
has_passed <- function(appointment) {
  appointment < lubridate::now(tzone = "UTC")
}
is_afternoon_appointment <- function(appointment) {
  hr <- lubridate::hour(appointment)
  hr >= 12 && hr < 18
}
day_of_week <- function(appointment) {
  lubridate::wday(appointment, week_start = 1)
}
reschedule <- function(appointment) {
  dt <- schedule_appointment(appointment)
  current_day <- day_of_week(dt)
  
  days_to_add <- if (current_day < 5) {
    5 - current_day       # Reschedule to Friday of this week
  } else {
    (5 - current_day) + 7 # Reschedule to Friday of next week
  }
  dt + lubridate::days(days_to_add)
}