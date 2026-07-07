triangle <- function(x, y, z) {
  sides <- c(x, y, z)
  
  # 1. Validation: All sides must be greater than zero
  if (any(sides <= 0)) {
    stop("All side lengths must be greater than zero.")
  }
  
  # 2. Validation: Triangle Inequality must hold
  # Sort sides to easily check if the sum of the two smaller sides is >= the largest side
  sorted_sides <- sort(sides)
  if (sorted_sides[1] + sorted_sides[2] < sorted_sides[3]) {
    stop("The given side lengths violate the triangle inequality.")
  }
  
  # 3. Determine the triangle classification
  # Count unique side lengths
  num_unique <- length(unique(sides))
  
  classes <- c()
  if (num_unique == 1) {
    # Equilateral triangles are also isosceles
    classes <- c("equilateral", "isosceles")
  } else if (num_unique == 2) {
    classes <- c("isosceles")
  } else {
    classes <- c("scalene")
  }
  
  # Append a base class "triangle"
  classes <- c(classes, "triangle")
  
  # Create a simple S3 object (a list containing the sides) and assign the classes
  obj <- list(sides = sides)
  class(obj) <- classes
  
  return(obj)
}