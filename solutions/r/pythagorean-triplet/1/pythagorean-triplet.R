pythagorean_triplet <- function(n) {
  triplets <- list()
  
  # The maximum possible value for `a` because a < b < c and a + b + c = n
  max_a <- floor((n - 1) / 3)
  
  if (max_a < 1) {
    return(triplets)
  }
  
  for (a in 1:max_a) {
    numerator <- n^2 - 2 * n * a
    denominator <- 2 * (n - a)
    
    # Check if b is an integer
    if (numerator %% denominator == 0) {
      b <- numerator / denominator
      c <- n - a - b
      
      # Ensure the ordering constraint a < b < c is satisfied
      if (a < b && b < c) {
        triplets[[length(triplets) + 1]] <- c(a, b, c)
      }
    }
  }
  
  return(triplets)
}