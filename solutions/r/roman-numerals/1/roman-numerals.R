roman <- function(arabic) {
  # Define the mapping of Arabic values to Roman numerals in descending order
  lookup <- c(
    "1000" = "M",
    "900"  = "CM",
    "500"  = "D",
    "400"  = "CD",
    "100"  = "C",
    "90"   = "XC",
    "50"   = "L",
    "40"   = "XL",
    "10"   = "X",
    "9"    = "IX",
    "5"    = "V",
    "4"    = "IV",
    "1"    = "I"
  )
  
  # Extract the numeric values (as integers) and their corresponding Roman symbols
  values <- as.integer(names(lookup))
  symbols <- unname(lookup)
  
  result <- ""
  remaining <- arabic
  
  # Iterate through the values and construct the Roman numeral string
  for (i in seq_along(values)) {
    val <- values[i]
    sym <- symbols[i]
    
    # While the remaining number is greater than or equal to the current value
    while (remaining >= val) {
      result <- paste0(result, sym)
      remaining <- remaining - val
    }
  }
  
  return(result)
}