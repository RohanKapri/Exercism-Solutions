encode <- function(plaintext) {
  translated <- translate(plaintext)

  starts <- seq(1, nchar(translated), by = 5)
  ends <- pmin(starts + 4, nchar(translated))

  groups <- substring(translated, starts, ends)

  paste(groups, collapse = " ")
}

decode <- function(ciphertext) {
  translate(ciphertext)
}

translate <- function(text) {
  text <- tolower(text)

  characters <- strsplit(text, "")[[1]]

  translated <- character(0)

  for (character in characters) {
    if (grepl("[a-z]", character)) {
      translated <- c(translated, atbash_letter(character))
    } else if (grepl("[0-9]", character)) {
      translated <- c(translated, character)
    }
  }

  paste(translated, collapse = "")
}

atbash_letter <- function(letter) {
  plain <- letters
  cipher <- rev(letters)

  unname(cipher[match(letter, plain)])
}