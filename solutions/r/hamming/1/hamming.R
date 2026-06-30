# This is a stub function to take two strings
# and calculate the hamming distance

flattenList <- function(x) {
  unlist(strsplit(x, split = "")) 
}

hamming <- function(strand1, strand2) {
  stopifnot(nchar(strand1) == nchar(strand2))
  sum(flattenList(strand1) != flattenList(strand2))
}
