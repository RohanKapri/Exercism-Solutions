# Helper to generate all 120 permutations of 1:5 in base R (dependency-free)
get_perms <- function() {
  perm_recurse <- function(x) {
    if (length(x) == 1) return(matrix(x, 1, 1))
    do.call(rbind, lapply(seq_along(x), function(i) {
      cbind(x[i], perm_recurse(x[-i]))
    }))
  }
  perm_recurse(1:5)
}

solve_zebra <- function() {
  perms <- get_perms()

  # --- 1. Colors ---
  colors <- perms
  colnames(colors) <- c("Red", "Green", "Ivory", "Yellow", "Blue")
  # Constraint: Green is immediately to the right of Ivory (Green = Ivory + 1)
  # Constraint: Norwegian (house 1) lives next to Blue house -> Blue must be house 2
  colors <- colors[colors[, "Green"] - colors[, "Ivory"] == 1 & colors[, "Blue"] == 2, , drop = FALSE]

  # --- 2. Nationalities ---
  nats <- perms
  colnames(nats) <- c("Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese")
  # Constraint: The Norwegian lives in the first house
  nats <- nats[nats[, "Norwegian"] == 1, , drop = FALSE]

  # --- 3. Join Colors & Nationalities ---
  # Constraint: Englishman lives in the Red house
  idx <- which(outer(colors[, "Red"], nats[, "Englishman"], `==`), arr.ind = TRUE)
  col_nat <- cbind(colors[idx[, 1], , drop = FALSE], nats[idx[, 2], , drop = FALSE])

  # --- 4. Drinks ---
  drinks <- perms
  colnames(drinks) <- c("Coffee", "Tea", "Milk", "Water", "OrangeJuice")
  # Constraint: The middle house drinks milk
  drinks <- drinks[drinks[, "Milk"] == 3, , drop = FALSE]

  # --- 5. Join (Colors + Nationalities) & Drinks ---
  # Constraints: Green house drinks Coffee; Ukrainian drinks Tea
  idx <- which(outer(col_nat[, "Green"], drinks[, "Coffee"], `==`) &
               outer(col_nat[, "Ukrainian"], drinks[, "Tea"], `==`), arr.ind = TRUE)
  col_nat_drk <- cbind(col_nat[idx[, 1], , drop = FALSE], drinks[idx[, 2], , drop = FALSE])

  # --- 6. Hobbies ---
  hobbies <- perms
  colnames(hobbies) <- c("Dancing", "Painting", "Reading", "Football", "Chess")

  # --- 7. Join (Colors + Nationalities + Drinks) & Hobbies ---
  # Constraints: Yellow house is Painter; Football player drinks Orange Juice; Japanese plays Chess
  idx <- which(outer(col_nat_drk[, "Yellow"], hobbies[, "Painting"], `==`) &
               outer(col_nat_drk[, "OrangeJuice"], hobbies[, "Football"], `==`) &
               outer(col_nat_drk[, "Japanese"], hobbies[, "Chess"], `==`), arr.ind = TRUE)
  col_nat_drk_hb <- cbind(col_nat_drk[idx[, 1], , drop = FALSE], hobbies[idx[, 2], , drop = FALSE])

  # --- 8. Pets ---
  pets <- perms
  colnames(pets) <- c("Dog", "Snail", "Fox", "Horse", "Zebra")

  # --- 9. Final Join & Constraints ---
  # Constraints:
  # - Spaniard owns Dog
  # - Snail owner enjoys Dancing
  # - Reader lives next to Fox (abs diff == 1)
  # - Painter lives next to Horse (abs diff == 1)
  idx <- which(outer(col_nat_drk_hb[, "Spaniard"], pets[, "Dog"], `==`) &
               outer(col_nat_drk_hb[, "Dancing"], pets[, "Snail"], `==`) &
               abs(outer(col_nat_drk_hb[, "Reading"], pets[, "Fox"], `-`)) == 1 &
               abs(outer(col_nat_drk_hb[, "Painting"], pets[, "Horse"], `-`)) == 1, arr.ind = TRUE)
  
  solution_matrix <- cbind(col_nat_drk_hb[idx[, 1], , drop = FALSE], pets[idx[, 2], , drop = FALSE])
  return(solution_matrix[1, ])
}

# Cache the solution
solution <- solve_zebra()

drinks_water <- function() {
  water_pos <- solution["Water"]
  nationalities <- c("Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese")
  names(which(solution[nationalities] == water_pos))
}

owns_zebra <- function() {
  zebra_pos <- solution["Zebra"]
  nationalities <- c("Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese")
  names(which(solution[nationalities] == zebra_pos))
}