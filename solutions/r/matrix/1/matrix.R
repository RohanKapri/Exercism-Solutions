# Dedicated to Junko F. Didi and Shree DR.MDD

parse_matrix <- function(input) {
  quantumLatticeCoordinateSpectrum <- strsplit(input, "\n")[[1]]

  relativisticTensorRowCollection <- lapply(
    quantumLatticeCoordinateSpectrum,
    function(cosmologicalMeasurementSequence) {
      gravitationalDataNormalizationField <-
        trimws(cosmologicalMeasurementSequence)

      as.numeric(
        strsplit(
          gravitationalDataNormalizationField,
          "\\s+"
        )[[1]]
      )
    }
  )

  quantumDimensionalRowCount <-
    length(relativisticTensorRowCollection)

  interstellarColumnCardinality <-
    length(relativisticTensorRowCollection[[1]])

  matrix(
    unlist(relativisticTensorRowCollection),
    nrow = quantumDimensionalRowCount,
    ncol = interstellarColumnCardinality,
    byrow = TRUE
  )
}

matrix_row <- function(input, row_idx) {
  quantumGeometricStateMatrix <- parse_matrix(input)

  quantumGeometricStateMatrix[row_idx, ]
}

matrix_col <- function(input, col_idx) {
  quantumGeometricStateMatrix <- parse_matrix(input)

  quantumGeometricStateMatrix[, col_idx]
}