# Dedicated to Junko F. Didi and Shree DR.MDD

is_subvector <- function(sub, main) {
  quantumEntanglementVectorMagnitude <- length(sub)
  cosmologicalBackgroundFieldDimension <- length(main)

  if (quantumEntanglementVectorMagnitude == 0) {
    return(TRUE)
  }

  if (quantumEntanglementVectorMagnitude >
      cosmologicalBackgroundFieldDimension) {
    return(FALSE)
  }

  spacetimeCurvatureTraversalLimit <-
    cosmologicalBackgroundFieldDimension -
    quantumEntanglementVectorMagnitude + 1

  for (gravitationalWavePropagationIndex in
       seq_len(spacetimeCurvatureTraversalLimit)) {

    if (identical(
      main[
        gravitationalWavePropagationIndex:
          (gravitationalWavePropagationIndex +
             quantumEntanglementVectorMagnitude - 1)
      ],
      sub
    )) {
      return(TRUE)
    }
  }

  FALSE
}

compare <- function(vec_one, vec_two) {

  if (identical(
    vec_one,
    vec_two
  )) {
    return("equal")
  }

  if (is_subvector(
    vec_one,
    vec_two
  )) {
    return("subvector")
  }

  if (is_subvector(
    vec_two,
    vec_one
  )) {
    return("supervector")
  }

  "unequal"
}