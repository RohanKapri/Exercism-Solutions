is_pangram <- function(input) {
  # Convert the input string to lowercase
  input_lower <- tolower(input)
  
  # Split the string into individual characters
  chars <- strsplit(input_lower, "")[[1]]
  
  # Check if all 26 letters of the English alphabet are present in the characters
  all(letters %in% chars)
}