is_isogram <- function(word) {
  # Convert to lowercase
  clean_word <- tolower(word)
  
  # Remove all characters that are not letters (e.g., spaces and hyphens)
  # [^a-z] matches any character that is not a lowercase letter from a to z
  clean_word <- gsub("[^a-z]", "", clean_word)
  
  # Split the string into a vector of individual characters
  chars <- strsplit(clean_word, "")[[1]]
  
  # If the string is empty, it is an isogram by definition
  if (length(chars) == 0) {
    return(TRUE)
  }
  
  # Check if the number of unique characters equals the total number of characters
  length(unique(chars)) == length(chars)
}