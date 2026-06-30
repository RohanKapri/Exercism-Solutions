combinations <- function(size, goal_sum, exclude) {
  # The pool of available digits in Sudoku is 1 to 9
  digits <- 1:9
  
  # Remove the excluded digits from our pool
  available_digits <- setdiff(digits, exclude)
  
  # If the size is larger than the number of available digits,
  # or if size is 0, no combinations are possible.
  if (size <= 0 || size > length(available_digits)) {
    return(list())
  }
  
  # Generate all combinations of the given size from the available digits.
  # utils::combn returns a matrix where each column is a combination.
  # The combinations are automatically generated in lexicographically sorted order.
  comb_matrix <- combn(available_digits, size)
  
  # Calculate the sum of each combination (each column)
  sums <- colSums(comb_matrix)
  
  # Filter the columns where the sum matches the goal_sum
  valid_cols <- which(sums == goal_sum)
  
  # Convert the matching columns into a list of vectors
  result <- lapply(valid_cols, function(col_idx) {
    # Each combination is already sorted because available_digits is sorted (1:9)
    comb_matrix[, col_idx]
  })
  
  return(result)
}