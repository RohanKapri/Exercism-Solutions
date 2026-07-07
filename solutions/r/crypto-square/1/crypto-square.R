# 1. Normalizes the input text: removes spaces, punctuation, and converts to lowercase
normalized_plaintext <- function(input) {
  # Convert to lowercase
  lowercased <- tolower(input)
  # Remove all non-alphanumeric characters (keep only a-z and 0-9)
  cleaned <- gsub("[^a-z0-9]", "", lowercased)
  return(cleaned)
}

# 2. Breaks the normalized text into rows of width 'c'
plaintext_segments <- function(input) {
  normalized <- normalized_plaintext(input)
  len <- nchar(normalized)
  
  if (len == 0) {
    return("")
  }
  
  # Determine the dimensions (r, c)
  # We need c >= r, c - r <= 1, and c * r >= len
  # This implies c is approximately ceiling(sqrt(len))
  c_val <- ceiling(sqrt(len))
  
  # Extract segments of length c_val
  segments <- character(0)
  for (i in seq(1, len, by = c_val)) {
    segments <- c(segments, substr(normalized, i, min(i + c_val - 1, len)))
  }
  
  return(segments)
}

# 3. Encodes the text by reading down the columns from left to right (without padding spaces)
encoded <- function(input) {
  normalized <- normalized_plaintext(input)
  len <- nchar(normalized)
  
  if (len == 0) {
    return("")
  }
  
  # Calculate dimensions
  c_val <- ceiling(sqrt(len))
  r_val <- ceiling(len / c_val)
  
  # Pad the normalized string with spaces to reach a perfect r * c length
  padded_normalized <- paste0(normalized, strrep(" ", (r_val * c_val) - len))
  
  # Split into a character vector
  chars <- strsplit(padded_normalized, "")[[1]]
  
  # Arrange characters in a matrix of r_val rows and c_val columns
  char_matrix <- matrix(chars, nrow = r_val, ncol = c_val, byrow = TRUE)
  
  # Read down columns (column-by-column)
  # Since R matrices are column-major by default, we can transpose or extract columns
  # But we want to ignore the trailing spaces for the 'encoded' function (as per test expectations)
  encoded_chars <- character(0)
  for (col in 1:c_val) {
    for (row in 1:r_val) {
      char <- char_matrix[row, col]
      if (char != " ") {
        encoded_chars <- c(encoded_chars, char)
      }
    }
  }
  
  return(paste(encoded_chars, collapse = ""))
}

# 4. Outputs the ciphertext in chunks of length 'r' separated by spaces, with padding
ciphertext <- function(input) {
  normalized <- normalized_plaintext(input)
  len <- nchar(normalized)
  
  if (len == 0) {
    return("")
  }
  
  # Calculate dimensions
  c_val <- ceiling(sqrt(len))
  r_val <- ceiling(len / c_val)
  
  # Pad the normalized string with spaces to reach a perfect r * c length
  padded_normalized <- paste0(normalized, strrep(" ", (r_val * c_val) - len))
  
  # Split into a character vector
  chars <- strsplit(padded_normalized, "")[[1]]
  
  # Arrange characters in a matrix of r_val rows and c_val columns
  char_matrix <- matrix(chars, nrow = r_val, ncol = c_val, byrow = TRUE)
  
  # Read columns to form the chunks
  chunks <- character(c_val)
  for (col in 1:c_val) {
    chunks[col] <- paste(char_matrix[, col], collapse = "")
  }
  
  # Join chunks with a space
  return(paste(chunks, collapse = " "))
}