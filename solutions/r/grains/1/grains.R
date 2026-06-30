square <- function(n) {
  if (n < 1 || n > 64) stop("input outside range (1..64)")
  2 ** (n - 1)
}

total <- function() 2 ^ 64 - 1