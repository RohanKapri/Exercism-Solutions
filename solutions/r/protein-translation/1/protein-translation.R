dict = list(
    AUG = "Methionine", UUU = "Phenylalanine", UUC = "Phenylalanine",
    UUA = "Leucine", UUG = "Leucine", UCU = "Serine", UCC = "Serine",
    UCA = "Serine", UCG = "Serine", UAU = "Tyrosine", UAC = "Tyrosine",
    UGU = "Cysteine", UGC = "Cysteine", UGG = "Tryptophan", UAA = "STOP",
    UAG = "STOP", UGA = "STOP")

translate = function(bases) {
  if (nchar(bases) == 0) return(NULL)
  codons = strsplit(bases, "(?<=.{3})", perl = TRUE)[[1]]
  output = c()
  for (codon in codons) {
    if (nchar(codon) != 3) stop("Invalid codon")
    amino_acid = dict[[codon]]
    if (is.null(amino_acid)) stop("Invalid codon")
    if (amino_acid == "STOP") break
    output = append(output, amino_acid)
  }
  output
}
