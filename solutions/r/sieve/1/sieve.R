sieve <- function(limit) {
  # If the limit is less than 2, there are no prime numbers.
  # Returning NULL matches the test expectation of c().
  if (limit < 2) {
    return(NULL)
  }
  
  # Create a logical vector where TRUE indicates the number (index) is prime.
  # index 1 is not prime, indices 2 to limit are initially assumed prime.
  is_prime <- rep(TRUE, limit)
  is_prime[1] <- FALSE
  
  # Iterate through the numbers up to the limit
  for (p in 2:limit) {
    if (is_prime[p]) {
      # Mark multiples of p as FALSE (not prime)
      # We start at p + p (2 * p) to avoid marking p itself, and step by p.
      # If p + p is greater than limit, seq() will return an empty sequence.
      if (p + p <= limit) {
        multiples <- seq(from = p + p, to = limit, by = p)
        is_prime[multiples] <- FALSE
      }
    }
  }
  
  # Return the indices that are still marked as TRUE
  which(is_prime)
}