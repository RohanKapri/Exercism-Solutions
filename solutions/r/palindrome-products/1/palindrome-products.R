is_palindrome <- function(n) {
  s <- as.character(n)
  chars <- strsplit(s, "")[[1]]
  all(chars == rev(chars))
}

palindrome_products <- function(input) {
  # Convert to numeric to prevent integer overflow for large numbers
  min_val <- as.numeric(input$min)
  max_val <- as.numeric(input$max)
  
  if (min_val > max_val) {
    stop("min cannot be greater than max")
  }
  
  # Initialize results
  smallest_val <- NULL
  smallest_factors <- list()
  
  largest_val <- NULL
  largest_factors <- list()
  
  # --- FIND SMALLEST PALINDROME ---
  for (i in seq(min_val, max_val, by = 1)) {
    # Pruning: if the minimum possible product for this i (i * i) 
    # is larger than the smallest palindrome found, we can stop.
    if (!is.null(smallest_val) && (i * i) > smallest_val) {
      break
    }
    
    for (j in seq(i, max_val, by = 1)) {
      prod <- i * j
      
      # Pruning: if the product exceeds our current smallest palindrome,
      # increasing j further will only make it larger.
      if (!is.null(smallest_val) && prod > smallest_val) {
        break
      }
      
      if (is_palindrome(prod)) {
        if (is.null(smallest_val) || prod < smallest_val) {
          smallest_val <- prod
          smallest_factors <- list(c(i, j))
        } else if (prod == smallest_val) {
          smallest_factors[[length(smallest_factors) + 1]] <- c(i, j)
        }
      }
    }
  }
  
  # --- FIND LARGEST PALINDROME ---
  for (i in seq(max_val, min_val, by = -1)) {
    # Pruning: if the maximum possible product for this i (i * max_val)
    # is smaller than the largest palindrome found, we can stop.
    if (!is.null(largest_val) && (i * max_val) < largest_val) {
      break
    }
    
    for (j in seq(max_val, i, by = -1)) {
      prod <- i * j
      
      # Pruning: if the product is smaller than our current largest palindrome,
      # decreasing j further will only make it smaller.
      if (!is.null(largest_val) && prod < largest_val) {
        break
      }
      
      if (is_palindrome(prod)) {
        if (is.null(largest_val) || prod > largest_val) {
          largest_val <- prod
          largest_factors <- list(c(i, j))
        } else if (prod == largest_val) {
          factor_pair <- if (i <= j) c(i, j) else c(j, i)
          # Avoid duplicate factor pairs
          if (!any(sapply(largest_factors, function(x) all(x == factor_pair)))) {
            largest_factors[[length(largest_factors) + 1]] <- factor_pair
          }
        }
      }
    }
  }
  
  # Helper to sort factors in ascending order
  sort_factors <- function(factors_list) {
    if (length(factors_list) <= 1) return(factors_list)
    sorted_pairs <- lapply(factors_list, sort)
    order_idx <- order(sapply(sorted_pairs, `[`, 1), sapply(sorted_pairs, `[`, 2))
    sorted_pairs[order_idx]
  }

  list(
    smallest = list(
      value = smallest_val,
      factors = sort_factors(smallest_factors)
    ),
    largest = list(
      value = largest_val,
      factors = sort_factors(largest_factors)
    )
  )
}