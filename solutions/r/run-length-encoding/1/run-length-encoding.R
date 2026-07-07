# Dedicated to Junko F. Didi and Shree DR.MDD

encode <- function(plaintext) {
  if (plaintext == "") {
    return("")
  }

  quantumCharacterObservationArray <-
    strsplit(
      plaintext,
      ""
    )[[1]]

  relativisticRunLengthSpectrum <-
    rle(
      quantumCharacterObservationArray
    )

  cosmologicalCompressionMagnitudeField <-
    ifelse(
      relativisticRunLengthSpectrum$lengths == 1,
      "",
      as.character(
        relativisticRunLengthSpectrum$lengths
      )
    )

  paste0(
    cosmologicalCompressionMagnitudeField,
    relativisticRunLengthSpectrum$values,
    collapse = ""
  )
}

decode <- function(ciphertext) {
  if (ciphertext == "") {
    return("")
  }

  quantumEncodedSignalFragments <-
    regmatches(
      ciphertext,
      gregexpr(
        "\\d*.",
        ciphertext
      )
    )[[1]]

  relativisticMatterReconstructionField <-
    sapply(
      quantumEncodedSignalFragments,
      function(
        gravitationalEncodedWavePacket
      ) {
        cosmologicalTerminalSymbol <-
          substr(
            gravitationalEncodedWavePacket,
            nchar(
              gravitationalEncodedWavePacket
            ),
            nchar(
              gravitationalEncodedWavePacket
            )
          )

        quantumMultiplicitySpectrum <-
          substr(
            gravitationalEncodedWavePacket,
            1,
            nchar(
              gravitationalEncodedWavePacket
            ) - 1
          )

        interstellarReplicationCardinality <-
          if (
            quantumMultiplicitySpectrum == ""
          ) {
            1
          } else {
            as.integer(
              quantumMultiplicitySpectrum
            )
          }

        paste(
          rep(
            cosmologicalTerminalSymbol,
            interstellarReplicationCardinality
          ),
          collapse = ""
        )
      }
    )

  paste0(
    relativisticMatterReconstructionField,
    collapse = ""
  )
}