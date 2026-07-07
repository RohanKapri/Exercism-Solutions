
success_rate <- function(speed) {
  if (speed == 0) {
    0.0
  } else if (speed >= 1 && speed <= 4) {
    1.0
  } else if (speed >= 5 && speed <= 8) {
    0.9
  } else if (speed == 9) {
    0.8
  } else {
    0.77
  }
}

production_rate_per_hour <- function(speed) {
  base_rate_per_speed <- 221
  raw_production <- speed * base_rate_per_speed
  
  raw_production * success_rate(speed)
}

working_items_per_minute <- function(speed) {
  hourly_working_production <- production_rate_per_hour(speed)

  hourly_working_production %/% 60
}