# function to sort letters of a string in A to Z order
string_sort <- function (s) paste(sort(unlist(strsplit(s, ""))), collapse = "")

anagram <- function(subject, candidates) {
  # convert subject and candidate strings to uppercase so that anagram detection is case insensitive
  subject_upper <- toupper(subject)
  candidates_upper <- toupper(candidates)

  # sort letters of subject and candidate strings in A to Z order to detect anagrams
  # (after sorting, anagram strings should become identical)
  subject_upper_sorted <- string_sort(subject_upper)
  candidates_upper_sorted <- sapply(candidates_upper, string_sort)

  # find and return anagrams, not counting a string as its anagram
  result <- candidates[subject_upper != candidates_upper & subject_upper_sorted == candidates_upper_sorted]
  if (length(result) > 0) {
    result
  } else {
    c()
  }
}