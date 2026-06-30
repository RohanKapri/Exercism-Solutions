
random_planet_class <- function(number_needed) {
  planetary_classes <- c("D", "H", "J", "K", "L", "M", "N", "R", "T", "Y")
  
  sample(planetary_classes, size = number_needed, replace = TRUE)
}

random_ship_registry_number <- function() {
  random_number <- sample(1000:9999, size = 1)

  paste0("NCC-", random_number)
}

shuffle_starships <- function(starships) {
  sample(starships)
}


random_stardate <- function() {

  runif(n = 1, min = 41000.0, max = 42000.0)
}