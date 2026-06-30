find <- function(haystack, needle) {
  left <- 1
  right <- length(haystack)

  while (left <= right) {
    middle <- floor((left + right) / 2)

    if (haystack[middle] == needle) {
      return(middle)
    } else if (haystack[middle] < needle) {
      left <- middle + 1
    } else {
      right <- middle - 1
    }
  }

  -1
}