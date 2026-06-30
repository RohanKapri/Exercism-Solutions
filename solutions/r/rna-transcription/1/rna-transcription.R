to_rna <- function(dna) {
  if (grepl("[^ACGT]", dna)) {
    stop("Invalid DNA strand")
  }

  chartr("GCTA", "CGAU", dna)
}