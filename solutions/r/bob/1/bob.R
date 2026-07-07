bob <- function(input) {
  # 1. Trim leading and trailing whitespace characters
  trimmed <- gsub("^[[:space:]]+|[[:space:]]+$", "", input)
  
  # 2. Check if the input is silent (empty after trimming whitespace)
  is_silence <- nchar(trimmed) == 0
  
  if (is_silence) {
    return("Fine. Be that way!")
  }
  
  # 3. Check if the input ends with a question mark
  is_question <- grepl("\\?$", trimmed)
  
  # 4. Check if the input is yelled (has letters, and all letters are uppercase)
  # grepl("[[:alpha:]]", trimmed) ensures there is at least one letter
  is_yelling <- (trimmed == toupper(trimmed)) && grepl("[[:alpha:]]", trimmed)
  
  # 5. Determine Bob's response based on the conditions
  if (is_yelling && is_question) {
    return("Calm down, I know what I'm doing!")
  } else if (is_yelling) {
    return("Whoa, chill out!")
  } else if (is_question) {
    return("Sure.")
  } else {
    return("Whatever.")
  }
}