slices <- function(series, slice_length) {
  # Get the length of the input series string
  series_length <- nchar(series)
  
  # Error handling: Empty series is invalid
  if (series_length == 0) {
    stop("Series cannot be empty.")
  }
  
  # Error handling: Slice length cannot be zero or negative
  if (slice_length <= 0) {
    stop("Slice length must be greater than 0.")
  }
  
  # Error handling: Slice length cannot be larger than the series length
  if (slice_length > series_length) {
    stop("Slice length cannot be greater than the length of the series.")
  }
  
  # Calculate the starting positions for each slice
  starts <- 1:(series_length - slice_length + 1)
  
  # Calculate the ending positions for each slice
  ends <- starts + slice_length - 1
  
  # Extract substrings using vectorised substring()
  substring(series, starts, ends)
}