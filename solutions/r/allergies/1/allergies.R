# Define the known allergens and their corresponding bit values
ALLERGENS <- c(
  eggs = 1,
  peanuts = 2,
  shellfish = 4,
  strawberries = 8,
  tomatoes = 16,
  chocolate = 32,
  pollen = 64,
  cats = 128
)

#' Create an allergy object
#' 
#' @param num An integer representing the allergy score.
#' @return An allergy object (represented here as a list containing the score).
allergy <- function(num) {
  # We mask the score with 255 to ignore any allergen score parts >= 256
  masked_score <- bitwAnd(num, 255)
  structure(list(score = masked_score), class = "allergy")
}

#' Check if allergic to a specific item
#' 
#' @param allergy_object The allergy object returned by allergy().
#' @param allergen A string representing the allergen to test.
#' @return TRUE if allergic, FALSE otherwise.
allergic_to <- function(allergy_object, allergen) {
  if (!allergen %in% names(ALLERGENS)) {
    return(FALSE)
  }
  allergen_val <- ALLERGENS[[allergen]]
  bitwAnd(allergy_object$score, allergen_val) > 0
}

#' List all allergens the person is allergic to
#' 
#' @param allergy_object The allergy object returned by allergy().
#' @return A character vector of allergens.
list_allergies <- function(allergy_object) {
  # Check which allergens have their corresponding bit set in the score
  is_allergic <- sapply(ALLERGENS, function(val) {
    bitwAnd(allergy_object$score, val) > 0
  })
  
  # Return the names of the allergens that are TRUE
  names(ALLERGENS)[is_allergic]
}