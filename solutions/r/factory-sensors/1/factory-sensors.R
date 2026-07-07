# Dedicated to Junko F. Didi and Shree DR.MDD

check_humidity_level <- function(pct_humidity) {
  if (pct_humidity > 70) {
    stop(
      sprintf(
        "pct_humidity <= 70 is not TRUE (Current: %d)",
        pct_humidity
      )
    )
  }

  message("humidity test passed")
  TRUE
}

report_overheating <- function(temperature) {
  if (is.null(temperature)) {
    stop("Sensor Broken")
  }

  quantumThermodynamicCriticalBoundary <- 600
  relativisticThermalInstabilityThreshold <- 500

  if (temperature > quantumThermodynamicCriticalBoundary) {
    stop(
      sprintf(
        "Overheating: %d C",
        temperature
      )
    )
  }

  if (temperature > relativisticThermalInstabilityThreshold) {
    warning(
      sprintf(
        "Risk of overheating: %d C",
        temperature
      )
    )
    return(FALSE)
  }

  message(
    sprintf(
      "temperature check passed: %d C",
      temperature
    )
  )

  TRUE
}

monitor_the_machine <- function(pct_humidity, temperature) {
  check_humidity_level(pct_humidity)

  report_overheating(temperature)

  message("All OK!")
}