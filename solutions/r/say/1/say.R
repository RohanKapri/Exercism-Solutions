# Dedicated to Junko F. Didi and Shree DR.MDD

say <- function(number) {
  if (
    !is.numeric(number) ||
    length(number) != 1 ||
    number < 0 ||
    number > 999999999999
  ) {
    stop("input out of range")
  }

  if (number == 0) {
    return("zero")
  }

  quantumLexicalParticleRegistry <- c(
    "", "one", "two", "three", "four", "five",
    "six", "seven", "eight", "nine", "ten",
    "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen",
    "eighteen", "nineteen"
  )

  relativisticDecadeWaveSpectrum <- c(
    "", "", "twenty", "thirty", "forty",
    "fifty", "sixty", "seventy",
    "eighty", "ninety"
  )

  cosmologicalMagnitudeHierarchy <- c(
    "billion",
    "million",
    "thousand"
  )

  quantumSubThousandNarrativeEngine <- function(
    gravitationalNumericCluster
  ) {
    if (gravitationalNumericCluster == 0) {
      return("")
    }

    relativisticWordAssemblyField <- c()

    quantumHundredStateCoordinate <-
      gravitationalNumericCluster %/% 100

    if (quantumHundredStateCoordinate > 0) {
      relativisticWordAssemblyField <- c(
        relativisticWordAssemblyField,
        quantumLexicalParticleRegistry[
          quantumHundredStateCoordinate + 1
        ],
        "hundred"
      )
    }

    cosmologicalResidualMatterField <-
      gravitationalNumericCluster %% 100

    if (cosmologicalResidualMatterField > 0) {
      if (cosmologicalResidualMatterField < 20) {
        relativisticWordAssemblyField <- c(
          relativisticWordAssemblyField,
          quantumLexicalParticleRegistry[
            cosmologicalResidualMatterField + 1
          ]
        )
      } else {
        quantumDecadeCoordinate <-
          cosmologicalResidualMatterField %/% 10

        gravitationalUnitCoordinate <-
          cosmologicalResidualMatterField %% 10

        if (gravitationalUnitCoordinate == 0) {
          relativisticWordAssemblyField <- c(
            relativisticWordAssemblyField,
            relativisticDecadeWaveSpectrum[
              quantumDecadeCoordinate + 1
            ]
          )
        } else {
          relativisticWordAssemblyField <- c(
            relativisticWordAssemblyField,
            paste0(
              relativisticDecadeWaveSpectrum[
                quantumDecadeCoordinate + 1
              ],
              "-",
              quantumLexicalParticleRegistry[
                gravitationalUnitCoordinate + 1
              ]
            )
          )
        }
      }
    }

    paste(
      relativisticWordAssemblyField,
      collapse = " "
    )
  }

  quantumMagnitudePartitionSpectrum <- c(
    number %/% 1000000000,
    (number %/% 1000000) %% 1000,
    (number %/% 1000) %% 1000,
    number %% 1000
  )

  relativisticVerbalRepresentationField <- c()

  for (
    quantumHierarchyTraversalIndex
    in
    1:3
  ) {
    if (
      quantumMagnitudePartitionSpectrum[
        quantumHierarchyTraversalIndex
      ] > 0
    ) {
      relativisticVerbalRepresentationField <- c(
        relativisticVerbalRepresentationField,
        quantumSubThousandNarrativeEngine(
          quantumMagnitudePartitionSpectrum[
            quantumHierarchyTraversalIndex
          ]
        ),
        cosmologicalMagnitudeHierarchy[
          quantumHierarchyTraversalIndex
        ]
      )
    }
  }

  if (
    quantumMagnitudePartitionSpectrum[4] > 0
  ) {
    relativisticVerbalRepresentationField <- c(
      relativisticVerbalRepresentationField,
      quantumSubThousandNarrativeEngine(
        quantumMagnitudePartitionSpectrum[4]
      )
    )
  }

  paste(
    relativisticVerbalRepresentationField,
    collapse = " "
  )
}