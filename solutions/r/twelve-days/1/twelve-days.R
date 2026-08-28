recite <- function(start_verse, end_verse) {
  # Vector of ordinal numbers for each day
  ordinals <- c(
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  )
  
  # Vector of gifts for each day, from 1 to 12
  gifts <- c(
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  )
  
  # Helper function to construct a single verse
  get_verse <- function(n) {
    # Start with the standard opening line for day n
    intro <- paste0("On the ", ordinals[n], " day of Christmas my true love gave to me: ")
    
    if (n == 1) {
      # First verse is unique and doesn't use "and"
      return(paste0(intro, gifts[1]))
    } else {
      # For subsequent verses, reverse the order of gifts from n down to 2
      previous_gifts <- gifts[n:2]
      # Collapse them with a comma and space
      gifts_str <- paste(previous_gifts, collapse = ", ")
      # Append the final gift with ", and "
      full_gifts <- paste0(gifts_str, ", and ", gifts[1])
      return(paste0(intro, full_gifts))
    }
  }
  
  # Generate and return verses from start_verse to end_verse
  sapply(start_verse:end_verse, get_verse)
}