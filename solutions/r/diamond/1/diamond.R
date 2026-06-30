diamond <- function(letter) {
  letters_up_to_input <- LETTERS[1:match(letter, LETTERS)]
  diamond_letters <- c(
    letters_up_to_input,
    rev(letters_up_to_input[-length(letters_up_to_input)])
  )

  max_index <- match(letter, LETTERS)
  width <- 2 * max_index - 1

  make_row <- function(current_letter) {
    index <- match(current_letter, LETTERS)

    outer_spaces <- max_index - index
    inner_spaces <- 2 * index - 3

    if (current_letter == "A") {
      row <- paste0(
        strrep(" ", outer_spaces),
        current_letter,
        strrep(" ", outer_spaces)
      )
    } else {
      row <- paste0(
        strrep(" ", outer_spaces),
        current_letter,
        strrep(" ", inner_spaces),
        current_letter,
        strrep(" ", outer_spaces)
      )
    }

    row
  }

  rows <- vapply(diamond_letters, make_row, character(1))

  paste(rows, collapse = "\n")
}