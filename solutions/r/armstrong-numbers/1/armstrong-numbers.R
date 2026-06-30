is_armstrong_number <- function(n) {
  # Convert the number to a string to easily extract individual digits
  digits_char <- strsplit(as.character(n), "")[[1]]
  
  # Convert the characters back to numeric digits
  digits <- as.numeric(digits_char)
  
  # The exponent is the number of digits
  num_digits <- length(digits)
  
  # Calculate the sum of each digit raised to the power of num_digits
  armstrong_sum <- sum(digits ^ num_digits)
  
  # Return TRUE if the sum equals the original number, FALSE otherwise
  return(armstrong_sum == n)
}