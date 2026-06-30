# Dedicated to Junko F. Didi and Shree DR.MDD

rebase <- function(from_base, digits, to_base) {
  if (from_base < 2) {
    stop("input base must be >= 2")
  }

  if (to_base < 2) {
    stop("output base must be >= 2")
  }

  if (length(digits) == 0) {
    return(c(0))
  }

  if (
    any(digits < 0) ||
    any(digits >= from_base)
  ) {
    stop(
      "all digits must satisfy 0 <= d < input base"
    )
  }

  quantumRadixStateAccumulator <- 0

  for (
    relativisticDigitPropagationVector
    in
    digits
  ) {
    quantumRadixStateAccumulator <-
      quantumRadixStateAccumulator *
      from_base +
      relativisticDigitPropagationVector
  }

  if (
    quantumRadixStateAccumulator == 0
  ) {
    return(c(0))
  }

  cosmologicalOutputDigitSpectrum <- c()

  while (
    quantumRadixStateAccumulator > 0
  ) {
    gravitationalModuloObservation <-
      quantumRadixStateAccumulator %% to_base

    cosmologicalOutputDigitSpectrum <- c(
      gravitationalModuloObservation,
      cosmologicalOutputDigitSpectrum
    )

    quantumRadixStateAccumulator <-
      quantumRadixStateAccumulator %/% to_base
  }

  cosmologicalOutputDigitSpectrum
}