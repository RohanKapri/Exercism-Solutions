library(lubridate)

# Check if a collection of birthdates contains at least two with the same birthday (month and day)
shared_birthday <- function(birthdates) {
  if (length(birthdates) <= 1) {
    return(FALSE)
  }
  
  # Extract the month and day portion (e.g., "-MM-DD")
  # This ignores the year, allowing us to find shared birthdays across different years.
  birthdays <- substr(birthdates, 6, 10)
  
  # Return TRUE if there are duplicates
  any(duplicated(birthdays))
}

# Generate a vector of random birthdates of length groupsize
# Assumptions: 365 possible birthdays (no leap years), uniformly distributed
random_birthdates <- function(groupsize) {
  if (groupsize == 0) {
    return(character(0))
  }
  
  # We use a non-leap year (e.g., 2001) to satisfy the "not a leap year" requirement
  year_start <- as.Date("2001-01-01")
  
  # Sample uniformly from 0 to 364 to get 365 possible offsets
  offsets <- sample(0:364, size = groupsize, replace = TRUE)
  
  # Generate the dates and convert them to the required "YYYY-MM-DD" character format
  dates <- year_start + offsets
  as.character(dates)
}

# Estimate the probability of at least one shared birthday for a given group size using simulation
estimate_probability_of_shared_birthday <- function(groupsize) {
  if (groupsize <= 1) {
    return(0.0)
  }
  
  # Run 10,000 simulations to get a highly accurate estimate
  num_simulations <- 10000
  successes <- 0
  
  for (i in 1:num_simulations) {
    # Generate random birthdates and check for a duplicate
    birthdates <- random_birthdates(groupsize)
    if (shared_birthday(birthdates)) {
      successes <- successes + 1
    }
  }
  
  # Return the estimated probability
  successes / num_simulations
}