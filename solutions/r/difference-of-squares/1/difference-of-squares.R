# this is a stub function that takes a natural_number
# and should return the difference-of-squares as described
# in the README.md
difference_of_squares <- function(natural_number) {
  square_of_sum <- (natural_number * (natural_number + 1 ) / 2)^2
  sum_of_square <- (natural_number * (natural_number + 1 ) * (2 * natural_number + 1 ) / 6)
  return(square_of_sum - sum_of_square)
}