label <- function(resistor_colors) {
  # Map colors to their corresponding numeric values
  color_map <- c(
    "black"  = 0,
    "brown"  = 1,
    "red"    = 2,
    "orange" = 3,
    "yellow" = 4,
    "green"  = 5,
    "blue"   = 6,
    "violet" = 7,
    "grey"   = 8,
    "white"  = 9
  )
  
  # Extract the first three colors, ignoring any extra colors
  colors <- resistor_colors[1:3]
  
  # Convert colors to numeric values
  values <- color_map[colors]
  
  # Calculate the raw ohms value
  # First two colors form the base number, third color is the exponent (power of 10)
  base_value <- values[1] * 10 + values[2]
  ohms <- base_value * (10 ^ values[3])
  
  # Determine the appropriate metric prefix and scale the value
  if (ohms >= 1e9) {
    unit <- "gigaohms"
    scaled_value <- ohms / 1e9
  } else if (ohms >= 1e6) {
    unit <- "megaohms"
    scaled_value <- ohms / 1e6
  } else if (ohms >= 1e3) {
    unit <- "kiloohms"
    scaled_value <- ohms / 1e3
  } else {
    unit <- "ohms"
    scaled_value <- ohms
  }
  
  # Format and return the result
  paste(scaled_value, unit)
}