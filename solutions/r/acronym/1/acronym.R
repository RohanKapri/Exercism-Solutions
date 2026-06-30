acronym <- function(input) {
  # Hyphens are word separators
  input <- gsub("-", " ", input)

  # Remove punctuation except whitespace and word characters
  input <- gsub("[^[:alnum:]_[:space:]]", "", input)

  # Underscores are only emphasis, so treat them as removable punctuation
  input <- gsub("_", "", input)

  words <- unlist(strsplit(input, "\\s+"))
  words <- words[words != ""]

  letters <- substr(words, 1, 1)

  paste0(toupper(letters), collapse = "")
}