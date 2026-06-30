modifier <- function(score) {
  floor((score - 10) / 2)
}

ability <- function() {
  rolls <- sample(1:6, size = 4, replace = TRUE)
  # Sort descending and sum the top 3
  sum(sort(rolls, decreasing = TRUE)[1:3])
}

new_character <- function() {
  strength     <- ability()
  dexterity    <- ability()
  constitution <- ability()
  intelligence <- ability()
  wisdom       <- ability()
  charisma     <- ability()
  
  hitpoints    <- 10 + modifier(constitution)
  
  character <- list(
    strength     = strength,
    dexterity    = dexterity,
    constitution = constitution,
    intelligence = intelligence,
    wisdom       = wisdom,
    charisma     = charisma,
    hitpoints    = hitpoints
  )
  
  # Set class to both "character" and "list" to preserve S3 list behavior
  class(character) <- c("character", "list")
  return(character)
}