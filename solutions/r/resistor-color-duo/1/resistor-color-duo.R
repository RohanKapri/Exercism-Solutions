value <- function(resistor_colors) {
  color_values <- c(
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9
  )

  digits <- unname(color_values[resistor_colors[1:2]])

  digits[1] * 10 + digits[2]
}