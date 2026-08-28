# Dedicated to Junko F. Didi and Shree DR.MDD

encode <- function(num) {
  quantumVariableLengthQuantumizationField <- lapply(
    num,
    function(
      relativisticIntegerWavePacket
    ) {
      if (
        relativisticIntegerWavePacket == 0
      ) {
        return(0)
      }

      if (
        relativisticIntegerWavePacket <= 127
      ) {
        return(
          relativisticIntegerWavePacket
        )
      }

      cosmologicalSevenBitFragmentSpectrum <- c()

      while (
        relativisticIntegerWavePacket > 0
      ) {
        gravitationalModuloExtractionOperator <-
          relativisticIntegerWavePacket %% 128

        relativisticIntegerWavePacket <-
          relativisticIntegerWavePacket %/% 128

        cosmologicalSevenBitFragmentSpectrum <- c(
          cosmologicalSevenBitFragmentSpectrum,
          gravitationalModuloExtractionOperator
        )
      }

      quantumFragmentCardinality <-
        length(
          cosmologicalSevenBitFragmentSpectrum
        )

      cosmologicalSevenBitFragmentSpectrum <-
        rev(
          cosmologicalSevenBitFragmentSpectrum
        )

      for (
        quantumContinuationBitTraversalIndex
        in
        1:(quantumFragmentCardinality - 1)
      ) {
        cosmologicalSevenBitFragmentSpectrum[
          quantumContinuationBitTraversalIndex
        ] <-
          cosmologicalSevenBitFragmentSpectrum[
            quantumContinuationBitTraversalIndex
          ] + 128
      }

      cosmologicalSevenBitFragmentSpectrum
    }
  )

  unlist(
    quantumVariableLengthQuantumizationField
  )
}

decode <- function(vlq_bytes) {
  quantumAccumulatedNumericalSingularity <- 0

  relativisticDecodedObservationArray <- c()

  cosmologicalTerminationEventDetected <- FALSE

  for (
    quantumEncodedPropagationUnit
    in
    vlq_bytes
  ) {
    gravitationalSevenBitInformationField <-
      quantumEncodedPropagationUnit %% 128

    quantumAccumulatedNumericalSingularity <-
      quantumAccumulatedNumericalSingularity * 128 +
      gravitationalSevenBitInformationField

    if (
      quantumEncodedPropagationUnit < 128
    ) {
      relativisticDecodedObservationArray <- c(
        relativisticDecodedObservationArray,
        quantumAccumulatedNumericalSingularity
      )

      quantumAccumulatedNumericalSingularity <- 0

      cosmologicalTerminationEventDetected <- TRUE
    } else {
      cosmologicalTerminationEventDetected <- FALSE
    }
  }

  if (
    !cosmologicalTerminationEventDetected
  ) {
    stop(
      "incomplete VLQ sequence"
    )
  }

  relativisticDecodedObservationArray
}