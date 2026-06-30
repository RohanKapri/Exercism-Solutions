recite <- function(start_bottles, take_down) {
  # Map numbers to their English title-case equivalents
  num_words <- c("no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten")
  
  # Helper function to generate a single verse
  get_verse <- function(n) {
    # Capitalize the first letter of the number word for the start of lines
    current_word <- num_words[n + 1]
    current_cap <- paste0(toupper(substring(current_word, 1, 1)), substring(current_word, 2))
    
    next_word <- num_words[n]
    
    # Singular vs. plural handling for "bottle" vs "bottles"
    current_bottle_str <- if (n == 1) "bottle" else "bottles"
    next_bottle_str <- if (n - 1 == 1) "bottle" else "bottles"
    
    line1_2 <- paste0(current_cap, " green ", current_bottle_str, " hanging on the wall,")
    line3   <- "And if one green bottle should accidentally fall,"
    line4   <- paste0("There'll be ", next_word, " green ", next_bottle_str, " hanging on the wall.")
    
    return(c(line1_2, line1_2, line3, line4))
  }
  
  # Generate all required verses in descending order
  verses <- list()
  for (i in seq_len(take_down)) {
    current_bottles <- start_bottles - i + 1
    verses[[i]] <- get_verse(current_bottles)
  }
  
  # Collapse each verse with newlines, and join multiple verses with a blank line
  verse_strings <- sapply(verses, function(v) paste(v, collapse = "\n"))
  full_song <- paste(verse_strings, collapse = "\n\n")
  
  return(full_song)
}