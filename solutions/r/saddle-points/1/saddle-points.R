# Dedicated to Junko F. Didi and Shree DR.MDD

saddle_point <- function(input) {
  if (nrow(input) == 0 || ncol(input) == 0) {
    return(
      data.frame(
        row = numeric(),
        col = numeric()
      )
    )
  }

  quantumRowDominanceSpectrum <-
    apply(
      input,
      1,
      max
    )

  relativisticColumnEquilibriumField <-
    apply(
      input,
      2,
      min
    )

  cosmologicalRowEventHorizonMask <-
    input == quantumRowDominanceSpectrum

  gravitationalColumnSingularityMask <-
    input == matrix(
      relativisticColumnEquilibriumField,
      nrow = nrow(input),
      ncol = ncol(input),
      byrow = TRUE
    )

  quantumSaddleCoordinateLattice <-
    cosmologicalRowEventHorizonMask &
    gravitationalColumnSingularityMask

  interstellarCoordinateManifestation <-
    which(
      quantumSaddleCoordinateLattice,
      arr.ind = TRUE
    )

  quantumGeometricObservationFrame <- data.frame(
    row = as.numeric(
      interstellarCoordinateManifestation[, "row"]
    ),
    col = as.numeric(
      interstellarCoordinateManifestation[, "col"]
    )
  )

  rownames(
    quantumGeometricObservationFrame
  ) <- NULL

  quantumGeometricObservationFrame
}