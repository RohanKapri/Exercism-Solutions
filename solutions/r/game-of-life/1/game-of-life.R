tick <- function(cells) {
  r <- nrow(cells)
  c <- ncol(cells)
  
  # Handle empty or 0-dimension matrices
  if (is.null(r) || is.null(c) || r == 0 || c == 0) {
    return(cells)
  }
  
  next_gen <- matrix(0, nrow = r, ncol = c)
  
  for (i in seq_len(r)) {
    for (j in seq_len(c)) {
      # Determine neighbor boundaries (clamped to matrix limits)
      row_indices <- max(1, i - 1):min(r, i + 1)
      col_indices <- max(1, j - 1):min(c, j + 1)
      
      # Sum the submatrix and subtract the cell's own value to get neighbor count
      neighbors <- sum(cells[row_indices, col_indices]) - cells[i, j]
      
      # Apply Conway's Game of Life rules
      if (cells[i, j] == 1) {
        if (neighbors == 2 || neighbors == 3) {
          next_gen[i, j] <- 1
        } else {
          next_gen[i, j] <- 0
        }
      } else {
        if (neighbors == 3) {
          next_gen[i, j] <- 1
        } else {
          next_gen[i, j] <- 0
        }
      }
    }
  }
  
  return(next_gen)
}