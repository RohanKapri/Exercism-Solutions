etl <- function(input) {
  # If the input list is empty, return an empty list
  if (length(input) == 0) {
    return(list())
  }
  
  # Initialize an empty list to store the output
  output <- list()
  
  # Get the legacy scores (the names of the input list)
  scores <- names(input)
  
  # Iterate over each score and its associated letters
  for (score in scores) {
    # Convert the score to an integer
    score_val <- as.integer(score)
    
    # Get the letters for this score
    letters <- input[[score]]
    
    # For each letter, convert it to lowercase and assign the score
    for (letter in letters) {
      lowercase_letter <- tolower(letter)
      output[[lowercase_letter]] <- score_val
    }
  }
  
  # Sort the list by its names alphabetically to match the expected output
  output <- output[order(names(output))]
  
  return(output)
}