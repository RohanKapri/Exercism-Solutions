score <- function(x, y) {
  distance_squared <- x^2 + y^2
  
  if (distance_squared <= 1^2) {
    10
  } else if (distance_squared <= 5^2) {
    5
  } else if (distance_squared <= 10^2) {
    1
  } else {
    0
  }
}