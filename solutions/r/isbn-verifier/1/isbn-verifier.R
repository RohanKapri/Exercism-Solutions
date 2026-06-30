is_valid <- function(isbn) {
  # Remove all dashes from the input
  clean_isbn <- gsub("-", "", isbn)
  
  # Validate that the format is exactly 9 digits followed by a digit or 'X'/'x'
  if (!grepl("^[0-9]{9}[0-9Xx]$", clean_isbn)) {
    return(FALSE)
  }
  
  # Split the string into individual characters
  chars <- strsplit(clean_isbn, "")[[1]]
  
  # Convert the first 9 digits to numeric
  digits <- as.numeric(chars[1:9])
  
  # Convert the check digit (the 10th character)
  check_char <- chars[10]
  if (check_char == "X" || check_char == "x") {
    check_digit <- 10
  } else {
    check_digit <- as.numeric(check_char)
  }
  
  # Combine into a single vector of 10 values
  all_digits <- c(digits, check_digit)
  
  # Define the weights: 10 down to 1
  weights <- 10:1
  
  # Calculate the weighted sum
  total_sum <- sum(all_digits * weights)
  
  # The ISBN is valid if the sum is divisible by 11
  return(total_sum %% 11 == 0)
}