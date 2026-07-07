egg_count <- function(display_value) {
  count <- 0

  while (display_value > 0) {
    count <- count + display_value %% 2
    display_value <- display_value %/% 2
  }

  count
}