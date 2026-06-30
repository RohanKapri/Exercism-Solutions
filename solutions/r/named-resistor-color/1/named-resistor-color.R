resistor_bands <- c(
  black  = 0,
  brown  = 1,
  red    = 2,
  orange = 3,
  yellow = 4,
  green  = 5,
  blue   = 6,
  violet = 7,
  grey   = 8,
  white  = 9
)
band_value <- function(band) {
  unname(resistor_bands[band])
}
two_band_value <- function(bands) {
  first_digit <- band_value(bands[1])
  second_digit <- band_value(bands[2])
  
  first_digit * 10 + second_digit
}
ohms <- function(bands) {
  base_value <- two_band_value(bands[1:2])
  multiplier_power <- band_value(bands[3])
  
  base_value * (10 ^ multiplier_power)
}