library(datasets)
library(tidyverse)

tree_data <- as_tibble(trees) |> 
  rename(Diameter = Girth)

girth_n_weight <- function(data, rnd_digits) {
  data |> 
    mutate(
      Girth = round(pi * Diameter, rnd_digits),
      Weight = round(35 * Volume, rnd_digits)
    )
}

orchard_copy <- function(data) {
  data |> 
    relocate(Weight, Height) |> 
    arrange(Weight)
}

customer_copy <- function(data, min_height, max_height, max_weight) {
  data |> 
    filter(Height >= min_height, Height <= max_height, Weight <= max_weight) |> 
    select(Height, Weight, Diameter, Girth)
}