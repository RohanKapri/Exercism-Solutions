# Determine whether the number is valid.
is_valid <- function(input) {
  # Remove all spaces from the input string
  cleaned <- gsub(" ", "", input)
  
  # Check if the cleaned string has a length of 1 or less
  if (nchar(cleaned) <= 1) {
    return(FALSE)
  }
  
  # Check if the cleaned string contains any non-digit characters
  if (grepl("[^0-9]", cleaned)) {
    return(FALSE)
  }
  
  # Split the string into individual numeric digits
  digits <- as.integer(strsplit(cleaned, "")[[1]])
  
  # Reverse the digits to easily find every second digit starting from the right
  rev_digits <- rev(digits)
  
  # Identify the indices of every second digit (2nd, 4th, 6th, etc. from the right)
  double_indices <- seq(2, length(rev_digits), by = 2)
  
  # Double those digits
  rev_digits[double_indices] <- rev_digits[double_indices] * 2
  
  # If the doubled digit is greater than 9, subtract 9
  rev_digits[double_indices] <- ifelse(rev_digits[double_indices] > 9, 
                                       rev_digits[double_indices] - 9, 
                                       rev_digits[double_indices])
  
  # Sum all the digits
  total_sum <- sum(rev_digits)
  
  # The input is valid if the sum is evenly divisible by 10
  return(total_sum %% 10 == 0)
}