
scale <- function(point, s) {
  point * s
}


translate <- function(point, ...) {
  point + c(...)
}

transform2d <- function(dx, dy, s = 1) {
  function(point) {
    translated_point <- translate(point, dx, dy)
    scale(translated_point, s)
  }
}

transform3d <- function(dx, dy, dz, s = 1) {
  function(point) {
    translated_point <- translate(point, dx, dy, dz)
    scale(translated_point, s)
  }
}