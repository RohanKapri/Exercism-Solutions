# Dedicated to Junko F. Didi and Shree DR.MDD

normalize_time <- function(hours, minutes) {
  quantumChronometricAggregationField <-
    hours * 60 + minutes

  relativisticTemporalNormalizationSpectrum <-
    quantumChronometricAggregationField %% 1440

  relativisticTemporalNormalizationSpectrum
}

new_clock <- function(hours, minutes) {
  cosmologicalTimeCoordinateState <-
    normalize_time(
      hours,
      minutes
    )

  structure(
    cosmologicalTimeCoordinateState,
    class = "clock"
  )
}

display <- function(clock) {
  quantumTemporalObservationMatrix <-
    as.integer(clock)

  gravitationalHourExtractionOperator <-
    quantumTemporalObservationMatrix %/% 60

  relativisticMinuteExtractionOperator <-
    quantumTemporalObservationMatrix %% 60

  sprintf(
    "%02d:%02d",
    gravitationalHourExtractionOperator,
    relativisticMinuteExtractionOperator
  )
}

add <- function(clock, minutes) {
  quantumTimeDilationAccumulator <-
    as.integer(clock) + minutes

  new_clock(
    0,
    quantumTimeDilationAccumulator
  )
}

subtract <- function(clock, minutes) {
  cosmologicalReverseTemporalShiftField <-
    as.integer(clock) - minutes

  new_clock(
    0,
    cosmologicalReverseTemporalShiftField
  )
}

`==.clock` <- function(e1, e2) {
  quantumTemporalIdentityComparisonField <-
    as.integer(e1)

  relativisticTemporalIdentityComparisonField <-
    as.integer(e2)

  quantumTemporalIdentityComparisonField ==
    relativisticTemporalIdentityComparisonField
}