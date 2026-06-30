pascals_triangle <- function(n) {
  # Handle invalid inputs (NULL or negative)
  if (is.null(n) || !is.numeric(n) || n < 0) {
    stop("n must be a non-negative integer")
  }
  
  # Handle 0 rows
  if (n == 0) {
    return(list())
  }
  
  # Initialize the list with the first row
  triangle <- list(1)
  
  # Compute subsequent rows if n > 1
  if (n > 1) {
    for (i in 2:n) {
      prev_row <- triangle[[i - 1]]
      # Compute the new row by adding shifted versions of the previous row
      new_row <- c(0, prev_row) + c(prev_row, 0)
      triangle[[i]] <- new_row
    }
  }
  
  return(triangle)
}