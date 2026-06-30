sum_of_multiples <- function(factors, limit) {
  # If factors is empty or limit is too small to have multiples, return 0
  if (length(factors) == 0 || limit <= 1) {
    return(0)
  }
  
  # Filter out 0 from factors to avoid infinite loops or division by zero
  factors <- factors[factors > 0]
  
  # If no valid factors remain, return 0
  if (length(factors) == 0) {
    return(0)
  }
  
  # Find all multiples for each factor that are strictly less than the limit
  multiples <- lapply(factors, function(f) {
    if (f >= limit) {
      return(integer(0)) # No multiples less than limit
    }
    seq(from = f, to = limit - 1, by = f)
  })
  
  # Combine all lists, extract unique values, and sum them
  unique_multiples <- unique(unlist(multiples))
  
  return(sum(unique_multiples))
}