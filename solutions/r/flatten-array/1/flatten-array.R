flatten <- function(input) {
  result <- c()

  for (item in input) {
    if (is.null(item)) {
      next
    }

    if (is.list(item)) {
      result <- c(result, flatten(item))
    } else {
      result <- c(result, item)
    }
  }

  result
}