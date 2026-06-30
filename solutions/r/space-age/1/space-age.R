space_age <- function(seconds, planet) {
  seconds_in_year <- 31557600 #31557600 = 365.25 * 24 * 60 * 60
  
  orbital_seconds <- switch(tolower(planet),
                   mercury = 0.2408467,
                   venus = 0.61519726,
                   earth = 1,
                   mars = 1.8808158,
                   jupiter = 11.862615,
                   saturn = 29.447498,
                   uranus = 84.016846,
                   neptune = 164.79132)
  
  round(seconds / (orbital_seconds * seconds_in_year), 2)
}