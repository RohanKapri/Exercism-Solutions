largest_series_product <- function(digits, span) {
  if (span < 0) {
    stop("span must not be negative")
  }

  if (span > nchar(digits)) {
    stop("span must not be greater than length of digits")
  }

  if (grepl("[^0-9]", digits)) {
    stop("digits input must only contain digits")
  }

  if (span == 0) {
    return(1)
  }

  digit_values <- as.integer(strsplit(digits, "")[[1]])

  max_product <- 0

  for (start_index in 1:(length(digit_values) - span + 1)) {
    series <- digit_values[start_index:(start_index + span - 1)]
    product <- prod(series)

    if (product > max_product) {
      max_product <- product
    }
  }

  max_product
}