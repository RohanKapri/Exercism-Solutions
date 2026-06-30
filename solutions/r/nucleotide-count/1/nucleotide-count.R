nucleotide_count <- function(input) {
  # 1. Handle empty input
  if (input == "") {
    return(list(A = 0, C = 0, G = 0, T = 0))
  }
  
  # 2. Split the input string into individual characters
  nucleotides <- strsplit(input, "")[[1]]
  
  # 3. Check for any invalid characters (anything other than A, C, G, or T)
  invalid_chars <- nucleotides[!nucleotides %in% c("A", "C", "G", "T")]
  if (length(invalid_chars) > 0) {
    stop("Invalid nucleotide found in DNA sequence.")
  }
  
  # 4. Count the occurrences of each nucleotide
  counts <- table(factor(nucleotides, levels = c("A", "C", "G", "T")))
  
  # 5. Convert the named table/vector into a list
  as.list(counts)
}