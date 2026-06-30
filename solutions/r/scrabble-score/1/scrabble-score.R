scrabble_score <- function(input) {
  # Handle empty input or NULL
  if (is.null(input) || input == "") {
    return(0)
  }
  
  # Define the score mapping for each letter
  scores <- c(
    A = 1, E = 1, I = 1, O = 1, U = 1, L = 1, N = 1, R = 1, S = 1, T = 1,
    D = 2, G = 2,
    B = 3, C = 3, M = 3, P = 3,
    F = 4, H = 4, V = 4, W = 4, Y = 4,
    K = 5,
    J = 8, X = 8,
    Q = 10, Z = 10
  )
  
  # Convert input to uppercase and split into individual characters
  letters_vec <- strsplit(toupper(input), "")[[1]]
  
  # Look up the score for each letter and sum them
  sum(scores[letters_vec], na.rm = TRUE)
}