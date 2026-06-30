colors <- c(
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white"
)

color_code <- function(color) {
  match(color, colors) - 1
}