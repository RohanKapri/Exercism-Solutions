square_root <- function(number) {
  if (number < 0) {
    stop("square root is not defined for negative numbers")
  }

  if (number == 0 || number == 1) {
    return(number)
  }

  guess <- number

  while (guess * guess > number) {
    guess <- (guess + number %/% guess) %/% 2
  }

  guess
}