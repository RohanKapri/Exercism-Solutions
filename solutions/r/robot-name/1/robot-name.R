# Global registry to store currently active robot names and prevent collisions
active_names <- new.env(parent = emptyenv())

# Helper function to generate a random unique name in the format AA111
generate_unique_name <- function() {
  repeat {
    letters_part <- paste0(sample(LETTERS, 2, replace = TRUE), collapse = "")
    digits_part  <- paste0(sample(0:9, 3, replace = TRUE), collapse = "")
    candidate_name <- paste0(letters_part, digits_part)
    
    # Check if the name is already in use
    if (!exists(candidate_name, envir = active_names)) {
      # Register the name
      assign(candidate_name, TRUE, envir = active_names)
      return(candidate_name)
    }
  }
}

# Constructor for a new robot (using a list instead of an environment)
new_robot <- function() {
  robot <- list(name = generate_unique_name())
  class(robot) <- "robot"
  return(robot)
}

# Reset function to wipe the current name and assign a new unique one
reset_robot <- function(robot) {
  old_name <- robot$name
  
  # Remove the old name from the active registry to free it up
  if (!is.null(old_name) && exists(old_name, envir = active_names)) {
    rm(list = old_name, envir = active_names)
  }
  
  # Assign a new unique name and return a new robot list object
  robot$name <- generate_unique_name()
  return(robot)
}