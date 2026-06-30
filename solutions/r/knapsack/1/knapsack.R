maximum_value <- function(max_weight, items) {
  # If there are no items or the capacity is 0, the maximum value is 0
  if (length(items) == 0 || max_weight == 0) {
    return(0)
  }
  
  # dp array initialized to 0. 
  # R is 1-indexed, so index `j` in R corresponds to capacity `j - 1`.
  # The dp array size will be `max_weight + 1` (representing capacities from 0 to max_weight).
  dp <- rep(0, max_weight + 1)
  
  for (item in items) {
    w <- item$weight
    v <- item$value
    
    # If the item's weight is greater than the max capacity, we can't take it
    if (w > max_weight) {
      next
    }
    
    # Iterate backwards to ensure each item is used at most once.
    # In R indices: capacity `j` is at index `j + 1`.
    # We loop from `max_weight` down to `w`.
    for (j in max_weight:w) {
      dp[j + 1] <- max(dp[j + 1], dp[j - w + 1] + v)
    }
  }
  
  # The maximum value for the full capacity is at index `max_weight + 1`
  return(dp[max_weight + 1])
}