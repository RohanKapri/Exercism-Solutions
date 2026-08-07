is_paired <- function(input) {
  opening_brackets <- c("(", "[", "{")
  closing_brackets <- c(")", "]", "}")
  matching_opening <- c(
    ")" = "(",
    "]" = "[",
    "}" = "{"
  )
  characters <- strsplit(input, "")[[1]]
  stack <- character(0)
  for (character in characters) {
    if (character %in% opening_brackets) {
      stack <- c(stack, character)
    } else if (character %in% closing_brackets) {
      if (length(stack) == 0) {
        return(FALSE)
      }
      last_opening <- stack[length(stack)]
      if (last_opening != matching_opening[character]) {
        return(FALSE)
      }
      stack <- stack[-length(stack)]
    }
  }
  length(stack) == 0
}