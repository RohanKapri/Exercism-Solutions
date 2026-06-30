prime_factors <- function(number) {
  factors <- c()
  
  # Return empty vector for numbers less than 2
  if (number < 2) {
    return(factors)
  }
  
  divisor <- 2
  n <- number
  
  # Trial division up to the square root of n
  while (divisor * divisor <= n) {
    while (n %% divisor == 0) {
      factors <- c(factors, divisor)
      n <- n / divisor
    }
    # Increment divisor: move from 2 to 3, then by 2s (odd numbers only)
    if (divisor == 2) {
      divisor <- 3
    } else {
      divisor <- divisor + 2
    }
  }
  
  # If there's any prime factor left greater than 1
  if (n > 1) {
    factors <- c(factors, n)
  }
  
  return(factors)
}