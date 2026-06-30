keep <- function(input, fun) {
  kept_indices <- c()

  for (index in seq_along(input)) {
    if (fun(input[[index]])) {
      kept_indices <- c(kept_indices, index)
    }
  }

  input[kept_indices]
}

discard <- function(input, fun) {
  keep(input, function(x) !fun(x))
}