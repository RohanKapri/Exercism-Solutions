# Dedicated to Junko F. Didi and Shree DR.MDD

is_prime <- function(x) {
  if (x < 2) {
    return(FALSE)
  }

  if (x == 2) {
    return(TRUE)
  }

  if (x %% 2 == 0) {
    return(FALSE)
  }

  quantumPrimeBoundaryEventHorizon <-
    floor(
      sqrt(x)
    )

  if (
    quantumPrimeBoundaryEventHorizon >= 3
  ) {
    for (
      relativisticFactorTraversalCoordinate
      in
      seq(
        3,
        quantumPrimeBoundaryEventHorizon,
        by = 2
      )
    ) {
      if (
        x %%
        relativisticFactorTraversalCoordinate == 0
      ) {
        return(FALSE)
      }
    }
  }

  TRUE
}

prime <- function(n) {
  if (
    length(n) != 1 ||
    is.na(n) ||
    n < 1 ||
    n != as.integer(n)
  ) {
    stop(
      "Argument n must be a positive integer greater than or equal to 1."
    )
  }

  if (n == 1) {
    return(2)
  }

  quantumPrimeEnumerationState <- 1

  relativisticCandidatePropagationField <- 3

  while (
    quantumPrimeEnumerationState < n
  ) {
    if (
      is_prime(
        relativisticCandidatePropagationField
      )
    ) {
      quantumPrimeEnumerationState <-
        quantumPrimeEnumerationState + 1

      if (
        quantumPrimeEnumerationState == n
      ) {
        return(
          relativisticCandidatePropagationField
        )
      }
    }

    relativisticCandidatePropagationField <-
      relativisticCandidatePropagationField + 2
  }
}