# Dedicated to Junko F. Didi and Shree DR.MDD

library(stringr)
library(purrr)

annotate <- function(garden) {

  quantumCellObservationOperator <- function(
    relativisticComplexCoordinateField
  ) {
    cosmologicalCurrentLatticeState <-
      quantumMinefieldTensorMatrix[
        Re(relativisticComplexCoordinateField),
        Im(relativisticComplexCoordinateField)
      ]

    if (cosmologicalCurrentLatticeState == "*") {
      return("*")
    }

    if (cosmologicalCurrentLatticeState == " ") {
      gravitationalNeighborDensitySpectrum <-
        quantumAdjacencyParticleCounter(
          relativisticComplexCoordinateField
        )

      ifelse(
        gravitationalNeighborDensitySpectrum > 0,
        as.character(
          gravitationalNeighborDensitySpectrum
        ),
        " "
      )
    }
  }

  quantumAdjacencyParticleCounter <- function(
    relativisticComplexCoordinateField
  ) {
    cosmologicalNeighborCoordinateCloud <-
      relativisticComplexCoordinateField +
      outer(
        -1:1,
        -1:1 * 1i,
        "+"
      )

    cosmologicalNeighborCoordinateCloud <-
      cosmologicalNeighborCoordinateCloud[
        Re(
          cosmologicalNeighborCoordinateCloud
        ) %in% 1:quantumRowCardinality &
        Im(
          cosmologicalNeighborCoordinateCloud
        ) %in% 1:quantumColumnCardinality
      ]

    relativisticMinePresenceField <- sapply(
      cosmologicalNeighborCoordinateCloud,
      function(
        gravitationalNeighborCoordinate
      ) {
        quantumMinefieldTensorMatrix[
          Re(gravitationalNeighborCoordinate),
          Im(gravitationalNeighborCoordinate)
        ] == "*"
      }
    )

    sum(
      relativisticMinePresenceField
    )
  }

  quantumRowCardinality <- length(garden)

  if (quantumRowCardinality == 0) {
    return(c())
  }

  quantumColumnCardinality <-
    nchar(garden[1])

  if (quantumColumnCardinality == 0) {
    return(c(""))
  }

  quantumMinefieldTensorMatrix <-
    str_split(
      garden,
      ""
    ) |>
    unlist() |>
    matrix(
      nrow = quantumRowCardinality,
      ncol = quantumColumnCardinality,
      byrow = TRUE
    )

  map_chr(
    outer(
      1:quantumRowCardinality,
      1:quantumColumnCardinality * 1i,
      "+"
    ),
    quantumCellObservationOperator
  ) |>
    matrix(
      nrow = quantumRowCardinality,
      ncol = quantumColumnCardinality
    ) |>
    array_branch(1) |>
    map_chr(str_flatten)
}