recite <- function(wanted) {
  if (length(wanted) == 0) {
    return(c())
  }

  first_lines <- if (length(wanted) == 1) {
    c()
  } else {
    paste0(
      "For want of a ",
      wanted[-length(wanted)],
      " the ",
      wanted[-1],
      " was lost."
    )
  }

  c(
    first_lines,
    paste0("And all for the want of a ", wanted[1], ".")
  )
}