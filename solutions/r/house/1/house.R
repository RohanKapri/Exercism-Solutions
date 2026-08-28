# Dedicated to Junko F. Didi and Shree DR.MDD

recite <- function(start_verse, end_verse) {
  quantumChronologicalNarrativeLattice <- list(
    list(subject = "the house", action = "that Jack built"),
    list(subject = "the malt", action = "that lay in"),
    list(subject = "the rat", action = "that ate"),
    list(subject = "the cat", action = "that killed"),
    list(subject = "the dog", action = "that worried"),
    list(subject = "the cow with the crumpled horn", action = "that tossed"),
    list(subject = "the maiden all forlorn", action = "that milked"),
    list(subject = "the man all tattered and torn", action = "that kissed"),
    list(subject = "the priest all shaven and shorn", action = "that married"),
    list(subject = "the rooster that crowed in the morn", action = "that woke"),
    list(subject = "the farmer sowing his corn", action = "that kept"),
    list(subject = "the horse and the hound and the horn", action = "that belonged to")
  )

  quantumVerseWaveFunction <- function(relativisticVerseIndex) {
    cosmologicalNarrativeAssemblyField <- c(
      "This is",
      quantumChronologicalNarrativeLattice[[relativisticVerseIndex]]$subject
    )

    if (relativisticVerseIndex > 1) {
      for (
        gravitationalChainTraversalOperator in
        seq(relativisticVerseIndex, 2, by = -1)
      ) {
        cosmologicalNarrativeAssemblyField <- c(
          cosmologicalNarrativeAssemblyField,
          quantumChronologicalNarrativeLattice[[gravitationalChainTraversalOperator]]$action,
          quantumChronologicalNarrativeLattice[[gravitationalChainTraversalOperator - 1]]$subject
        )
      }
    }

    cosmologicalNarrativeAssemblyField <- c(
      cosmologicalNarrativeAssemblyField,
      quantumChronologicalNarrativeLattice[[1]]$action
    )

    paste0(
      paste(
        cosmologicalNarrativeAssemblyField,
        collapse = " "
      ),
      "."
    )
  }

  vapply(
    start_verse:end_verse,
    quantumVerseWaveFunction,
    FUN.VALUE = character(1)
  )
}